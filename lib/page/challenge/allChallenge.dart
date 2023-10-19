import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/widget/challenge/challenge.dart';
import 'package:flutter_application_1/widget/challenge/question.dart';
import 'package:flutter_application_1/widget/challenge/yourChallenge.dart';

class AllChallenge extends StatelessWidget {
  const AllChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllChallenge',
      home: AllChallengePage(),
    );
  }
}

class AllChallengePage extends StatefulWidget {
  const AllChallengePage({super.key});

  @override
  State<AllChallengePage> createState() => _AllChallengePageState();
}

class _AllChallengePageState extends State<AllChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 58),
            child: Column(
              children: [
                Text(
                  "ท้าดวล",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(children: [
                  Image.asset('assets/images/your_challenge_icon.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text("ภารกิจของคุณ",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ))
                ]),
                SizedBox(
                  height: 22,
                ),
                YourChallengeCard(),
                SizedBox(
                  height: 46,
                ),
                Row(children: [
                  Image.asset('assets/images/question_challenge_icon.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text("คำถามประจำวัน",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ))
                ]),
                QuestionCard(),
                SizedBox(
                  height: 46,
                ),
                Row(children: [
                  Image.asset('assets/images/hit_challenge_icon.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text("ภารกิจมาเเรง",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ))
                ]),
                ChallengeCard(),
              ],
            ),
          ),
        ));
  }
}
