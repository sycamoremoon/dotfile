import http.server
import ssl
import hashlib
import os
import time
import argparse
from base64 import b64decode
from auth_config import load_users

# ================== Configuration Area ==================
MAX_ATTEMPTS = 5  # Maximum allowed failed attempts
LOCK_TIME = 600    # Account lockout time (seconds)
USERS = load_users()

# =============================================

# Track login failures {username: (failed attempts, lockout expiration timestamp)}
FAILED_ATTEMPTS = {}

class AuthHandler(http.server.SimpleHTTPRequestHandler):
  def do_GET(self):
    auth_header = self.headers.get('Authorization', '')
    if not self.authenticated(auth_header):
      self.send_auth_required()
    else:
      super().do_GET()

  def authenticated(self, auth_header):
    """ Authentication process with account lockout check """
    if not auth_header.startswith('Basic '):
      return False

    try:
      # Decode credentials
      encoded = auth_header.split(' ')[1]
      decoded = b64decode(encoded).decode('utf-8')
      username, password = decoded.split(':', 1)

      # Check if the account is locked
      if self.is_account_locked(username):
        print(f"account {username} locked up")
        return False

      # Verify user credentials
      if self.validate_credentials(username, password):
        # Reset failure counter on success
        FAILED_ATTEMPTS.pop(username, None)
        return True
      else:
        # Record failed attempt on failure
        self.record_failed_attempt(username)
        return False
    except Exception as e:
        print(f"verified: {errorstr(e)}")
        return False

  def is_account_locked(self, username):
    """ Check if the account is locked """
    if username in FAILED_ATTEMPTS:
      attempts, lock_until = FAILED_ATTEMPTS[username]
      if time.time() < lock_until:
        return True
      else:
        # Clear record if lockout has expired
        del FAILED_ATTEMPTS[username]
    return False

  def record_failed_attempt(self, username):
    """ Record failed attempts and handle lockout """
    # Get current failure count
    current_attempts, _ = FAILED_ATTEMPTS.get(username, (0, 0))
    current_attempts += 1

    # Determine if lockout is necessary
    if current_attempts >= MAX_ATTEMPTS:
      lock_until = time.time() + LOCK_TIME
      print(f"account {username} has been locked until {time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(lock_until))}")
    else:
      lock_until = 0

    FAILED_ATTEMPTS[username] = (current_attempts, lock_until)

  def validate_credentials(self, username, input_password):
    """Verify password hash"""
    user_data = USERS.get(username)
    if not user_data:
      return False

    salt = user_data["salt"]
    stored_hash = user_data["hash"]
    hashed_input = hashlib.sha256(f"{salt}{input_password}".encode()).hexdigest()
    return hashed_input == stored_hash

  def send_auth_required(self):
    self.send_response(401)
    self.send_header('WWW-Authenticate', 'Basic realm="Secure Area"')
    self.send_header('Content-type', 'text/html')
    self.end_headers()
    self.wfile.write(b'Authentication required')

if __name__ == "__main__":
  parser = argparse.ArgumentParser(description="Start HTTPS server")
  parser.add_argument("--directory", type=str, default=os.getcwd(), help="root directory")
  # openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes 
  parser.add_argument("--cert", type=str, default="cert.pem") #abosule path
  parser.add_argument("--key", type=str, default="key.pem") #abosule path
  args = parser.parse_args()

  os.chdir(args.directory)

  server_address = ("", 4443)
  httpd = http.server.HTTPServer(server_address, AuthHandler)

  context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
  context.load_cert_chain(certfile=args.cert, keyfile=args.key)
  httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

  print(f"Running https://localhost:4443 ，root directory: {args.directory}")
  httpd.serve_forever()
