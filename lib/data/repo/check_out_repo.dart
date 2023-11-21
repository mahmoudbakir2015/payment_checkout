import 'package:dartz/dartz.dart';
import '../../core/failures.dart';
import '../model/payment_input/payment_input.dart';

abstract class CheckOutRepo {
  Future<Either<Failure, void>> makePayment({
    required PaymentInput paymentInput,
    required context,
    required String customerId,
  });
}
