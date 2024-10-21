import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/widgets/custom_flutter_toast.dart';
import 'package:wifi_card/core/widgets/custom_text_field.dart';
import 'package:wifi_card/features/adminHome/data/about.dart';
import 'package:wifi_card/features/adminHome/presentation/view_models/cubit/about_cubit.dart';
import 'package:wifi_card/features/adminHome/presentation/views/show_abouts.dart';
import 'package:wifi_card/features/adminNotification/data/notification_model.dart';
import 'package:wifi_card/features/adminNotification/presentation/view_models/cubit/notification_cubit.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/custom_alert_dialog_button.dart';

class DescripationNotificationScreen extends StatelessWidget {
  DescripationNotificationScreen({super.key, required this.model});
  final NotificationModel model;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  var form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is DeleteNotificationSuccessState) {
          showToast(text: state.message, state: ToastStates.SUCCESS);
          cubit.getNotfications();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 30,
            elevation: 0.0,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: () {
                    NotificationCubit.get(context)
                        .deleteNotification(id: model.id.toString());
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  )),
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      '${model.notificationTypeAr}',
                      style: TextStyle(
                          fontFamily: Kprimaryfont,
                          fontSize: 32,
                          color: KPrimaryColor2),
                    )),
                    Text(
                      '${model.creatorName} ${model.textAr}',
                      style: TextStyle(fontSize: 26, fontFamily: Kprimaryfont),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
