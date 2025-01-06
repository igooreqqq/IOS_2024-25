from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/products', methods=['GET'])
def get_products():
    return jsonify([
        {"id": "1", "name": "Laptop", "price": 3000, "description": "Gaming Laptop", "category": "Electronics"},
        {"id": "2", "name": "Chair", "price": 150, "description": "Office Chair", "category": "Furniture"}
    ])

@app.route('/categories', methods=['GET'])
def get_categories():
    return jsonify([
        {"id": "1", "name": "Electronics"},
        {"id": "2", "name": "Furniture"}
    ])

@app.route('/orders', methods=['GET'])
def get_orders():
    return jsonify([
        {"id": "1", "date": "2023-12-01", "totalPrice": 3150, "customerName": "Jan Kowalski", "products": ["1", "2"]}
    ])

if __name__ == '__main__':
    app.run(debug=True)
