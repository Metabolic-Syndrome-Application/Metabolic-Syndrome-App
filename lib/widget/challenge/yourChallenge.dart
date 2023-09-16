import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/challenge/challenge.dart';

void main() {
  runApp(YourChallengeCard());
}

class YourChallengeCard extends StatelessWidget {
  const YourChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Challenge()));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color(hexColor('#A6CFFF')),
            borderRadius: BorderRadius.circular(30)),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 7, right: 7),
        child: Row(
          children: [
            Container(
                height: 110, child: Image.asset('assets/images/login.png')),
            SizedBox(
              width: 7,
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 18, bottom: 18, left: 10, right: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ลงทะเบียน",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          size: 14,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "100 coins",
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
                          "30 - 45 นาที",
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
                      height: 13,
                    ),
                    Container(
                      width: 100,
                      height: 6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 0.7,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(hexColor('#FFC556'))),
                          backgroundColor: Color(hexColor('#D9D9D9')),
                        ),
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
