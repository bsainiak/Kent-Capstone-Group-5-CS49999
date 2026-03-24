import json
from urllib.request import urlopen
from functools import wraps
from flask import Flask, request, jsonify
from flask_cors import CORS
from jose import jwt

app = Flask(__name__)
CORS(app)

# Your specific Auth0 Tenant details
AUTH0_DOMAIN = 'dev-mofp6o657an4qvyp.us.auth0.com'
API_AUDIENCE = 'https://capstone-api'
ALGORITHMS = ["RS256"]

# Error handler for unauthorized users
class AuthError(Exception):
    def __init__(self, error, status_code):
        self.error = error
        self.status_code = status_code

@app.errorhandler(AuthError)
def handle_auth_error(ex):
    response = jsonify(ex.error)
    response.status_code = ex.status_code
    return response

# The "Bouncer": Extracts the token from the request
def get_token_auth_header():
    auth = request.headers.get("Authorization", None)
    if not auth:
        raise AuthError({"code": "authorization_header_missing", "description": "Authorization header is expected"}, 401)
    parts = auth.split()
    if parts[0].lower() != "bearer":
        raise AuthError({"code": "invalid_header", "description": "Authorization header must start with Bearer"}, 401)
    elif len(parts) == 1 or len(parts) > 2:
        raise AuthError({"code": "invalid_header", "description": "Token not found or malformed"}, 401)
    return parts[1]

# The "Bouncer": Verifies the token with Auth0
def requires_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = get_token_auth_header()
        jsonurl = urlopen(f"https://{AUTH0_DOMAIN}/.well-known/jwks.json")
        jwks = json.loads(jsonurl.read())
        unverified_header = jwt.get_unverified_header(token)
        rsa_key = {}
        for key in jwks["keys"]:
            if key["kid"] == unverified_header["kid"]:
                rsa_key = {"kty": key["kty"], "kid": key["kid"], "use": key["use"], "n": key["n"], "e": key["e"]}
        if rsa_key:
            try:
                payload = jwt.decode(token, rsa_key, algorithms=ALGORITHMS, audience=API_AUDIENCE, issuer=f"https://{AUTH0_DOMAIN}/")
            except jwt.ExpiredSignatureError:
                raise AuthError({"code": "token_expired", "description": "Token expired."}, 401)
            except jwt.JWTClaimsError:
                raise AuthError({"code": "invalid_claims", "description": "Incorrect claims."}, 401)
            except Exception:
                raise AuthError({"code": "invalid_header", "description": "Unable to parse token."}, 400)
            return f(*args, **kwargs)
        raise AuthError({"code": "invalid_header", "description": "Unable to find key."}, 400)
    return decorated

# ---------------------------------------------------------
# YOUR PROJECT ROUTES
# ---------------------------------------------------------

gallery_data = [{"id": 1, "title": "Monza Apex", "category": "F1", "image_url": "/images/monza.jpg"}]
store_data = [{"item_id": 101, "photo_id": 1, "size": "8x10", "price": 25.00, "in_stock": True}]

# Public routes (Anyone can see these)
@app.route('/api/gallery', methods=['GET'])
def get_gallery():
    return jsonify(gallery_data)

@app.route('/api/store', methods=['GET'])
def get_store():
    return jsonify(store_data)

# Protected route (Only logged-in users can hit this)
@app.route('/api/checkout', methods=['POST'])
@requires_auth  # <--- THIS IS THE LOCK!
def process_checkout():
    order = request.json
    print(f"Received secure order: {order}")
    return jsonify({"message": "Order processed securely!", "status": "success"}), 201

if __name__ == '__main__':
    print("Starting secure capstone backend on http://127.0.0.1:5000")
    app.run(host='127.0.0.1', port=5000, debug=True)
