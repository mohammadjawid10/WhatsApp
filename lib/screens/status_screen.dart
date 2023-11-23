import 'package:flutter/material.dart';

import 'package:whatsapp/models/models.dart';
import 'package:whatsapp/widgets/widgets.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildMyStatusWidget(),
            const SizedBox(height: 10),
            const SizedBox(
              height: 30,
              child: Text(
                'Recent updates',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: statuses.length,
              itemBuilder: (context, index) {
                final status = statuses[index];
                return buildStatusWidget(
                  userName: status.userName,
                  date: status.date,
                  imageUrl: status.imageUrl,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            isExtended: true,
            mini: true,
            backgroundColor: const Color(0xffE9EDEF),
            onPressed: () {},
            child: const Icon(Icons.edit, color: Color(0xff54656F)),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: const Color(0xff00A884),
            onPressed: () {},
            child: const Icon(Icons.camera_alt, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
