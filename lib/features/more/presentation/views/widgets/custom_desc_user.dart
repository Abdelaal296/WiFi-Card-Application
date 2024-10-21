import 'package:flutter/material.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/features/adminHome/data/about.dart';

class DescripationUserScreen extends StatelessWidget {
  DescripationUserScreen({super.key, required this.model});
  final About model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
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
                  '${model.title}',
                  style: const TextStyle(
                      fontFamily: Kprimaryfont,
                      fontSize: 32,
                      color: KPrimaryColor2),
                )),
                Text(
                  '${model.desc}',
                  style:
                      const TextStyle(fontSize: 20, fontFamily: Kprimaryfont),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
