class SalesOrderSummary {
  final int internalId;
  final double orderTotal;
  final String notes;
  final String creationTime;
  final List<OrderItems> orderItems;

  SalesOrderSummary(
      this.internalId, this.orderItems, this.notes, this.orderTotal, this.creationTime);

  factory SalesOrderSummary.fromJson(Map<String, dynamic> json) {
    return SalesOrderSummary(
        json['internalId'],
        List<OrderItems>.from(json['items'].map((e) => OrderItems.fromJson(e)))
            .toList(),
        json['notes'],
        json['orderTotal'],json['creationTime']);
  }
}

class OrderItems {
  final String productCode;
  final String description;
  final double quantity;
  final double unitPrice;
  final double taxRate;
  final String taxCode;
  final double subTotalPrice;
  final double subTotalTax;


  OrderItems(
      {this.productCode,
      this.description,
      this.quantity,
      this.unitPrice,
      this.taxRate,
      this.taxCode,
      this.subTotalPrice,
      this.subTotalTax});

  factory OrderItems.fromJson(Map<String, dynamic> json) {
    print(json);
    return OrderItems(
        productCode: json['productCode'],
        description: json['description'],
        quantity: json['quantity'],
        unitPrice: json['unitPrice'],
        taxRate: json['taxRate'],
        taxCode: json['taxCode'],
        subTotalPrice: json['subTotalPrice'],
        subTotalTax: json['subTotalTax']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productCode'] = this.productCode;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    data['taxRate'] = this.taxRate;
    data['taxCode'] = this.taxCode;
    data['subTotalPrice'] = this.subTotalPrice;
    data['subTotalTax'] = this.subTotalTax;
    return data;
  }
}
