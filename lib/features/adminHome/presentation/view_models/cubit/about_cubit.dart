import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/adminHome/data/about.dart';
import 'package:wifi_card/features/signUp/data/signUp_model.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(AboutInitial());

  static AboutCubit get(context) => BlocProvider.of(context);

  RegisterModel? model;

  void addAbout({
    required String title,
    required String desc,
  }) {
    emit(AboutLoadingState());
    DioHelper.postData(
      url: 'about/store',
      data: {
        'title': title,
        'desc': desc,
      },
      token: token,
    ).then((value) {
      emit(AboutSuccessState(message: value.data['data']));
    }).catchError((error) {
      emit(AboutFailureState(error: error.toString()));
    });
  }

  List<About> abouts = [];

  Future getAbouts() async {
    emit(GetAboutsLoadingState());
    await DioHelper.getData(
      url: 'abouts',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      abouts = [];
      abouts = userData!.map((data) => About.fromJson(data)).toList();

      emit(GetAboutsSuccessState());
    }).catchError((error) {
      emit(GetAboutsFailureState(error: error.toString()));
    });
  }

  void updateAbout({
    required String id,
    required String title,
    required String desc,
    required About model,
  }) {
    emit(UpdateAboutLoadingState());
    DioHelper.postData(
      url: 'about/update/$id',
      data: {
        'title': title,
        'desc': desc,
        '_method': 'PUT',
      },
      token: token,
    ).then((value) {
      model.title = title;
      model.desc = desc;

      emit(UpdateAboutSuccessState(message: value.data['data']));
    }).catchError((error) {
      emit(UpdateAboutFailure(error: error));
    });
  }

  void deleteAbout({
    required String id,
  }) {
    emit(DeleteAboutLoadingState());
    DioHelper.postData(
      url: 'about/delete/${id}',
      data: {
        '_method': 'DELETE',
      },
      token: token,
    ).then((value) {
      emit(DeleteAboutSuccessState(message: value.data['data']));
    }).catchError((error) {
      emit(DeleteAboutFailure(error: error));
    });
  }
}
