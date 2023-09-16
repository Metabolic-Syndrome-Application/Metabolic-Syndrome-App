import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/widget/challenge/challenge.dart';
import 'package:flutter_application_1/widget/challenge/question.dart';
import 'package:flutter_application_1/widget/challenge/yourChallenge.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
            child: Column(
              children: [
                Text(
                  "ท้าดวล",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(children: [
                  Icon(Icons.circle),
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
                  Icon(Icons.circle),
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
                QuestionCard(),
                SizedBox(
                  height: 46,
                ),
                Row(children: [
                  Icon(Icons.circle),
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
                ChallengeCard(),
              ],
            ),
          ),
        ));
  }
}
