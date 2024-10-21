import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/adminHome/data/about.dart';
import 'package:wifi_card/features/more/presentation/views/widgets/custom_desc_user.dart';

class CustomAboutUserContainer extends StatelessWidget {
  const CustomAboutUserContainer({
    super.key,
    required this.model,
  });
  final About model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: DescripationUserScreen(
                      model: model,
                    ))));
      },
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        height: 120,
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
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
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
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: Kprimaryfont),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    '${model.title}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: Kprimaryfont,
                        fontSize: 24,
                        color: KPrimaryColor2),
                  )),
                  Expanded(
                      child: Text(
                    '${model.desc}',
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(fontFamily: Kprimaryfont, fontSize: 20),
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
