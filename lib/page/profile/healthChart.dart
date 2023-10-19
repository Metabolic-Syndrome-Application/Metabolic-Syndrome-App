import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/healthChart/pressureChart.dart';
import 'package:flutter_application_1/page/profile/profile.dart';

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
                    fontWeight: FontWeight.normal,
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
                'วันนี้',
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
                            builder: (context) => PressureChart()));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(17),
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
                  onTap: () {},
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
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(17),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ],
          ),
        ),
      ),
    );
  }
}
