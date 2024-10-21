import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/features/adminNotification/data/notification_model.dart';
import 'package:wifi_card/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:wifi_card/features/layout/presentation/view_models/cubit/home_service_cubit.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  static NotificationCubit get(context)=>BlocProvider.of(context);

  List<NotificationModel> notifications=[];

  void getNotfications() async {
    emit(GetNotificationLoadingState());
    await DioHelper.getData(
      url: 'notifications',
      token: token,
    ).then((value) {
      List<dynamic>? userData = value.data['data'];
      notifications = [];
      notifications = userData?.map((data) => NotificationModel.fromJson(data)).toList() ?? [];

      
      

      
      emit(GetUNotificationSuccessState());
    }).catchError((error) {
      emit(GetNotificationFailureState(error: error.toString()));
    });
  }

  void updateNotification({
    required String id,
    required NotificationModel model,
    
  }) {
    emit(UpdateNotificationLoadingState());
    DioHelper.getData(
      url: 'notification/read/$id',
     
      token: token,
    ).then((value) {
      model.read=1;
      getNotfications();
      

      emit(UpdateNotificationSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(UpdateNotificationFailure(error: error));
    });
  }




  void deleteNotification({
    required String id,
  }) {
    emit(DeleteNotificationLoadingState());
    DioHelper.deleteData(
      url: 'notification/delete/${id}',
      
      token: token,
    ).then((value) {
      emit(DeleteNotificationSuccessState(message: value.data['message']));
    }).catchError((error) {
      emit(DeleteNotificationFailure(error: error));
    });
  }
}



