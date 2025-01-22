from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/pay', methods=['POST'])
def pay():
    data = request.get_json()
    if not data:
        return jsonify(success=False, message="Brak danych JSON"), 400

    card_number = data.get("cardNumber")
    card_holder_name = data.get("cardHolderName")
    expiry_date = data.get("expiryDate")
    cvv = data.get("cvv")
    amount = data.get("amount", 0)

    if not card_number or len(card_number) < 12:
        return jsonify(success=False, message="Niepoprawny numer karty"), 400
    
    if amount <= 0:
        return jsonify(success=False, message="Kwota powinna być większa od 0"), 400

    return jsonify(success=True, message="Płatność zaakceptowana")


if __name__ == '__main__':
    app.run(debug=True)
