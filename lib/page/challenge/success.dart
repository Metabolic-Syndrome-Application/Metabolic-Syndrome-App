import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/challenge/allChallenge.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/profile/profile.dart';

import '../../extension/Color.dart';

class SuccessPage extends StatefulWidget {
  final String result;
  const SuccessPage({required this.result, super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    print(widget.result);
    super.initState();
  }

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
                      MaterialPageRoute(builder: (context) => AllChallenge()));
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
            widget.result == 'correct' ? 'ภารกิจสำเร็จ !' : 'คำตอบผิด !',
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
          Text( widget.result == 'correct' ? 
            'คุณทำได้ดีมาก\nไว้มาท้าดวลภารกิจถัดไปกันต่อนะ':'คุณพยายามที่สุดแล้ว เก่งมาก ไว้มาตอบคำถามใหม่ในวันพรุ่งนี้นะ',
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
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
