abstract class PaymentStates {}

class PaymentInitialState extends PaymentStates {}

class PaymentLoadingState extends PaymentStates {}

class PaymentSuccessState extends PaymentStates {}

class PaymentFailedState extends PaymentStates {
  final String errorMessage;

  PaymentFailedState({required this.errorMessage});
}
