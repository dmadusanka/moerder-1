class TopTenProduct {

  final String id;
  final String productName;
  final productImage;

  TopTenProduct(this.id, this.productName, this.productImage,);

  factory TopTenProduct.fromJson(Map<String, dynamic> json) {
    return TopTenProduct(json['id'], json['name'],json['productImage']);
  }
}
