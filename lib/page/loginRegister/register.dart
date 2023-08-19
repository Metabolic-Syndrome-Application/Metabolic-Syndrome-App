import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
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
  bool value = false;
  bool _isObscure = false;

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
                      height: 28,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 220,
                          padding: EdgeInsets.only(left: 5),
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            iconSize: 30,
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                          ),
                        )),
                        Image.asset('assets/images/login.png'),
                        Expanded(
                            child: SizedBox(
                          width: 52,
                        ))
                      ],
                    ),
                    Text("ลงทะเบียน",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
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
                        decoration: InputDecoration(
                          hintText: 'example@gmial.com',
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
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          hintText: '●●●●●●●●●●',
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                // check box
                              }),
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
                      height: 47,
                      child: TextField(
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          hintText: '●●●●●●●●●●',
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                // check box
                              }),
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
                      height: 47,
                    ),
                    MaterialButton(
                      color: Color(hexColor('#2F4EF1')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.5),
                      ),
                      onPressed: () {
                        // login by email
                      },
                      child: Container(
                        height: 47,
                        width: 350,
                        alignment: Alignment.center,
                        child: Text("ลงทะเบียน",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(
                      height: 16,
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
                    MaterialButton(
                      height: 47,
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
