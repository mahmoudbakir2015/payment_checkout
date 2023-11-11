import 'package:payment_checkout/controller/cubit/payment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_checkout/data/repo/check_out_repo.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  final CheckOutRepo checkOutRepo;
  PaymentCubit(this.checkOutRepo) : super(PaymentInitialState());
  static PaymentCubit get(context) => BlocProvider.of(context);

  Future makePayment({required paymentIntentInput}) async {
    emit(PaymentLoadingState());
    var data = await checkOutRepo.makePayment(paymentInput: paymentIntentInput);
    data.fold(
      (l) => emit(PaymentFailedState(errorMessage: l.errMessage)),
      (r) => emit(PaymentSuccessState()),
    );
  }
}
