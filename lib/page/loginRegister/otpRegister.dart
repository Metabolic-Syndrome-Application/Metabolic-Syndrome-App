import 'dart:async';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/loginRegister/createProfile.dart';
import 'package:flutter_application_1/page/loginRegister/register.dart';

class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    this.validColor,
    required this.otpController,
  }) : super(key: key);

  final TextEditingController otpController;
  final Color? validColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color:
                validColor == null ? Color(hexColor('#DBDBDB')) : validColor!,
          ),
          borderRadius: BorderRadius.circular(10)),
      width: 40,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration:
            const InputDecoration(hintText: (''), border: InputBorder.none),
        onSaved: (value) {},
      ),
    );
  }
}

class OTPRegister extends StatefulWidget {
  String email;
  EmailOTP myauth;

  OTPRegister({required this.email, required this.myauth, super.key});

  @override
  State<OTPRegister> createState() => _OTPRegisterState();
}

class _OTPRegisterState extends State<OTPRegister> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  TextEditingController otp5Controller = TextEditingController();
  TextEditingController otp6Controller = TextEditingController();

  String otpController = "123456";
  Color? validColor;
  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: 3);

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();

    setState(() => myDuration = Duration(minutes: 3));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    // final days = strDigits(myDuration.inDays); // <-- SEE HERE
    // final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    startTimer();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(hexColor('#484554')),
                          size: 24,
                        ),
                      ),
                      Text(
                        'ยืนยันบัญชีอีเมลผู้ใช้',
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
                SizedBox(height: 20),
                Text(
                  'กรุณากรอกรหัสยืนยัน\nเพื่อยืนยันว่าเป็นผู้ใช้งานอีเมลจริง',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Color(hexColor('#484554')),
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                Image.asset('assets/images/otp.png'),
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
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        //
                      },
                      child: Row(
                        children: [
                          Icon(Icons.timer, color: Colors.black, size: 20),
                          SizedBox(
                            width: 5,
                          ),
                          Text('เหลือเวลาอีก ',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              )),
                          Text(
                            '$minutes:$seconds',
                            style: TextStyle(
                                fontFamily: 'IBMPlexSansThai',
                                fontWeight: FontWeight.normal,
                                color: Color(hexColor('#2F4EF1')),
                                fontSize: 14),
                          ),
                          Text(' นาที',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 38,
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
                    SizedBox(
                      width: 20,
                    ),
                    Otp(
                      otpController: otp5Controller,
                      validColor: validColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Otp(
                      otpController: otp6Controller,
                      validColor: validColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        //
                        widget.myauth.sendOTP();

                        resetTimer();
                        startTimer();
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/images/redo.png'),
                          SizedBox(
                            width: 5,
                          ),
                          Text('ส่งคำขอรหัสอีกครั้ง',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#2F4EF1')),
                                fontWeight: FontWeight.normal,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
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
                      if (await widget.myauth.verifyOTP(
                              otp: otp1Controller.text +
                                  otp2Controller.text +
                                  otp3Controller.text +
                                  otp4Controller.text +
                                  otp5Controller.text +
                                  otp6Controller.text) ==
                          true) {
                        setState(() {
                          validColor = Colors.green;
                        });

                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(const SnackBar(
                        //   content: Text("OTP is verified"),
                        // ));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateProfilePage()));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Invalid OTP"),
                        ));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
