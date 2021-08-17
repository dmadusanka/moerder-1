class SalesOrder {
  final String referenceId;
  final String captureTime;
  final int creationLatitiude;
  final int creationLongitude;
  final int customerId;
  final String channel;
  final double orderSubTotal;
  final double taxSubTotal;
  final double orderTotal;
  final String notes;
  final List<Items> items;

  SalesOrder(
      {this.referenceId,
      this.captureTime,
      this.creationLatitiude = 0,
      this.creationLongitude = 0,
      this.customerId,
      this.channel,
      this.orderSubTotal,
      this.taxSubTotal,
      this.orderTotal,
      this.notes,
      this.items});

  factory SalesOrder.fromJson(Map<String, dynamic> json) {
    List<Items> _items = [];

    if (json['items'] != null) {
      json['items'].forEach((v) {
        _items.add(new Items.fromJson(v));
      });
    }
    return SalesOrder(
      referenceId: json['referenceId'],
      captureTime: json['captureTime'],
      creationLatitiude: json['creationLatitiude'],
      creationLongitude: json['creationLongitude'],
      customerId: json['customerId'],
      channel: json['channel'],
      orderSubTotal: json['orderSubTotal'],
      taxSubTotal: json['taxSubTotal'],
      orderTotal: json['orderTotal'],
      notes: json['notes'],
      items: _items,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referenceId'] = this.referenceId;
    data['captureTime'] = this.captureTime;
    data['creationLatitiude'] = this.creationLatitiude;
    data['creationLongitude'] = this.creationLongitude;
    data['customerId'] = this.customerId;
    data['channel'] = this.channel;
    data['orderSubTotal'] = this.orderSubTotal;
    data['taxSubTotal'] = this.taxSubTotal;
    data['orderTotal'] = this.orderTotal;
    data['notes'] = this.notes;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  final String productCode;
  final String description;
  final int quantity;
  final double unitPrice;
  final int taxRate;
  final String taxCode;
  final double subTotalPrice;
  final double subTotalTax;

  Items(
      {this.productCode,
      this.description,
      this.quantity,
      this.unitPrice,
      this.taxRate,
      this.taxCode,
      this.subTotalPrice,
      this.subTotalTax});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
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
