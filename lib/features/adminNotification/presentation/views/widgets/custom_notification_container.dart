import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/Users/presentation/view_models/cubit/users_cubit.dart';
import 'package:wifi_card/features/adminHome/data/about.dart';
import 'package:wifi_card/features/adminHome/presentation/view_models/cubit/about_cubit.dart';
import 'package:wifi_card/features/adminHome/presentation/views/desc_screen.dart';
import 'package:wifi_card/features/adminNotification/data/notification_model.dart';
import 'package:wifi_card/features/adminNotification/presentation/view_models/cubit/notification_cubit.dart';
import 'package:wifi_card/features/adminNotification/presentation/views/widgets/desc_notification.dart';
import 'package:wifi_card/features/layout/presentation/view_models/cubit/home_service_cubit.dart';

class CustomNotificationContainer extends StatelessWidget {
  const CustomNotificationContainer({
    super.key,
    required this.model,
  });
  final NotificationModel model;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();
    return InkWell(
      onTap: () {
        
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: BlocProvider.value(
                      value: cubit..updateNotification(id: model.id.toString(), model: model),
                      child: DescripationNotificationScreen(
                        model: model,
                      ),
                    ))));
                    HomeServiceCubit.get(context).getNotifications();
      },
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(8.0),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              const Color.fromARGB(255, 219, 180, 180)
            ], // Define your gradient colors here
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.3, 1],
            // Optional: define stops for the gradient
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: KPrimaryColor2,
              child: Text(
                '${model.id}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: Kprimaryfont),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Row(
                        children: [
                          Text(
                    '${model.notificationTypeAr}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                            fontFamily: Kprimaryfont,
                            fontSize: 24,
                            color: KPrimaryColor2),
                  ),
                  Spacer(),
                  model.read==0?CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 5,
                  ):Container(),
                        ],
                      )),
                  Expanded(
                      child: Text(
                    '${model.creatorName} ${model.textAr}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: Kprimaryfont, fontSize: 15),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
