import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';

void main() {
  runApp(Permission());
}

class Permission extends StatelessWidget {
  const Permission({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Permission Page",
      home: PermissionPage(),
    );
  }
}

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 103,
                ),
                Image.asset('assets/images/permission.png'),
                SizedBox(
                  height: 65,
                ),
                Text(
                  "ความยินยอมเรื่องข้อมูลส่วนบุคคล",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 23,
                ),
                Text(
                  'Telehealth ให้ความสำคัญกับข้อมูลส่วนบุคคล\nของท่าน โปรดอ่านรายละเอียดเกี่ยวกับเงื่อนไข\nการใช้งาน และนโยบายความเป็นส่วนตัว',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'รับทราบและให้ความยินยอมตาม',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'ข้อตกลงเกี่ยวกับการใช้งานเเละนโยบาย\nความเป็นส่วนตัว',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansThai',
                      color: Color(hexColor('#FB6262')),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 29,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.5),
                ),
                onPressed: () {
                  // login by email
                },
                child: Container(
                  height: 40,
                  width: 150,
                  alignment: Alignment.center,
                  child: Text("ดูรายละเอียด",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center),
                ),
              ),
              SizedBox(width: 19),
              MaterialButton(
                color: Color(hexColor('#2F4EF1')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.5),
                ),
                onPressed: () {
                  // login by email
                },
                child: Container(
                  height: 40,
                  width: 150,
                  alignment: Alignment.center,
                  child: Text("ให้ความยินยอม",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
