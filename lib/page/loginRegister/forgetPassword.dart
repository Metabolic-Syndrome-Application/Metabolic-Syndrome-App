import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/loginRegister/login.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Page",
      home: ForgetPasswordPage(),
    );
  }
}

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String _email = '';
  final _controllerEmail = TextEditingController();
  bool _validateEmail = false;

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
                child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 270,
                      alignment: Alignment.topCenter,
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                    )),
                    Image.asset('assets/images/forgotPassword.png'),
                    Expanded(
                        child: SizedBox(
                      width: 52,
                    ))
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            )),
          ),
          SizedBox(
            height: 20,
          ),
          Text("ลืมรหัสผ่าน",
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'IBMPlexSansThai',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center),
          SizedBox(
            height: 12,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(children: [
                Text(
                  'กรุณาใส่อีเมลของคุณ เพื่อเราจะทำการส่งลิงค์\nเพื่อตั้งรหัสผ่านใหม่ไปยังอีเมล',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'IBMPlexSansThai',
                      color: Color(hexColor('#484554')),
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 22),
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
                          borderRadius: BorderRadius.all(Radius.circular(30)),
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: 'example@gmail.com',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Color(hexColor('#999999')),
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(
                            color: Color(hexColor('#DBDBDB')),
                            width: 1,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                MaterialButton(
                  color: Color(hexColor('#2F4EF1')),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _validateEmail = _controllerEmail.text.isEmpty;
                    });

                    if (_email != '') {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                  child: Container(
                    height: 47,
                    width: 350,
                    alignment: Alignment.center,
                    child: Text("รีเซ็ตรหัสผ่าน",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ),
              ])),
        ])));
  }
}
