import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/challenge/question.dart';

class QuestionCard extends StatelessWidget {
  final bool checkQuiz;
  const QuestionCard({required this.checkQuiz, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(hexColor('#FFFFFF')),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 4.0,
            spreadRadius: .1,
            offset: const Offset(
              0.0,
              4.0,
            ),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 7, right: 7),
      child: Row(
        children: [
          Container(
              height: 110,
              child: Image.asset(
                  'assets/images/question_challenge_image_default.png')),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.only(top: 18, bottom: 10, left: 10, right: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ตอบคำถามประจำวัน",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          size: 14,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "150 คะแนน",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          size: 14,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "1 นาที",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          height: 32,
                          minWidth: 73,
                          onPressed: () {
                            checkQuiz
                                ? null
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Question()));
                          },
                          color: checkQuiz
                              ? Color(hexColor('#DBDBDB'))
                              : Color(hexColor('#2F4EF1')),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'เข้าร่วม',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
