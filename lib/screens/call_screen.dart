import 'package:flutter/material.dart';

import 'package:whatsapp/constants/constants.dart';
import 'package:whatsapp/models/models.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: calls.length,
        itemBuilder: (context, index) {
          final call = calls[index];
          return buildCallWidget(call: call);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: brightGreenColor,
        onPressed: () {},
        child: const Icon(Icons.add_call),
      ),
    );
  }

  buildCallWidget({required Call call}) {

    final Icon icon;

    switch(call.callQuality) {
      case CallQuality.incoming:
        icon = const Icon(Icons.call_received, color: brightGreenColor, size: 20);
        break;
      case CallQuality.outgoing:
        icon = const Icon(Icons.call_made, color: brightGreenColor, size: 20);
        break;
      case CallQuality.incomingMissed:
        icon = const Icon(Icons.call_received, color: Colors.red, size: 20);
        break;
      case CallQuality.outgoingMissed:
        icon = const Icon(Icons.call_made, color: Colors.red, size: 20);
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(call.imageUrl),
        ),
        title: Text(
          call.userName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 10),
              Text(
                call.date,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        trailing: call.callType == CallType.audioCall
            ? const Icon(Icons.call, color: brightGreenColor)
            : const Icon(
                Icons.videocam_rounded,
                color: brightGreenColor,
              ),
      ),
    );
  }
}
