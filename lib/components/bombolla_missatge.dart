import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BombollaMissatge extends StatelessWidget {
  final Color colorBombolla;
  final String missatge;
  final Timestamp timeStamp;

  const BombollaMissatge({
    Key? key,
    required this.colorBombolla,
    required this.missatge,
    required this.timeStamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime timeStampDate = timeStamp.toDate();

    Duration difference = now.difference(timeStampDate);

    String timeText;
    if (difference.inDays > 1) {
      timeText = 'Fa ${difference.inDays} dies';
    } else if (difference.inDays == 1) {
      timeText = 'Fa 1 dia';
    } else {
      timeText = timeStampDate.toString().substring(11, 16); // 11 y 16 retorna l'hora i minuts
    }

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              color: colorBombolla,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(missatge)),
        Text(timeText,
            style: TextStyle(
                fontSize: 10,
                color: colorBombolla,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
