import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/healthChart/pressureChart.dart';
import 'package:flutter_application_1/page/learning/searchLearning.dart';
import 'package:flutter_application_1/page/note/todayNote.dart';
import 'package:flutter_application_1/page/notification/notificate.dart';
import 'package:flutter_application_1/page/profile/profile.dart';
import 'package:flutter_application_1/page/ranking/ranking.dart';
import 'package:flutter_application_1/page/screening/startScreening.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? alias;
  Future<void> getProfile(String accesstoken) async {
    final url = Uri.parse("http://10.66.8.149:8000/api/user/profile");
    final response = await http
        .get(url, headers: {'Authorization': 'Bearer ${accesstoken}'});
    print('profile Response body: ${response.body}');
    alias = json.decode(response.body)['data']['user']['alias'];
  }

  @override
  Widget build(BuildContext context) {
    String? token = Provider.of<AuthProvider>(context).token;
    getProfile(token!);

    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 59),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          //profile
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        child: Image.asset('assets/images/userCircle.png')),
                    Row(
                      children: [
                        InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: Ranking()));
                            },
                            child:
                                Image.asset('assets/images/solarRanking.png')),
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Notificate()));
                            },
                            child: Image.asset('assets/images/bellRing.png')),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ยินดีต้อนรับ',
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          alias??'',
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  //points
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Ranking()));
                                },
                                child:
                                    Image.asset('assets/images/piggyBank.png')),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '100 คะแนน',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#42884B')),
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Image.asset(
                      'assets/images/home.png',
                      height: 178,
                    )
                  ],
                ),
              ),
              SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/information.png',
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'แผนสุขภาพ',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const StartScreening()));
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 255, 141, 106),
                                      Color.fromARGB(255, 249, 119, 80)
                                    ]),
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                width: 100,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/images/stethoscope.png'),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'ประเมิน\nสุขภาพ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                )),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TodayNote()));
                            },
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(255, 255, 196, 86),
                                        Color.fromARGB(255, 250, 182, 57)
                                      ]),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          'assets/images/stretching.png'),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'โปรเเกรม\nสุขภาพ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )),
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchingLearning()));
                            },
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromARGB(255, 66, 136, 75),
                                        Color.fromARGB(255, 52, 114, 60)
                                      ]),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          'assets/images/heartbeat.png'),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'ความรู้\n',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/chartLine.png',
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'กราฟข้อมูลสุขภาพ',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PressureChart()));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image.asset(
                                        'assets/images/heartPressure.png'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('ความดัน',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Color(hexColor('#FB6262')),
                                          fontWeight: FontWeight.normal,
                                        ))
                                  ]),
                                  Row(
                                    children: [
                                      Text('09:45',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#484554')),
                                            fontWeight: FontWeight.normal,
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: Color(hexColor('#7B7B7B')),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text('110/75',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('mmHg',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          print('ค่าดัชนีมวลกาย');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image.asset('assets/images/runHuman.png'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('ค่าดัชนีมวลกาย',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Color(hexColor('#42884B')),
                                          fontWeight: FontWeight.normal,
                                        ))
                                  ]),
                                  Row(
                                    children: [
                                      Text('09:45',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#484554')),
                                            fontWeight: FontWeight.normal,
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: Color(hexColor('#7B7B7B')),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('19.0',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          print('ระดับน้ำตาล');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(17),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image.asset('assets/images/bloodSugar.png'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('ระดับน้ำตาล',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Color(hexColor('#2F4EF1')),
                                          fontWeight: FontWeight.normal,
                                        ))
                                  ]),
                                  Row(
                                    children: [
                                      Text('14 ส.ค.',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#484554')),
                                            fontWeight: FontWeight.normal,
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: Color(hexColor('#7B7B7B')),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text('110/75',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('mmHg',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
