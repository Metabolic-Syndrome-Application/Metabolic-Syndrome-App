import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/challenge/success.dart';

import '../profile/profile.dart';

class Question extends StatelessWidget {
  const Question({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Question Page",
      home: QuestionPage(),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool _choiceOne = false;
  bool _choiceTwo = false;
  bool _choiceThree = false;

  Color unactiveColor = Color(hexColor('#FDFEFF'));
  Color activeColor = Color(hexColor('#A6CFFF'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 67,
              ),
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
                  Text('ตอบคำถามประจำวัน',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )),
                  SizedBox(
                    width: 24,
                  )
                ],
              ),
              SizedBox(
                height: 42,
              ),
              Text('ภาวะเมตาบอลิกคืออะไร ?',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'IBMPlexSansThai',
                    color: Color(hexColor('#2F4EF1')),
                    fontWeight: FontWeight.normal,
                  )),
              SizedBox(height: 11),
              Container(
                height: 158,
                width: 158,
                color: Colors.black,
              ),
              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _choiceOne = true;
                    _choiceTwo = false;
                    _choiceThree = false;
                  });
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 51,
                    decoration: BoxDecoration(
                        color: _choiceOne ? activeColor : unactiveColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Color(hexColor('#DBDBDB')))),
                    child: Text(
                      'คำตอบที่ 1',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _choiceOne = false;
                    _choiceTwo = true;
                    _choiceThree = false;
                  });
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 51,
                    decoration: BoxDecoration(
                        color: _choiceTwo ? activeColor : unactiveColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Color(hexColor('#DBDBDB')))),
                    child: Text(
                      'คำตอบที่ 2',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _choiceOne = false;
                    _choiceTwo = false;
                    _choiceThree = true;
                  });
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 51,
                    decoration: BoxDecoration(
                        color: _choiceThree ? activeColor : unactiveColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Color(hexColor('#DBDBDB')))),
                    child: Text(
                      'คำตอบที่ 3',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                height: 44,
                color: Color(hexColor('#2F4EF1')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.5),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Success()));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text("ยืนยัน",
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
        ),
      ),
    );
  }
}
