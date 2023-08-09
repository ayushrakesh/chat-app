import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Flex(
      direction: Axis.vertical,
      children: [
        Text(
          'Login Now',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
        ),
        Gap(height * 0.01),
        Text(
          'Please enter the details below to continue.',
          style: TextStyle(
            color: Color.fromARGB(255, 149, 148, 148),
            fontSize: 16,
          ),
        ),
        Gap(height * 0.03),
      ],
    );
  }
}
