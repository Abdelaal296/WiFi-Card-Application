import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../constants.dart';
import '../../../../core/utils/api_service.dart';
import '../../data/card_trans_model.dart';

part 'cardtransaction_state.dart';

class CardtransactionCubit extends Cubit<CardtransactionState> {
  CardtransactionCubit() : super(CardtransactionInitial());

  static CardtransactionCubit get(context) => BlocProvider.of(context);

  List<CardTransactionModel> transations = [];
  int last_total_price = 0;
  void getTransaction() async {
    emit(GetCardTransactionLoadingState());
    await DioHelper.getData(
      url: 'card/numbers/last/day',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      transations = [];
      transations =
          userData!.map((data) => CardTransactionModel.fromJson(data)).toList();
      last_total_price = value.data["all_prices_in _last_day"];
      emit(GetCardTransactionSuccessState());
    }).catchError((error) {
      emit(GetCardTransactionFailureState(error: error.toString()));
    });
  }

  List<CardTransactionModel> alltransations = [];
  int total_price = 0;
  void getAllTransaction() async {
    emit(GetAllCardTransactionLoadingState());
    await DioHelper.getData(
      url: 'all/card/numbers',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      alltransations = [];
      alltransations =
          userData!.map((data) => CardTransactionModel.fromJson(data)).toList();
      total_price = value.data["all_prices"];
      emit(GetAllCardTransactionSuccessState());
    }).catchError((error) {
      emit(GetAllCardTransactionFailureState(error: error.toString()));
    });
  }
}
