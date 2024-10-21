import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network_owner.dart';
import 'package:wifi_card/features/signUp/data/signUp_model.dart';

part 'add_network_state.dart';

class AddNetworkCubit extends Cubit<AddNetworkState> {
  AddNetworkCubit() : super(AddNetworkInitial());
  static AddNetworkCubit get(context) => BlocProvider.of(context);

  RegisterModel? model;
  List<Network> networks = [];

  void addNetwork({
    required String id,
    required String name,
    required String fee_rate,
  }) {
    emit(AddNetworkLoadingState());
    DioHelper.postData(
      url: 'network/store',
      data: {
        'name': name,
        'user_id': id,
        'fee_rate': fee_rate,
      },
      token: token,
    ).then((value) {
      model = RegisterModel.fromJSon(value.data);
      getNetworks();
      emit(AddNetworkSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(AddNetworkFailure(error: error));
    });
  }

  Future getNetworks() async {
    emit(GetNetworksLoadingState());
    await DioHelper.getData(
      url: 'admin/networks',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];

      networks = userData!.map((data) => Network.fromJson(data)).toList();
      print(networks);

      emit(GetNetworksSuccessState());
    }).catchError((error) {
      emit(GetNetworksFailureState(error: error.toString()));
    });
  }

  void updateNetwork({
    required Network networkModel,
    required String network_id,
    required String user_id,
    required String name,
    required String fee_rate,
    required String fees,
  }) {
    emit(UpdateNetworkLoadingState());
    DioHelper.postData(
      url: 'network/update/${network_id}',
      data: {
        'name': name,
        'user_id': user_id,
        'fee_rate': fee_rate,
        'fees': fees,
        '_method': 'PUT',
      },
      token: token,
    ).then((value) {
      model = RegisterModel.fromJSon(value.data);
      networkModel.name = name;
      networkModel.userId = int.tryParse(user_id);
      networkModel.feeRate = int.tryParse(fee_rate);
      networkModel.fees = double.tryParse(fees);
      getNetworks();
      emit(UpdateNetworkSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(UpdateNetworkFailure(error: error));
    });
  }

  void deleteNetwork({
    required String network_id,
  }) {
    emit(DeleteNetworkLoadingState());
    DioHelper.deleteData(
      url: 'network/delete/${network_id}',
      token: token,
    ).then((value) {
      model = RegisterModel.fromJSon(value.data);
      emit(DeleteNetworkSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(DeleteNetworkFailure(error: error));
    });
  }

  double rem = 0;
  void fess(double val, double fee) {
    rem = fee - val;
    print(rem);
    emit(ChangeReminning());
  }
  List<AllUserModel> users = [];

  void getUsersBalanceTransfer() async {
    emit(GetAdminBalanceLoadingState());
    await DioHelper.getData(
      url: 'all/users',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      users = [];
      users = userData!.map((data) => AllUserModel.fromJson(data)).toList();

      emit(GetAdminBalanceSuccessState());
    }).catchError((error) {
      emit(GetAdminBalanceFailureState(error: error.toString()));
    });
  }
}
