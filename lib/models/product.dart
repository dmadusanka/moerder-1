class Product {
  final String id;
  final String productName;
  final productImage;
  final productDescription;
  final double price;
  int quantity;

  Product(this.id, this.productName, this.price, this.productDescription,
      this.productImage,
      {this.quantity = 1});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(json['id'], json['name'], json['pricing'][0]['price'],
        json['description'], json['productImage']);
  }
}
