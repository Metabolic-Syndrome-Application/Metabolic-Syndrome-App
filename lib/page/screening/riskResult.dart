import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/screening/concludeRiskResult.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';

class RiskResultPage extends StatefulWidget {
  const RiskResultPage({
    super.key,
  });

  @override
  State<RiskResultPage> createState() => _RiskResultPageState();
}

class _RiskResultPageState extends State<RiskResultPage> {
  @override
  void initState() {
    super.initState();
    fetchDisease();
  }

  String diabetesResult = "";
  String hyperlipidemiaResult = "";
  String hypertensionResult = "";
  String obesityResult = "";

  Future<void> fetchDisease() async {
    String? token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      Map<String, dynamic> response = await getDisease(token!);
      setState(() {
        diabetesResult = response['data']['diseaseRisk']['diabetes'];
        hyperlipidemiaResult =
            response['data']['diseaseRisk']['hyperlipidemia'];
        hypertensionResult = response['data']['diseaseRisk']['hypertension'];
        obesityResult = response['data']['diseaseRisk']['obesity'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: Center(
          child: Column(
            children: [
              const Column(
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
                    height: 14,
                  ),
                ],
              ),
              Expanded(
                flex: 7,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(left: 22, right: 22),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
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
                                  const Text(
                                    "โรคเบาหวาน",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: diabetesResult == "low"
                                              ? Color(hexColor('#B7DBC0'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#42884B')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                          color: diabetesResult == "medium"
                                              ? Color(hexColor('#FFE9C9'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#FFC556')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text(
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
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: diabetesResult == "high"
                                              ? Color(hexColor('#FFBCBC'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#FB6262')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                            const SizedBox(
                              height: 32,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
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
                                  const Text(
                                    "โรคความดันสูง",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: hypertensionResult == "low"
                                              ? Color(hexColor('#B7DBC0'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#42884B')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                          color: hypertensionResult == "medium"
                                              ? Color(hexColor('#FFE9C9'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#FFC556')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text(
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
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: hypertensionResult == "high"
                                              ? Color(hexColor('#FFBCBC'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#FB6262')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                            const SizedBox(
                              height: 32,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
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
                                  const Text(
                                    "ภาวะไขมันในเลือดสูง",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: hyperlipidemiaResult == "low"
                                              ? Color(hexColor('#B7DBC0'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#42884B')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                          color:
                                              hyperlipidemiaResult == "medium"
                                                  ? Color(hexColor('#FFE9C9'))
                                                  : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#FFC556')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text(
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
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: hyperlipidemiaResult == "high"
                                              ? Color(hexColor('#FFBCBC'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#FB6262')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                            const SizedBox(
                              height: 32,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
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
                                  const Text(
                                    "โรคอ้วน",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: obesityResult == "low"
                                              ? Color(hexColor('#B7DBC0'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#42884B')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                          color: obesityResult == "medium"
                                              ? Color(hexColor('#FFE9C9'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#FFC556')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text(
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
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: obesityResult == "high"
                                              ? Color(hexColor('#FFBCBC'))
                                              : Color(hexColor('#FDFEFF')),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                                color:
                                                    Color(hexColor('#FB6262')),
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                            const SizedBox(
                              height: 120,
                            )
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect rect) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.purple,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.purple
                              ],
                              stops: [
                                0.0,
                                0.2,
                                1.0,
                                1.0
                              ], // 10% purple, 80% transparent, 10% purple
                            ).createShader(rect);
                          },
                          blendMode: BlendMode.dstOut,
                          child: Container(
                            height: 120,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.5, right: 22.5, bottom: 48),
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
                                      builder: (context) => ConcludeRiskResult(
                                          diabetes: diabetesResult,
                                          hyperlipidemia: hyperlipidemiaResult,
                                          hypertension: hypertensionResult,
                                          obesity: obesityResult)));
                            },
                            child: Container(
                              height: 47,
                              alignment: Alignment.center,
                              child: const Text("เสร็จสิ้น",
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
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
