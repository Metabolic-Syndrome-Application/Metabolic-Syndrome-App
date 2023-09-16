import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/profile/profile.dart';

import '../../extension/Color.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Question Page",
      home: SuccessPage(),
    );
  }
}

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(height: 67),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 24,
                  ),
                ),
              ),
              SizedBox(
                width: 24,
              ),
            ],
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Image.asset(
              'assets/images/success.png',
              height: 258,
            ),
          ),
          SizedBox(
            height: 42,
          ),
          Text(
            'ภารกิจสำเร็จ !',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'IBMPlexSansThai',
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 42,
          ),
          Text(
            'คุณทำได้ดีมาก\nไว้มาท้าดวลภารกิจถัดไปกันต่อนะ',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'IBMPlexSansThai',
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 42,
          ),
          MaterialButton(
            color: Color(hexColor('#2F4EF1')),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23.5),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profile()));
            },
            child: Container(
              height: 44,
              alignment: Alignment.center,
              child: Text('กลับสู่หน้าหลัก',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center),
            ),
          )
        ],
      ),
    ));
  }
}
