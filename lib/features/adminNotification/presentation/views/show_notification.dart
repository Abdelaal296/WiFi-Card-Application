import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/adminNotification/presentation/view_models/cubit/notification_cubit.dart';
import 'package:wifi_card/features/adminNotification/presentation/views/widgets/custom_notification_container.dart';

class ShowNotificationsScreen extends StatelessWidget {
  ShowNotificationsScreen({super.key});
  NotificationCubit notificationCubit = NotificationCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => notificationCubit..getNotfications(),
      child: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('الاشعارات'),
            ),
            body: ConditionalBuilder(
              condition: state is! GetNotificationLoadingState,
              builder: (context) {
                return ListView.builder(
                  itemCount:
                      NotificationCubit.get(context).notifications.length,
                  itemBuilder: (context, index) => BlocProvider.value(
                    value: notificationCubit,
                    child: CustomNotificationContainer(
                        model: NotificationCubit.get(context)
                            .notifications[index]),
                  ),
                );
              },
              fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                color: KPrimaryColor2,
              )),
            ),
          );
        },
      ),
    );
  }
}
