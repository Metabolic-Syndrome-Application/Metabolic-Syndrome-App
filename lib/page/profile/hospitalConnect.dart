import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/loginRegister/otpRegister.dart';
import 'package:flutter_application_1/page/profile/profile.dart';
import 'package:flutter_application_1/page/profile/successConnect.dart';

import '../../extension/Color.dart';

class hospitalConnect extends StatelessWidget {
  const hospitalConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: hospitalConnectPage(),
    );
  }
}

class hospitalConnectPage extends StatefulWidget {
  const hospitalConnectPage({super.key});

  @override
  State<hospitalConnectPage> createState() => _hospitalConnectPageState();
}

class _hospitalConnectPageState extends State<hospitalConnectPage> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  Color? validColor;
  Duration myDuration = Duration(minutes: 3);
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
                height: 80,
              ),
              MaterialButton(
                  height: 44,
                  color: Color(hexColor('#2F4EF1')),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.5),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("ยืนยัน",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  onPressed: () async {
                    //   if (await widget.myauth.verifyOTP(
                    //           otp: otp1Controller.text +
                    //               otp2Controller.text +
                    //               otp3Controller.text +
                    //               otp4Controller.text +
                    //               otp5Controller.text +
                    //               otp6Controller.text) ==
                    //       true) {
                    //     setState(() {
                    //       validColor = Colors.green;
                    //     });

                    //     // ScaffoldMessenger.of(context)
                    //     //     .showSnackBar(const SnackBar(
                    //     //   content: Text("OTP is verified"),
                    //     // ));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SuccessConnect()));
                    // } else {
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(const SnackBar(
                    //     content: Text("Invalid OTP"),
                    //   ));
                    //   }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
