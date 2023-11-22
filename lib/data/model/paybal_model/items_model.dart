class ItemsPaybalModel {
  List<Items>? items;

  ItemsPaybalModel({required this.items});

  ItemsPaybalModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  int? quantity;
  String? price;
  String? currency;

  Items(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.currency});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }
}
