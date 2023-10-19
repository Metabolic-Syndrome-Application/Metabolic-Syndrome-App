import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/screening/riskScreening.dart';

void main() {
  runApp(MetabolicResult());
}

class MetabolicResult extends StatelessWidget {
  const MetabolicResult({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MetabolicResult',
      home: MetabolicResultPage(),
    );
  }
}

class MetabolicResultPage extends StatefulWidget {
  const MetabolicResultPage({super.key});

  @override
  State<MetabolicResultPage> createState() => _MetabolicResultPageState();
}

class _MetabolicResultPageState extends State<MetabolicResultPage> {
  int _metabolicRiskLevel = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
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
              height: 30,
            ),
            Text(
              "ความเสี่ยงที่จะเป็นเมทาบอลิกซินโดรม",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'IBMPlexSansThai',
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: _metabolicRiskLevel == 1
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
                            borderRadius: BorderRadius.circular(30),
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
                      color: _metabolicRiskLevel == 2
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
                            borderRadius: BorderRadius.circular(30),
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
                      color: _metabolicRiskLevel == 3
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
                            borderRadius: BorderRadius.circular(30),
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
                            if (_metabolicRiskLevel != 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RiskScreening()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            }
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
