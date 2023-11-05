import 'package:dartz/dartz.dart';
import 'package:payment_checkout/core/failures.dart';
import 'package:payment_checkout/data/model/payment_input/payment_input.dart';
import 'package:payment_checkout/data/repo/check_out_repo.dart';
import 'package:payment_checkout/data/service/stripe_service.dart';

class CheckoutRepoImp extends CheckOutRepo {
  final StripeService stripeService = StripeService();

  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentInput paymentInput}) async {
    try {
      await stripeService.makePayment(paymentInput: paymentInput);
      return const Right(null);
    } catch (e) {
      return left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
