import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:page_transition/page_transition.dart';

import '../../extension/Color.dart';

class Ranking extends StatelessWidget {
  const Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ranking Page',
      home: RankingPage(),
    );
  }
}

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> rank = [];
    for (int x = 1; x <= 5; x++) {
      rank.add(Container(
        margin: EdgeInsets.only(bottom: 13),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '0$x',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/person.png'),
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  'นันท์',
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
                Image.asset('assets/images/coin.png', height: 24),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '3400',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Color(hexColor('#42884B')),
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            )
          ],
        ),
      ));
    }
    rank.add(Container(
      margin: EdgeInsets.only(bottom: 13),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(hexColor('#FFE9C9'))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 29,
                child: Text(
                  '-',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/person.png'),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                'นันท์',
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
              Image.asset('assets/images/coin.png', height: 24),
              SizedBox(
                width: 5,
              ),
              Text(
                '3400',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBMPlexSansThai',
                  color: Color(hexColor('#42884B')),
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          )
        ],
      ),
    ));

    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 58, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.leftToRight,
                              child: Home()));
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(hexColor('#484554')),
                      size: 24,
                    ),
                  ),
                  Text(
                    'กระดานคนเก่ง',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  )
                ],
              ),
              SizedBox(height: 34),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 138,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(255, 255, 205, 131),
                            Color.fromARGB(117, 255, 205, 131),
                          ]),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'เก่งที่สุด !',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'วันนี้ก็มาพยายามต่อด้วยกันนะ',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Image.asset('assets/images/trophy.png')
                    ],
                  )),
              SizedBox(
                height: 36,
              ),
              Row(
                children: [
                  Image.asset('assets/images/leaderboard.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'อันดับ',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                child: Column(
                  children: rank,
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  Image.asset('assets/images/coins.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'คะเเนนของฉัน',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        //points
                      },
                      child: Image.asset('assets/images/piggyBank.png')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '100 คะแนน',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IBMPlexSansThai',
                      color: Color(hexColor('#42884B')),
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 21,
              ),
              Container(
                height: 42,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'คุณมีคะเเนนสะสมทั้งหมด',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      '+ 100',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Color(hexColor('#42884B')),
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 220,
              )
            ],
          ),
        ),
      ),
    );
  }
}
