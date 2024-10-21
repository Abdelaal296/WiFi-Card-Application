import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';

part 'my_networks_state.dart';

class MyNetworksCubit extends Cubit<MyNetworksState> {
  MyNetworksCubit() : super(MyNetworksInitial());
  static MyNetworksCubit get(context) => BlocProvider.of(context);

  List myNetworks = [];

  void getMyNetworks() async {
    emit(GetMyNetworksLoadingState());
    await DioHelper.getData(
      url: 'owner/networks',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      myNetworks = [];
      myNetworks = userData!.map((data) => Network.fromJson(data)).toList();

      emit(GetMyNetworksSuccessState());
    }).catchError((error) {
      emit(GetMyNetworksFailureState(error: error.toString()));
    });
  }
}
