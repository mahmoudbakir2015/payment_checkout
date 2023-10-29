class PaymentInput {
  final String amount;
  final String currency;

  PaymentInput({
    required this.amount,
    required this.currency,
  });
  toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}