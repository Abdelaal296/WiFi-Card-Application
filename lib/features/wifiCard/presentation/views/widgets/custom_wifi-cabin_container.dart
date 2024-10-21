import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/features/adminAddNetwork/data/network/network.dart';
import 'package:wifi_card/features/wifiCard/data/card_model/card_model.dart';
import 'package:wifi_card/features/wifiCard/presentation/view_models/cubit/wifi_cabin_cubit.dart';
import 'package:wifi_card/features/wifiCard/presentation/views/widgets/custom_bottom_sheet.dart';

import '../../../../../constants.dart';

class CustomWifiCabinContainer extends StatelessWidget {
  CustomWifiCabinContainer(
      {super.key,
      this.onPressed,
      this.isHeart = false,
      required this.cardModel});

  void Function()? onPressed;
  Network? model;
  bool isHeart;

  final CardModel cardModel;

  // final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WifiCabinCubit>();
    return InkWell(
      onTap: () {
        cubit.counter = 1;
        cubit.getCategories(cardModel.id!);
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => BlocProvider.value(
                value: cubit,
                child: CustomBottomSheet(
                  cardModel: cardModel,
                )));
      },
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 219, 180, 180)
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
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi,
                  size: 40,
                  color: Colors.blueGrey,
                ),
                Text(
                  '${cardModel.id}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: Kprimaryfont),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'شبكة ${cardModel!.name}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: Kprimaryfont),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'الرصيد : ${cardModel.balance == null ? 0 : cardModel.balance!.balance}',
                    style:
                        const TextStyle(fontSize: 16, fontFamily: Kprimaryfont),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                if (cardModel.favouriteUser == null)
                  WifiCabinCubit.get(context)
                      .makeFav(id: cardModel.id!, model: cardModel);
                else
                  WifiCabinCubit.get(context)
                      .deleteFav(id: cardModel.id!, model: cardModel);
              },
              icon: Icon(
                Icons.favorite,
                color:
                    cardModel.favouriteUser != null ? Colors.red : Colors.grey,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
