import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/challenge/challenge.dart';

// void main() {
//   runApp(YourChallengeCard());
// }

class YourChallengeCard extends StatelessWidget {
  final String id;
  final String name;
  final int points;
  final int numDays;
  final int day;
  const YourChallengeCard(
      {super.key,
      required this.name,
      required this.points,
      required this.numDays,
      required this.day,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      color: Color(hexColor('#A6CFFF')),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChallengePage(id: id)));
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 7, right: 7),
          child: Row(
            children: [
              Container(
                  height: 110,
                  child: Image.asset(
                      'assets/images/your_challenge_image_default.png')),
              SizedBox(
                width: 7,
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 18, bottom: 18, left: 10, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
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
                            "${points == 0 ? '-' : points} คะแนน",
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
                            "${numDays == 0 ? '-' : numDays} วัน",
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
                            value: day == 0 || numDays == 0 ? 0 : day / numDays,
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
      ),
    );
  }
}
