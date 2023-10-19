import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/home/home.dart';

import '../../extension/Color.dart';

class RiskResult extends StatelessWidget {
  const RiskResult({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RiskResult',
      home: RiskResultPage(),
    );
  }
}

class RiskResultPage extends StatefulWidget {
  const RiskResultPage({super.key});

  @override
  State<RiskResultPage> createState() => _RiskResultPageState();
}

class _RiskResultPageState extends State<RiskResultPage> {
  int _diabetesLevel = 1;
  int _pressureLevel = 2;
  int _lipidLevel = 1;
  int _fatLevel = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 59,
                  ),
                  Text(
                    "ผลลัพธ์ความเสี่ยง",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 22, right: 22),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 16,
                          bottom: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: .1,
                              offset: const Offset(
                                2.0,
                                4.0,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "โรคเบาหวาน",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: _diabetesLevel == 1
                                        ? Color(hexColor('#B7DBC0'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#42884B')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nต่ำ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: _diabetesLevel == 2
                                        ? Color(hexColor('#FFE9C9'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#FFC556')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nกลาง',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: _diabetesLevel == 3
                                        ? Color(hexColor('#FFBCBC'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#FB6262')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nสูง',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: .1,
                              offset: const Offset(
                                2.0,
                                4.0,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "โรคความดันสูง",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: _pressureLevel == 1
                                        ? Color(hexColor('#B7DBC0'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#42884B')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nต่ำ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: _pressureLevel == 2
                                        ? Color(hexColor('#FFE9C9'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#FFC556')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nกลาง',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: _pressureLevel == 3
                                        ? Color(hexColor('#FFBCBC'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#FB6262')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nสูง',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: .1,
                              offset: const Offset(
                                2.0,
                                4.0,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "ภาวะไขมันในเลือดสูง",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: _lipidLevel == 1
                                        ? Color(hexColor('#B7DBC0'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#42884B')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nต่ำ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: _lipidLevel == 2
                                        ? Color(hexColor('#FFE9C9'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#FFC556')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nกลาง',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: _lipidLevel == 3
                                        ? Color(hexColor('#FFBCBC'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#FB6262')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nสูง',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: .1,
                              offset: const Offset(
                                2.0,
                                4.0,
                              ),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "โรคอ้วน",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: _fatLevel == 1
                                        ? Color(hexColor('#B7DBC0'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#42884B')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nต่ำ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: _fatLevel == 2
                                        ? Color(hexColor('#FFE9C9'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#FFC556')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nกลาง',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: _fatLevel == 3
                                        ? Color(hexColor('#FFBCBC'))
                                        : Color(hexColor('#FDFEFF')),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 91,
                                  height: 110,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(hexColor('#FB6262')),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'ความเสี่ยง\nสูง',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 44,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
                height: 93,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 22.5, right: 22.5),
                        child: MaterialButton(
                          height: 44,
                          color: Color(hexColor('#2F4EF1')),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.5),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          },
                          child: Container(
                            height: 47,
                            alignment: Alignment.center,
                            child: Text("เสร็จสิ้น",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
