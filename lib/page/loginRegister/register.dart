import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/loginRegister/login.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Register Page",
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool visiblePassword = false;
  bool visibleConfirmPassword = false;

  bool fillPassword = false;

  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerConfirmPassword = TextEditingController();

  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateConfirmPassword = false;

  bool _notSame = false;

  bool _conditionPassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[_]).{8,}$');
    //r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
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
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth,
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.023),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    iconSize: 30,
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                    },
                                  ),
                                  Container(
                                      height: screenHeight * 0.195,
                                      child: Image.asset(
                                          'assets/images/register.png')),
                                  SizedBox(
                                    width: 52,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.023,
                              ),
                              Text("ลงทะเบียน",
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
                      ],
                    )),
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
                            Text("อีเมล",
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
                              _email = value;
                            });
                          },
                          controller: _controllerEmail,
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
                            errorText: _validateEmail && _email == ''
                                ? "กรุณากรอกอีเมล"
                                : null,
                            errorStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#FB6262')),
                              fontWeight: FontWeight.normal,
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
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
                            errorMaxLines: 3,
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                  width: 1,
                                )),
                            errorText: !_conditionPassword(_password) &&
                                    _password != ''
                                ? '*** รหัสผ่านขั้นต่ำ 8 ตัวอักษร\nโดยประกอบด้วยตัวอักษรภาษาอังกฤษ ตัวพิมพ์เล็ก, ตัวพิมพ์ใหญ่, ตัวเลข, เครื่องหมาย "_" อย่างน้อย 1 ตัว'
                                : _validatePassword && _password == ''
                                    ? "กรุณากรอกรหัสผ่าน"
                                    : null,
                            errorStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#FB6262')),
                              fontWeight: FontWeight.normal,
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * .025,
                            vertical: screenHeight * 0.012),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("ยืนยันรหัสผ่าน",
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
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              _notSame = false;
                              _confirmPassword = value;
                            });
                          },
                          controller: _controllerConfirmPassword,
                          obscuringCharacter: '●',
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: !visibleConfirmPassword,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#DBDBDB')),
                                  width: 1,
                                )),
                            errorText: !_conditionPassword(_password)
                                ? null
                                : _validateConfirmPassword &&
                                        _confirmPassword == ''
                                    ? "กรุณากรอกยืนยันรหัสผ่าน"
                                    : _notSame
                                        ? "ยืนยันรหัสผ่านไม่ตรงกัน"
                                        : null,
                            errorStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#FB6262')),
                              fontWeight: FontWeight.normal,
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
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
                                icon: Icon(visibleConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    visibleConfirmPassword =
                                        !visibleConfirmPassword;
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
                      SizedBox(height: screenHeight * 0.048),
                      MaterialButton(
                        height: screenHeight * 0.048,
                        color: Color(hexColor('#2F4EF1')),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23.5),
                        ),
                        onPressed: () {
                          if (_controllerEmail.text.isEmpty == true) {
                            setState(() {
                              _validateEmail = _controllerEmail.text.isEmpty;
                              _validatePassword = false;
                              _validateConfirmPassword = false;
                              _notSame = false;
                            });
                          } else if (_controllerPassword.text.isEmpty == true) {
                            setState(() {
                              _validateEmail = false;
                              _validatePassword =
                                  _controllerPassword.text.isEmpty;
                              _validateConfirmPassword = false;
                              _notSame = false;
                            });
                          } else {
                            setState(() {
                              _validateEmail = false;
                              _validatePassword = false;
                              _validateConfirmPassword =
                                  _controllerConfirmPassword.text.isEmpty;
                              _notSame = false;
                            });
                          }
                          ;

                          if (_password != '' &&
                              _email != '' &&
                              _confirmPassword != '' &&
                              _conditionPassword(_password)) {
                            if (_password == _confirmPassword) {
                              setState(() {
                                _notSame = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            } else {
                              setState(() {
                                _notSame = true;
                              });
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("ลงทะเบียน",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
