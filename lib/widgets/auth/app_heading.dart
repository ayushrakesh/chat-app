import 'package:flutter/material.dart';

class ChatHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 201, 26, 85),
        borderRadius: BorderRadius.circular(
          6,
        ),
      ),
      // height: 50,
      child: Text(
        'Welcome',
        style: TextStyle(
          fontFamily: 'Righteous',
          color: Color.fromARGB(255, 248, 194, 213),
          fontSize: 26,
        ),
      ),
      margin: EdgeInsets.only(
          // top: 0,
          // bottom: 10,
          ),
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      // width: 100,
    );
  }
}
