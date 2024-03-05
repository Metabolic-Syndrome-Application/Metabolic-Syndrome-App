import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/loginRegister/otpRegister.dart';
import 'package:flutter_application_1/page/profile/profile.dart';
import 'package:flutter_application_1/page/profile/successConnect.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';

class HospitalConnect extends StatelessWidget {
  const HospitalConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HospitalConnectPage(),
    );
  }
}

class HospitalConnectPage extends StatefulWidget {
  const HospitalConnectPage({super.key});

  @override
  State<HospitalConnectPage> createState() => _HospitalConnectPageState();
}

class _HospitalConnectPageState extends State<HospitalConnectPage> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  Color? validColor;
  Duration myDuration = Duration(minutes: 3);
  String success = '';
  bool matching = false;
  bool full = false;
  String validation = '';

  Future<void> fetchConnectHostpital(String otp) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await postConnect(token!, otp);
      // print(otp);
      setState(() {
        // print(response);
        success = response['message'];
        // print();
      });
    } catch (e) {
      print('Error fetching plan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
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
                )
              ]),
              SizedBox(
                height: 80,
              ),
              Text(
                'กรุณากรอกรหัสยืนยัน\nเพื่อเชื่อมต่อเข้ากับสถานพยาบาล',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
              Image.asset(
                'assets/images/otp1.png',
                height: 148,
              ),
              SizedBox(
                height: 36,
              ),
              Text(
                'รหัสยืนยัน',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Otp(
                    otpController: otp1Controller,
                    validColor: validColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Otp(
                    otpController: otp2Controller,
                    validColor: validColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Otp(
                    otpController: otp3Controller,
                    validColor: validColor,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Otp(
                    otpController: otp4Controller,
                    validColor: validColor,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                validation,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Color(hexColor('#FB6262')),
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                  height: 44,
                  color: Color(hexColor('#2F4EF1')),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.5),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text("ยืนยัน",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  onPressed: () async {
                    if (otp1Controller.text.isNotEmpty &&
                        otp2Controller.text.isNotEmpty &&
                        otp3Controller.text.isNotEmpty &&
                        otp4Controller.text.isNotEmpty) {
                      await fetchConnectHostpital(otp1Controller.text +
                          otp2Controller.text +
                          otp3Controller.text +
                          otp4Controller.text);
                      // print(success);
                      if (success == 'OTP matching') {
                        validColor = Color(hexColor('#42884B'));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuccessConnect()));
                      } else {
                        setState(() {
                          validation = '*รหัสยืนยันไม่ตรงกัน';
                        });
                      }
                    } else {
                      if (otp1Controller.text.isNotEmpty ||
                          otp2Controller.text.isNotEmpty ||
                          otp3Controller.text.isNotEmpty ||
                          otp4Controller.text.isNotEmpty) {
                        setState(() {
                          validation = '*กรุณากรอกรหัสยืนยันให้ครบก่อนยืนยัน';
                        });
                      } else {
                        setState(() {
                          validation = '*กรุณากรอกรหัสก่อนยืนยัน';
                        });
                      }
                      validColor = Color(hexColor('#FB6262'));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
