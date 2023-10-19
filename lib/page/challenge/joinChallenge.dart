import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/challenge/allChallenge.dart';
import 'package:flutter_application_1/page/challenge/challenge.dart';

class JoinChallenge extends StatelessWidget {
  const JoinChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "JoinChallenge Page",
      home: JoinChallengePage(),
    );
  }
}

class JoinChallengePage extends StatefulWidget {
  const JoinChallengePage({super.key});

  @override
  State<JoinChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<JoinChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('FAFCFB')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10, right: 10, top: 54),
              decoration: BoxDecoration(
                  color: Color(hexColor('#A6CFFF')),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllChallenge()));
                        },
                        child: Container(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 6, bottom: 6),
                        height: 123,
                        child: Image.asset('assets/images/login.png'),
                      ),
                      SizedBox(
                        width: 24,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 34,
                        decoration: BoxDecoration(
                            color: Color(hexColor('#C9E1FD')),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text('ผู้ท้าดวล 245 คน',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21, right: 21),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'สัปดาห์เเห่งการลดน้ำหนัก',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          size: 16,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "40 coins",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          size: 16,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "1 สัปดาห์",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 39,
                    ),
                    Text(
                      'รายละเอียด',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 23, bottom: 23),
                      decoration: BoxDecoration(
                          color: Color(hexColor('#F2F2F2')),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'gggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 44),
                    MaterialButton(
                      color: Color(hexColor('#2F4EF1')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.5),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Challenge()));
                      },
                      child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        child: Text('เข้าร่วม',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
