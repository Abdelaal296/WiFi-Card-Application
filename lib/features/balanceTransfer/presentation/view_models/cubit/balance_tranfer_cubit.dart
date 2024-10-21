import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/signUp/data/signUp_model.dart';

part 'balance_tranfer_state.dart';

class BalanceTranferCubit extends Cubit<BalanceTranferState> {
  BalanceTranferCubit() : super(BalanceTranferInitial());
  static BalanceTranferCubit get(context) => BlocProvider.of(context);

  void addTransaction({
    required String shop_owner_id,
    required String network_id,
    required String balance,
  }) {
    emit(AddTransactionLoadingState());
    DioHelper.postData(
      url: 'covert/balance',
      data: {
        'shop_owner_id': shop_owner_id,
        'network_id': network_id,
        'balance': balance,
      },
      token: token,
    ).then((value) {
      emit(AddTransactionSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(AddTransactionFailure(error: error));
    });
  }

  List<AllUserModel> users = [];

  void getUsersBalanceTransfer() async {
    emit(GetUsersBalanceLoadingState());
    await DioHelper.getData(
      url: 'all/users',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      users = [];
      users = userData!.map((data) => AllUserModel.fromJson(data)).toList();

      emit(GetUsersBalanceSuccessState());
    }).catchError((error) {
      emit(GetUsersBalanceFailureState(error: error.toString()));
    });
  }

  List<Network> networks = [];

  void getNetworksBalanceTransfer() async {
    emit(GetNetworksBalanceLoadingState());
    await DioHelper.getData(
      url: 'owner/networks',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      networks = [];
      networks = userData!.map((data) => Network.fromJson(data)).toList();

      emit(GetNetworksBalanceSuccessState());
    }).catchError((error) {
      emit(GetNetworksBalanceFailureState(error: error.toString()));
    });
  }
}
