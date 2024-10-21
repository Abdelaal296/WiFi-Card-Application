import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/networks/data/category_model.dart';

part 'report_and_card_state.dart';

class ReportAndCardCubit extends Cubit<ReportAndCardState> {
  ReportAndCardCubit() : super(ReportAndCardInitial());

  static ReportAndCardCubit get(context) => BlocProvider.of(context);

  List<CategoryModel> cardNumbers = [];

  void getCardNumbers(int id) async {
    emit(GetCardNumbersLoadingState());
    await DioHelper.getData(
      url: 'card/numbers/details/$id',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data']['card_categories'];
      cardNumbers = [];
      cardNumbers =
          userData!.map((data) => CategoryModel.fromJson(data)).toList();

      emit(GetCardNumbersSuccessState());
    }).catchError((error) {
      emit(GetCardNumbersFailureState(error: error.toString()));
    });
  }
}
