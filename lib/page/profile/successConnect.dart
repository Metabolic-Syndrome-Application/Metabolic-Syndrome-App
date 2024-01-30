import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/profile/treatmentInformation.dart';

import '../../extension/Color.dart';

class SuccessConnect extends StatelessWidget {
  const SuccessConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SuccessConnectPage(),
    );
  }
}

class SuccessConnectPage extends StatefulWidget {
  const SuccessConnectPage({super.key});

  @override
  State<SuccessConnectPage> createState() => _SuccessConnectPageState();
}

class _SuccessConnectPageState extends State<SuccessConnectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(hexColor('#484554')),
                    size: 24,
                  ),
                ),
                Text(
                  'การเชื่อมต่อสถานพยาบาล',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
              ]),
              SizedBox(
                height: 9,
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset('assets/images/successConnect.png'),
                  Image.asset('assets/images/successConnectSun.png')
                ],
              ),
              SizedBox(
                height: 28,
              ),
              Text(
                'การเชื่อมต่อสำเร็จ',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 28,
              ),
              Text(
                'การเชื่อมต่อเข้ากับสถานพยาบาล\nสำเร็จแล้ว',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBMPlexSansThai',
                  color: Color(hexColor('#484554')),
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 60,
              ),
              MaterialButton(
                  height: 44,
                  color: Color(hexColor('#2F4EF1')),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.5),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("ดูข้อมูลการรักษาปัจจุบัน",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TreatmentInformation()));
                  })
            ],
          ),
        ),
      )),
    );
  }
}
