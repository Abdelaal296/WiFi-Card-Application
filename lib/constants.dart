import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:wifi_card/features/Users/data/models/user_model/user_model.dart';

const Color KPrimaryColor1 = Colors.white;
const KPrimaryColor2 = Color(0xff710019);
const Kprimaryfont = "Cairo";

String? token;
String? user_role;
AllUserModel? model;

int balance = 0;
num fees = 0;
int count = 0;
BluetoothDevice? device;
