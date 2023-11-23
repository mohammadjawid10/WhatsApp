import 'package:flutter/material.dart';

Widget buildHorizontalIconButton({
  required Text label,
  required Widget icon,
  Text? subtitle,
  required VoidCallback onPressed,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 20),
          subtitle == null
              ? label
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label,
                    FittedBox(
                      child: subtitle,
                    )
                  ],
                ),
        ],
      ),
    ),
  );
}
