import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/calendar.dart/selectCalendar.dart';
import 'package:flutter_application_1/page/healthChart/GlucoseChart.dart';
import 'package:flutter_application_1/page/healthChart/bmiChart.dart';
import 'package:flutter_application_1/page/healthChart/lipidChart.dart';
import 'package:flutter_application_1/page/healthChart/pressureChart.dart';
import 'package:flutter_application_1/page/learning/searchLearning.dart';
import 'package:flutter_application_1/page/notification/notificate.dart';
import 'package:flutter_application_1/page/profile/profile.dart';
import 'package:flutter_application_1/page/ranking/ranking.dart';
import 'package:flutter_application_1/page/screening/startScreening.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? alias;
  int? coin;

  Future<void> fetchProfile() async {
    String? token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      Map<String, dynamic> response = await getProfile(token!);
      setState(() {
        print(response);
        alias = response['data']['user']['alias'];
        coin = response['data']['user']['collectPoints'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  String timeStamp = '--:--';
  String systolicBloodPressure = '-';
  String diastolicBloodPressure = '-';
  String bmi = '-';
  String bloodGlucose = '-';
  String triglyceride = '-';

  Future<void> fetchLatest() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getLatestRecord(token!);
      setState(() {
        systolicBloodPressure =
            response['data']['record'][0]['systolicBloodPressure'].toString();
        diastolicBloodPressure =
            response['data']['record'][0]['diastolicBloodPressure'].toString();
        bmi = response['data']['record'][0]['bmi'].toStringAsFixed(2);
        bloodGlucose = response['data']['record'][0]['bloodGlucose'].toString();
        triglyceride = response['data']['record'][0]['triglyceride'].toString();
        timeStamp = response['data']['record'][0]['timestamp'];
        DateTime inputDateTime = DateTime.parse(timeStamp);
        timeStamp = DateFormat('dd MMM HH:mm', 'th').format(inputDateTime);
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  void initState() {
    fetchProfile();
    fetchLatest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 59),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          // profile
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));
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
                                      child: const Ranking()));
                            },
                            child:
                                Image.asset('assets/images/solarRanking.png')),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Notificate()));
                            },
                            child: Image.asset('assets/images/bellRing.png')),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 6),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Image.asset(
                      'assets/images/home.png',
                      height: 178,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ยินดีต้อนรับ',
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          alias ?? '',
                          style: const TextStyle(
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Ranking()));
                                },
                                child:
                                    Image.asset('assets/images/piggyBank.png')),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              coin == null
                                  ? '- คะแนน'
                                  : coin.toString() + " คะแนน",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#42884B')),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
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
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'แผนสุขภาพ',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
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
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                width: 100,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Image.asset(
                                        'assets/images/stethoscope.png'),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
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
                                      builder: (context) =>
                                          SelectedDate(DateTime.now(), true)));
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
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          'assets/images/stretching.png'),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text(
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
                                          const SearchingLearning()));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              // builder: (context) => AllChallenge()));
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
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          'assets/images/heartbeat.png'),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Text(
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
              const SizedBox(
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
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'กราฟข้อมูลสุขภาพ',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
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
                          padding: const EdgeInsets.all(17),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image.asset(
                                        'assets/images/heartPressure.png'),
                                    const SizedBox(
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
                                      Text(timeStamp,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#484554')),
                                            fontWeight: FontWeight.normal,
                                          )),
                                      const SizedBox(
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
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                      systolicBloodPressure == '-' ||
                                              diastolicBloodPressure == '-'
                                          ? '-/-'
                                          : '$systolicBloodPressure/$diastolicBloodPressure',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('mmHg',
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
                    const SizedBox(
                      height: 20,
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
                                  builder: (context) => const BMIChart()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(17),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image.asset('assets/images/runHuman.png'),
                                    const SizedBox(
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
                                      Text(timeStamp,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#484554')),
                                            fontWeight: FontWeight.normal,
                                          )),
                                      const SizedBox(
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
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(bmi,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('กก./ม.²',
                                      style: TextStyle(
                                        fontSize: 16,
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
                    const SizedBox(
                      height: 20,
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
                                  builder: (context) => const GlucoseChart()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(17),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image.asset(
                                        'assets/images/bloodGlucose.png'),
                                    const SizedBox(
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
                                      Text(timeStamp,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#484554')),
                                            fontWeight: FontWeight.normal,
                                          )),
                                      const SizedBox(
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
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(bloodGlucose,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('mg/dL',
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
                    const SizedBox(
                      height: 20,
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
                                  builder: (context) => const LipidChart()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(17),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Image.asset(
                                        'assets/images/cholesterolIcon.png'),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text('ไขมันในเลือด',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Color(hexColor('#FF9900')),
                                          fontWeight: FontWeight.normal,
                                        ))
                                  ]),
                                  Row(
                                    children: [
                                      Text(timeStamp,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#484554')),
                                            fontWeight: FontWeight.normal,
                                          )),
                                      const SizedBox(
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
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(triglyceride,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text('mg/dL',
                                      style: TextStyle(
                                        fontSize: 16,
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
                    const SizedBox(
                      height: 80,
                    ),
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
