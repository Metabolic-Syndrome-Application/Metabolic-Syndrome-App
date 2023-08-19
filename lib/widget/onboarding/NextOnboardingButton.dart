import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';

class NextOnboardingButton extends StatelessWidget {
  String titleButton;

  NextOnboardingButton(this.titleButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(hexColor('#166CF7')),
        borderRadius: BorderRadius.circular(25),
      ),
      height: 47,
      width: 350,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(titleButton,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
