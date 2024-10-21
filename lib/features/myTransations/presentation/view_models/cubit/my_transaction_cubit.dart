import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/myTransations/data/transaction/transaction.dart';

part 'my_transaction_state.dart';

class MyTransactionCubit extends Cubit<MyTransactionState> {
  MyTransactionCubit() : super(MyTransactionInitial());
  static MyTransactionCubit get(context) => BlocProvider.of(context);

  List myTransations = [];
  void getMyTransaction(int id) async {
    emit(GetMyTransactionLoadingState());
    await DioHelper.getData(
      url: 'admin/transactions/$id',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      myTransations = [];
      myTransations =
          userData!.map((data) => Transaction.fromJson(data)).toList();

      emit(GetMyTransactionSuccessState());
    }).catchError((error) {
      emit(GetMyTransactionFailureState(error: error.toString()));
    });
  }

  List transations = [];
  void getTransaction() async {
    emit(GetTransactionLoadingState());
    await DioHelper.getData(
      url: 'transactions',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      transations = [];
      transations =
          userData!.map((data) => Transaction.fromJson(data)).toList();

      emit(GetTransactionSuccessState());
    }).catchError((error) {
      emit(GetTransactionFailureState(error: error.toString()));
    });
  }
}
