class CreateCustomerModel {
  String? id;
  String? object;
  dynamic address;
  int? balance;
  int? created;
  dynamic currency;
  dynamic defaultSource;
  bool? delinquent;
  dynamic description;
  dynamic discount;
  String? email;
  String? invoicePrefix;
  bool? livemode;
  dynamic name;
  int? nextInvoiceSequence;
  dynamic phone;
  List<dynamic>? preferredLocales;
  dynamic shipping;
  String? taxExempt;
  dynamic testClock;

  CreateCustomerModel(
      {this.id,
      this.object,
      this.address,
      this.balance,
      this.created,
      this.currency,
      this.defaultSource,
      this.delinquent,
      this.description,
      this.discount,
      this.email,
      this.invoicePrefix,
      this.name,
      this.nextInvoiceSequence,
      this.phone,
      this.preferredLocales,
      this.shipping,
      this.taxExempt,
      this.testClock});

  CreateCustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    address = json['address'];
    balance = json['balance'];
    created = json['created'];
    currency = json['currency'];
    defaultSource = json['default_source'];
    delinquent = json['delinquent'];
    description = json['description'];
    discount = json['discount'];
    email = json['email'];
    invoicePrefix = json['invoice_prefix'];

    livemode = json['livemode'];

    name = json['name'];
    nextInvoiceSequence = json['next_invoice_sequence'];
    phone = json['phone'];

    shipping = json['shipping'];
    taxExempt = json['tax_exempt'];
    testClock = json['test_clock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['address'] = address;
    data['balance'] = balance;
    data['created'] = created;
    data['currency'] = currency;
    data['default_source'] = defaultSource;
    data['delinquent'] = delinquent;
    data['description'] = description;
    data['discount'] = discount;
    data['email'] = email;
    data['invoice_prefix'] = invoicePrefix;

    data['livemode'] = livemode;

    data['name'] = name;
    data['next_invoice_sequence'] = nextInvoiceSequence;
    data['phone'] = phone;
    if (preferredLocales != null) {
      data['preferred_locales'] =
          preferredLocales!.map((v) => v.toJson()).toList();
    }
    data['shipping'] = shipping;
    data['tax_exempt'] = taxExempt;
    data['test_clock'] = testClock;
    return data;
  }
}
