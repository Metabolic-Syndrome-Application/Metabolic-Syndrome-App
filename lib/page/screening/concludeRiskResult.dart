import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/nav.dart/nav.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

class ConcludeRiskResult extends StatefulWidget {
  final String exerciseFrequency;
  final String exercisePeriod;
  final String diabetes;
  final String hyperlipidemia;
  final String hypertension;
  final String obesity;
  const ConcludeRiskResult(
      {required this.diabetes,
      required this.hyperlipidemia,
      required this.hypertension,
      required this.obesity,
      super.key,
      required this.exerciseFrequency,
      required this.exercisePeriod});

  @override
  State<ConcludeRiskResult> createState() => _ConcludeRiskResultState();
}

class _ConcludeRiskResultState extends State<ConcludeRiskResult> {
  String details = '';
  String symptoms = '';
  String medications = '';
  String behaviors = '';
  String warning = '';

  Future<void> fetchKnowledge(String disease) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getKnowledge(token!, disease);
      setState(() {
        details = response['data']['details'];
        behaviors = response['data']['behaviors'];
        print(response);
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  void initState() {
    fetchDisease();
    widget.exerciseFrequency == 'น้อยกว่า 3 วัน' ||
            widget.exerciseFrequency == 'ไม่ออกกำลังกาย' ||
            widget.exercisePeriod == 'น้อยกว่า 15 นาที'
        ? warning =
            'ควรออกกำลังให้สม่ำเสมอ\nโดยอย่าน้อยควรออกกำลังกายสัปดาห์ละ 3 และขั้นต่ำไม่ควรน้อยกว่า 15 นาทีต่อครั้ง'
        : warning = '';
    super.initState();
  }

  var riskResult = {};
  int checkHigh = 0;
  int checkMedium = 0;
  int checkLow = 0;

  Map<String, dynamic> highList = {};
  Map<String, dynamic> mediumList = {};
  Map<String, dynamic> lowList = {};

  Map<String, dynamic> showList = {};

  final List<Widget> _pagesView = [];

  Future<void> fetchDisease() async {
    String? token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      Map<String, dynamic> response = await getDisease(token!);

      setState(() {
        riskResult = response['data']['diseaseRisk'];

        riskResult.forEach((key, value) {
          if (value == 'high') {
            highList[key] = value;
            checkHigh++;
          } else if (value == 'medium') {
            mediumList[key] = value;
            checkMedium++;
          } else {
            lowList[key] = value;
            checkLow++;
          }
        });

        if (checkHigh >= 1) {
          showList = highList;
        } else if (checkMedium >= 1 && checkHigh == 0) {
          showList = mediumList;
        } else if (checkLow >= 1 && checkHigh == 0 && checkMedium == 0) {
          showList = lowList;
        }

        showList.forEach((key, value) async {
          await fetchKnowledge(key);
          _pagesView.add(
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 61,
                    width: 61,
                    decoration: BoxDecoration(
                      color: value == "high"
                          ? Color(hexColor('#FB6262'))
                          : value == "medium"
                              ? Color(hexColor('#FFC556'))
                              : Color(hexColor('#42884B')),
                      borderRadius: BorderRadius.circular(31),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      key == "diabetes"
                          ? "คุณมีความเสี่ยงที่จะเป็นโรคเบาหวาน"
                          : key == "hyperlipidemia"
                              ? "คุณมีความเสี่ยงที่จะมีภาวะไขมันในเลือดสูง"
                              : key ==
                                      "hypertension" // Did you mean key == "hypertension" here?
                                  ? "คุณมีความเสี่ยงที่จะเป็นโรคความดันเลือดสูง"
                                  : "คุณมีความเสี่ยงที่จะเป็นโรคอ้วน",
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              "คำเเนะนำสำหรับคุณ",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                details,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 57,
                        ),
                        const Row(
                          children: [
                            Text(
                              "การปรับเปลี่ยนพฤติกรรม",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                behaviors,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 57,
                        ),
                        const Row(
                          children: [
                            Text(
                              "เพิ่มเติม",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        warning == ''
                            ? const SizedBox()
                            : Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      warning,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'IBMPlexSansThai',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
        // diabetesResult = response['data']['diseaseRisk']['diabetes'];
        // hyperlipidemiaResult =
        //     response['data']['diseaseRisk']['hyperlipidemia'];
        // hypertensionResult = response['data']['diseaseRisk']['hypertension'];
        // obesityResult = response['data']['diseaseRisk']['obesity'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                  "สรุปผลลัพธ์ความเสี่ยง",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            Expanded(
                flex: 7,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return _pagesView[index];
                      },
                      itemCount: _pagesView.length,
                      // children: [
                      //   SingleChildScrollView(
                      //     child: Column(
                      //       children: [
                      //         Container(
                      //           height: 61,
                      //           width: 61,
                      //           decoration: BoxDecoration(
                      //             color: Color(hexColor('#42884B')),
                      //             borderRadius: BorderRadius.circular(31),
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: 20,
                      //         ),
                      //         const Text(
                      //           "คุณมีความเสี่ยงที่จะเป็นโรคเบาหวาน",
                      //           style: TextStyle(
                      //             fontSize: 20,
                      //             fontFamily: 'IBMPlexSansThai',
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.normal,
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           height: 44,
                      //         ),
                      //         Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 30),
                      //           child: Column(
                      //             children: [
                      //               Row(
                      //                 children: [
                      //                   Text(
                      //                     "คำเเนะนำสำหรับคุณ",
                      //                     style: TextStyle(
                      //                       fontSize: 20,
                      //                       fontFamily: 'IBMPlexSansThai',
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //               SizedBox(
                      //                 height: 20,
                      //               ),
                      //               Container(
                      //                 child: Text(
                      //                   'detailshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',
                      //                   style: TextStyle(
                      //                     fontSize: 16,
                      //                     fontFamily: 'IBMPlexSansThai',
                      //                     color: Colors.black,
                      //                     fontWeight: FontWeight.normal,
                      //                   ),
                      //                 ),
                      //               ),
                      //               SizedBox(
                      //                 height: 57,
                      //               ),
                      //               Row(
                      //                 children: [
                      //                   Text(
                      //                     "โรคที่เกี่ยวข้อง",
                      //                     style: TextStyle(
                      //                       fontSize: 20,
                      //                       fontFamily: 'IBMPlexSansThai',
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //               SizedBox(
                      //                 height: 20,
                      //               ),
                      //               Container(
                      //                 height: 100,
                      //                 decoration: BoxDecoration(
                      //                     color: Color(hexColor('#D9D9D9'))),
                      //               ),
                      //               SizedBox(
                      //                 height: 57,
                      //               ),
                      //               Row(
                      //                 children: [
                      //                   Text(
                      //                     "โรคที่เกี่ยวข้อง",
                      //                     style: TextStyle(
                      //                       fontSize: 20,
                      //                       fontFamily: 'IBMPlexSansThai',
                      //                       color: Colors.black,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //               SizedBox(
                      //                 height: 20,
                      //               ),
                      //               Container(
                      //                 height: 100,
                      //                 decoration: BoxDecoration(
                      //                     color: Color(hexColor('#D9D9D9'))),
                      //               ),
                      //               SizedBox(
                      //                 height: 150,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ],
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
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
                          padding: const EdgeInsets.only(top: 15),
                          child: DotsIndicator(
                            dotsCount: _pagesView.length,
                            position: _currentPage,
                            decorator: DotsDecorator(
                              size: const Size.square(8.0),
                              activeSize: const Size(8.0, 8.0),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 22.5, right: 22.5, top: 40),
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
                                      builder: (context) => const Navbar()));
                            },
                            child: Container(
                              height: 47,
                              alignment: Alignment.center,
                              child: const Text("กลับสู่หน้าหลัก",
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
                )),
          ],
        ),
      ),
    );
  }
}
