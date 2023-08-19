import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/widget/onboarding/OnboardingDesc.dart';

void main() {
  runApp(HealthNote());
}

class HealthNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Second page onbroading",
      home: HealthNotePage(),
    );
  }
}

class HealthNotePage extends StatefulWidget {
  @override
  State<HealthNotePage> createState() => _HealthNotePageState();
}

class _HealthNotePageState extends State<HealthNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#42884B')),
      body: Center(
          child: OnboardingDesc(
              "บันทึกประจำวัน",
              "สามารถจดบันทึกค่าสุขภาพในเเต่ละวันได้\nพร้อมทั้งติดตามเเนวโน้มสุขภาพของคุณ\nรวมถึงการเเจ้งเตือนสำคัญต่างๆ ที่ต้องทำ",
              "ถัดไป",
              Color(hexColor('#42884B')),
              'assets/images/healthNotePage.png')),
    );
  }
}
