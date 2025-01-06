from flask import Flask, request, jsonify

app = Flask(__name__)


users_db = {

    "test@gmail.com": "123"
}

@app.route("/register", methods=["POST"])
def register():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Brak danych JSON"}), 400

    email = data.get("email")
    password = data.get("password")

    if not email or not password:
        return jsonify({"error": "Brak wymaganych pol (email, password)"}), 400

    if email in users_db:
        return jsonify({"error": "Uzytkownik o takim email juz istnieje"}), 409

    # Dodajemy do "bazy":
    users_db[email] = password

    return jsonify({"message": "Rejestracja udana"}), 201


@app.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Brak danych JSON"}), 400

    email = data.get("email")
    password = data.get("password")

    if not email or not password:
        return jsonify({"error": "Brak wymaganych pol (email, password)"}), 400


    if email in users_db and users_db[email] == password:

        return jsonify({"message": "Zalogowano pomyslnie"}), 200
    else:
        return jsonify({"error": "Niepoprawne dane logowania"}), 401


if __name__ == "__main__":

    app.run(debug=True, port=5000)
