import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/adminAddNetwork/presentation/view_models/cubit/add_network_cubit.dart';
import 'package:wifi_card/features/networks/presentation/views/widgets/custom_networks_text_field.dart';
import 'package:wifi_card/features/wifiCard/data/card_model/card_model.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/custom_bottom_sheet.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/custom_card.dart';

import '../../../../../constants.dart';
import '../../../../adminAddNetwork/presentation/views/networkdetails.dart';

class CustomAdminWifiCabinContainer extends StatelessWidget {
  CustomAdminWifiCabinContainer(
      {super.key, this.onPressed, required this.model});

  void Function()? onPressed;
  final Network model;

  // final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNetworkCubit>();
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: BlocProvider.value(
                      value: cubit,
                      child: NetworkDetailsScreen(
                        model: model!,
                      ),
                    ))));
      },
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
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
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi,
                  size: 40,
                  color: Colors.blueGrey,
                ),
                Text(
                  '${model.id}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: Kprimaryfont),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                ' ${model.name}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "صاحب الشبكه",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    " ${model.networkOwner!.fullName} ",
                    style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
