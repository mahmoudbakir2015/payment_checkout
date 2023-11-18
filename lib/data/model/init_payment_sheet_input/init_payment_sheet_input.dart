class InitPaymentInputSheet {
  final String clientSecret;
  final String customerId;
  final String customerEphemeralKeySecret;

  InitPaymentInputSheet({
    required this.clientSecret,
    required this.customerId,
    required this.customerEphemeralKeySecret,
  });
}
