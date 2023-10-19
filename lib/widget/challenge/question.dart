import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/challenge/joinQuestion.dart';

void main() {
  runApp(QuestionCard());
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(hexColor('#FFFFFF')),
          borderRadius: BorderRadius.circular(30)),
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
                    Text("นอนวันละ 8 ชั่วโมง",
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
                          "40 coins",
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
                          "1 สัปดาห์",
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          height: 32,
                          minWidth: 73,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JoinQuestion()));
                          },
                          color: Color(hexColor('#2F4EF1')),
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
