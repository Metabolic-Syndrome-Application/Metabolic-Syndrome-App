import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/loginRegister/forgetPassword.dart';
import 'package:flutter_application_1/page/loginRegister/register.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Page",
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberLogin = false;
  bool visiblePassword = false;
  bool fillPassword = false;

  String _ssnEmail = '';
  String _password = '';

  final _controllerSsnEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  bool _validateSsnEmail = false;
  bool _validatePassword = false;

  @override
  void dispose() {
    _controllerSsnEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.023),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Container(
                        height: screenHeight * 0.195,
                        child: Image.asset('assets/images/login.png')),
                    SizedBox(
                      height: screenHeight * 0.023,
                    ),
                    Text("เข้าสู่ระบบ",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * .025,
                          vertical: screenHeight * 0.012),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("เลขบัตรประชาชนหรืออีเมล",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _ssnEmail = value;
                          });
                        },
                        controller: _controllerSsnEmail,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                color: Color(hexColor('#DBDBDB')),
                                width: 1,
                              )),
                          errorText: _validateSsnEmail && _ssnEmail == ''
                              ? "กรุณากรอกเลขบัตรประชาชนหรืออีเมล"
                              : null,
                          errorStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'IBMPlexSansThai',
                            color: Color(hexColor('#FB6262')),
                            fontWeight: FontWeight.normal,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintText: 'email@example.com',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Color(hexColor('#999999')),
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                color: Color(hexColor('#DBDBDB')),
                                width: 1,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.012,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * .025,
                          vertical: screenHeight * 0.012),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("รหัสผ่าน",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.start),
                          ]),
                    ),
                    SizedBox(
                      // height: screenHeight * 0.055,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        controller: _controllerPassword,
                        obscuringCharacter: '●',
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.center,
                        obscureText: !visiblePassword,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                color: Color(hexColor('#DBDBDB')),
                                width: 1,
                              )),
                          errorText: _validatePassword && _password == ''
                              ? "กรุณากรอกรหัสผ่าน"
                              : null,
                          errorStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'IBMPlexSansThai',
                            color: Color(hexColor('#FB6262')),
                            fontWeight: FontWeight.normal,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintText: '●●●●●●●●●●',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Color(hexColor('#999999')),
                            fontWeight: FontWeight.normal,
                          ),
                          suffixIcon: IconButton(
                              iconSize: 16,
                              color: Color(hexColor('#999999')),
                              icon: Icon(visiblePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  visiblePassword = !visiblePassword;
                                });
                              }),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                color: Color(hexColor('#DBDBDB')),
                                width: 1,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.012,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: Color(hexColor('#2F4EF1')),
                          shape: CircleBorder(),
                          value: this.rememberLogin,
                          onChanged: (bool? rememberLogin) {
                            setState(() {
                              this.rememberLogin = !this.rememberLogin;
                            });
                          },
                        ), //Che
                        Text(
                          "จำไว้ในระบบ",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    MaterialButton(
                      height: screenHeight * 0.048,
                      color: Color(hexColor('#2F4EF1')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.5),
                      ),
                      onPressed: () {
                        if (_controllerSsnEmail.text.isEmpty == true) {
                          setState(() {
                            _validateSsnEmail =
                                _controllerSsnEmail.text.isEmpty;
                            _validatePassword = false;
                          });
                        } else {
                          setState(() {
                            _validateSsnEmail = false;
                            _validatePassword =
                                _controllerPassword.text.isEmpty;
                          });
                        }

                        if (_password != '' && _ssnEmail != '') {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("เข้าสู่ระบบ",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.002,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()));
                        },
                        child: Text(
                          "ลืมรหัสผ่าน ?",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'IBMPlexSansThai',
                            color: Color(hexColor('#484554')),
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ]),
                    SizedBox(
                      height: screenHeight * 0.002,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(hexColor('#DBDBDB')),
                            thickness: 1,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * .050,
                        ),
                        Text(
                          'หรือ ดำเนินการต่อ',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#484554')),
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          width: screenWidth * .050,
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(hexColor('#DBDBDB')),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    MaterialButton(
                      height: screenHeight * 0.048,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.5),
                      ),
                      onPressed: () {
                        //loging by google
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Image.asset('assets/images/google.png')),
                          SizedBox(
                            width: screenWidth * .025,
                          ),
                          Text("เข้าสู่ระบบด้วย Google",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('คุณมีบัญชี Account เเล้วหรือยัง?',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#484554')),
                              fontWeight: FontWeight.normal,
                            )),
                        SizedBox(
                          width: screenWidth * .025,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Text('สมัครใช้งาน',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#2F4EF1')),
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
