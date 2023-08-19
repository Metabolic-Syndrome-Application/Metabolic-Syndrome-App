import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: Column(
          children: [
            Container(
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 56,
                  ),
                  Container(
                      width: 224,
                      height: 165,
                      child: Image.asset('assets/images/login.png')),
                  SizedBox(
                    height: 19,
                  ),
                  Text("เข้าสู่ระบบ",
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 19,
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    width: 335,
                    child: Text("อีเมล",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.start),
                  ),
                  SizedBox(
                    height: 47,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            borderSide: BorderSide(
                              color: Color(hexColor('#DBDBDB')),
                              width: 1,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    width: 335,
                    child: Text("รหัสผ่าน",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.start),
                  ),
                  SizedBox(
                    height: 47,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            borderSide: BorderSide(
                              color: Color(hexColor('#DBDBDB')),
                              width: 1,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 21,
                    width: 350,
                    child: Text(
                      "จำไว้ในระบบ",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    height: 27,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(hexColor('#2F4EF1')),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: 47,
                    width: 350,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text("เข้าสู่ระบบ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 23,
                    width: 350,
                    child: Text("ลืมรหัสผ่าน",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.end,
                    )
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
/*
Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
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

 */
