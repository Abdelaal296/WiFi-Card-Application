import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wifi_card/constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding:
              const EdgeInsets.only(top: 32, bottom: 32, right: 32, left: 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            color: Color.fromARGB(255, 230, 117, 117),
          ),
          child: Text(
            message,
            textDirection:
                isRTL(message) ? TextDirection.rtl : TextDirection.ltr,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
          )),
    );
  }
}

class ChatBubbleForBot extends StatelessWidget {
  const ChatBubbleForBot({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding:
              const EdgeInsets.only(top: 32, bottom: 32, right: 32, left: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: KPrimaryColor2,
          ),
          child: Text(
            message,
            textDirection:
                isRTL(message) ? TextDirection.rtl : TextDirection.ltr,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}

bool isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text);
}
