import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';

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
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 56,
                    ),
                    Container(child: Image.asset('assets/images/login.png')),
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
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
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
                      height: 47,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              borderSide: BorderSide(
                                color: Color(hexColor('#DBDBDB')),
                                width: 1,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
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
                      height: 47,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24)),
                              borderSide: BorderSide(
                                color: Color(hexColor('#DBDBDB')),
                                width: 1,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: this.value,
                            onChanged: (bool? value) {
                              setState(() {
                                this.value = false;
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
                    ),
                    SizedBox(
                      height: 27,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(hexColor('#2F4EF1')),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      height: 47,
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
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Text(
                        "ลืมรหัสผ่าน ?",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'IBMPlexSansThai',
                          color: Color(hexColor('#484554')),
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ]),
                    SizedBox(
                      height: 22,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(hexColor('#DBDBDB')),
                            height: 25,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ),
                        SizedBox(
                          width: 21,
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
                          width: 21,
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(hexColor('#DBDBDB')),
                            height: 25,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(hexColor('#DBDBDB'))),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      height: 47,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Image.asset('assets/images/google.png')),
                          SizedBox(
                            width: 15,
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
                      height: 34,
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
                          width: 11,
                        ),
                        Text('สมัครใช้งาน',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#2F4EF1')),
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 36,
                    )
                  ],
                ),
              ),
            ],
          ),
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
