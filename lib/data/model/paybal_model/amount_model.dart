class AmountPaybalModel {
  String? total;
  String? currency;
  Details? details;

  AmountPaybalModel(
      {required this.total, required this.currency, required this.details});

  AmountPaybalModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currency = json['currency'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['currency'] = currency;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  String? subtotal;
  String? shipping;
  int? shippingDiscount;

  Details(
      {required this.subtotal,
      required this.shipping,
      required this.shippingDiscount});

  Details.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    shippingDiscount = json['shipping_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtotal'] = subtotal;
    data['shipping'] = shipping;
    data['shipping_discount'] = shippingDiscount;
    return data;
  }
}
