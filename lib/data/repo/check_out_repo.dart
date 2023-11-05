import 'package:dartz/dartz.dart';
import '../../core/failures.dart';
import '../model/payment_input/payment_input.dart';
import '../service/stripe_service.dart';

abstract class CheckOutRepo {
  StripeService? stripeService;
  Future<Either<Failure, void>> makePayment({
    required PaymentInput paymentInput,
  });
}
