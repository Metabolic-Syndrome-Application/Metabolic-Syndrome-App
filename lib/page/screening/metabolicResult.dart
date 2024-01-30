import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/screening/riskScreening.dart';

class MetabolicResultPage extends StatefulWidget {
  final String metabolicResult;
  const MetabolicResultPage({required this.metabolicResult, super.key});

  @override
  State<MetabolicResultPage> createState() => _MetabolicResultPageState();
}

class _MetabolicResultPageState extends State<MetabolicResultPage> {
  @override
  Widget build(BuildContext context) {
    String result = widget.metabolicResult;
    print(result);
    setState(() {
      result = widget.metabolicResult;
    });

    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 37,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 23),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        blurRadius: 4.0,
                        spreadRadius: .1,
                        offset: const Offset(
                          2.0,
                          4.0,
                        ),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    const Text(
                      "ความเสี่ยงที่จะเป็น\nเมทาบอลิกซินโดรม",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: result == "low"
                                ? Color(hexColor('#B7DBC0'))
                                : Color(hexColor('#FDFEFF')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 91,
                          height: 110,
                          child: Column(
                            children: [
                              const SizedBox(
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
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
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
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: result == "medium"
                                ? Color(hexColor('#FFE9C9'))
                                : Color(hexColor('#FDFEFF')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 91,
                          height: 110,
                          child: Column(
                            children: [
                              const SizedBox(
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
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'ความเสี่ยง\nปานกลาง',
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
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: result == "high"
                                ? Color(hexColor('#FFBCBC'))
                                : Color(hexColor('#FDFEFF')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: 91,
                          height: 110,
                          child: Column(
                            children: [
                              const SizedBox(
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
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
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
            ),
            Expanded(child: Image.asset('assets/images/riskResult.png')),
            Expanded(
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
                        if (widget.metabolicResult == 'low') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RiskScreening()));
                        }
                      },
                      child: Container(
                        height: 47,
                        alignment: Alignment.center,
                        child: Text(
                            widget.metabolicResult == "low"
                                ? "เสร็จสิ้น"
                                : "ถัดไป",
                            style: const TextStyle(
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
            )
          ],
        ),
      ),
    );
  }
}
