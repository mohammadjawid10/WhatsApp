import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'package:whatsapp/models/models.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(2),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: Colors.white,
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          text: message.text,
          children: [
            TextSpan(
              text: '  ${Jiffy(message.date).Hm}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
