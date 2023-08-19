import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/widget/onboarding/OnboardingDesc.dart';

void main() {
  runApp(KnowledgeChallenge());
}

class KnowledgeChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Third page onbroading",
      home: KnowledgeChallengePage(),
    );
  }
}

class KnowledgeChallengePage extends StatefulWidget {
  @override
  State<KnowledgeChallengePage> createState() => _KnowledgeChallengePageState();
}

class _KnowledgeChallengePageState extends State<KnowledgeChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#F94B4B')),
      body: Center(
          child: OnboardingDesc(
              "ความรู้เเละความท้าทาย",
              "ช่วยให้ความรู้เเละความเข้าใจเกี่ยวกับภาวะ\nเมตาบอลิกซินโดรม เเถมยังเพลิดเพลินกับกิจกรรม\nความท้าทายภายในเเอปพลิเคชัน",
              "เริ่มใช้งานกันเลย !",
              Color(hexColor('#F94B4B')),
              'assets/images/healthNotePage.png')),
    );
  }
}
