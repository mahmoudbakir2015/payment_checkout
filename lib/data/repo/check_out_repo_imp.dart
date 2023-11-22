import 'package:dartz/dartz.dart';
import 'package:payment_checkout/core/failures.dart';
import 'package:payment_checkout/data/model/payment_input/payment_input.dart';
import 'package:payment_checkout/data/repo/check_out_repo.dart';
import 'package:payment_checkout/data/service/stripe_service.dart';

class CheckoutRepoImp extends CheckOutRepo {
  final StripeService stripeService = StripeService();

  @override
  Future<Either<Failure, void>> makePaymentStripe(
      {required PaymentInput paymentInput,
      required context,
      required String customerId}) async {
    try {
      await stripeService.makePayment(
          paymentInput: paymentInput, context: context, customerId: customerId);
      return const Right(null);
    } catch (e) {
      return left(
        ServerFailure(
          errMessage: e.toString(),
        ),
      );
    }
  }
}
