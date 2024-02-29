import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/healthChart/bmiChart.dart';
import 'package:flutter_application_1/page/healthChart/glucoseChart.dart';
import 'package:flutter_application_1/page/healthChart/lipidChart.dart';
import 'package:flutter_application_1/page/healthChart/pressureChart.dart';
import 'package:flutter_application_1/page/profile/profile.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';

class HealthChart extends StatelessWidget {
  const HealthChart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HealthChartPage(),
    );
  }
}

class HealthChartPage extends StatefulWidget {
  const HealthChartPage({super.key});

  @override
  State<HealthChartPage> createState() => _HealthChartPageState();
}

class _HealthChartPageState extends State<HealthChartPage> {
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
    fetchLatest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 58),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(hexColor('#484554')),
                    size: 24,
                  ),
                ),
                Text(
                  'กราฟข้อมูลสุขภาพ',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 24,
                )
              ]),
              SizedBox(
                height: 22,
              ),
              Text(
                'ประวัติค่าสุขภาพ',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Image.asset('assets/images/heartPressure.png'),
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
                                Text(timeStamp,
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
                            Text(
                                systolicBloodPressure == '-' ||
                                        diastolicBloodPressure == '-'
                                    ? '-/-'
                                    : '$systolicBloodPressure/$diastolicBloodPressure',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BMIChart()));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(17),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Text(timeStamp,
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
                            Text(bmi,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Text('กก./ม.²',
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
              SizedBox(
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
                    padding: EdgeInsets.all(17),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Image.asset('assets/images/bloodGlucose.png'),
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
                                Text(timeStamp,
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
                            Text(bloodGlucose,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Text('mg/dL',
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LipidChart()));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(17),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Image.asset('assets/images/cholesterolIcon.png'),
                              SizedBox(
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
                            Text(triglyceride,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Text('mg/dL',
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
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
