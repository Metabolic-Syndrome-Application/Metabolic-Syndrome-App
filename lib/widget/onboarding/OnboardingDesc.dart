import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/onboarding/NextOnboardingButton.dart';

class OnboardingDesc extends StatelessWidget {
  String title;
  String description;
  String titleButton;

  OnboardingDesc(this.title, this.description, this.titleButton);
  
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            SizedBox(
              height: 160,
            ),
            Container(
                width: 310,
                height: 214,
                child: Image.asset('assets/images/healthPlanPage.png')),
            SizedBox(
              height: 60,
            ),
            Text(title,
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
            SizedBox(
              height: 14,
            ),
            Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center),
            SizedBox(
              height: 50,
            ),
            NextOnboardingButton(titleButton),
          ],
        );
  }
}