import 'package:flutter/material.dart';

class MuteNotificationsSwitch extends StatefulWidget {
  const MuteNotificationsSwitch({Key? key}) : super(key: key);

  @override
  State<MuteNotificationsSwitch> createState() =>
      _MuteNotificationsSwitchState();
}

class _MuteNotificationsSwitchState extends State<MuteNotificationsSwitch> {
  bool muteNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: Colors.green,
      thumbColor: MaterialStateProperty.all(const Color(0xff83939D)),
      trackColor: MaterialStateProperty.all(const Color(0xffDADFE2)),
      activeTrackColor: Colors.green,
      value: muteNotifications,
      onChanged: (value) {
        setState(() {
          muteNotifications = value;
        });
      },
    );
  }
}
