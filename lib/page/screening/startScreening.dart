import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/screening/screening.dart';

import '../../extension/Color.dart';

class StartScreening extends StatefulWidget {
  final bool? firsttime;
  const StartScreening({this.firsttime, super.key});

  @override
  State<StartScreening> createState() => _StartScreeningState();
}

class _StartScreeningState extends State<StartScreening> {
  final PageController _pageController = PageController();
  bool firsttime = false;

  @override
  void initState() {
    firsttime = widget.firsttime ?? false;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              firsttime
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Color(hexColor('#484554')),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset('assets/images/sceening.png'),
                    SizedBox(
                      height: 44,
                    ),
                    Text('เเบบประเมินสุขภาพ',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        )),
                    SizedBox(height: 18),
                    Text(
                      'ทำเเบบประเมินความเสี่ยงสุขภาพ\nเพื่อช่วยวิเคราะห์ความเสี่ยงเเละติดตามค่าสุขภาพของคุณ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 2.5, right: 2.5),
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
                                builder: (context) => ScreeningPage()));
                      },
                      child: Container(
                        height: 47,
                        alignment: Alignment.center,
                        child: Text("เริ่มทำแบบประเมิน",
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
      ),
    );
  }
}
