import 'package:flutter/material.dart';

import '../../extension/Color.dart';
import '../profile/profile.dart';

class Challenge extends StatelessWidget {
  const Challenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Challenge Page",
      home: ChallengePage(),
    );
  }
}

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  bool _showRank = false;
  bool isChecked1 = false;
  bool isChecked2 = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Color(hexColor('#2F4EF1'));
    }
    return Color(hexColor('#2F4EF1'));
  }

  void _showPermission() {
    showDialog(
        context: context,
        barrierDismissible: true,
        //context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: Color(hexColor('#484554')),
                          size: 16,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Image.asset('assets/images/compliment.png',
                              height: 132)),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                  Text(
                    'คุณทำได้ดีเเล้ว !',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'ก้าวเล็กๆ เเต่สม่ำเสมอ\nเพื่อสร้างทักษะที่ดีต่อสุขภาพ\nกลับมาใหม่พรุ่งนี้เพื่อก้าวไปสู่ความสำเร็จ',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        });
  }

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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10, right: 10, top: 54),
              decoration: BoxDecoration(
                  color: Color(hexColor('#A6CFFF')),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        child: Container(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 24,
                            color: Color(hexColor('#484554')),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 6, bottom: 6),
                        height: 123,
                        child: Image.asset('assets/images/login.png'),
                      ),
                      SizedBox(
                        width: 24,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 34,
                        decoration: BoxDecoration(
                            color: Color(hexColor('#C9E1FD')),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text('ผู้ท้าดวล 245 คน',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 34,
                        decoration: BoxDecoration(
                            color: Color(hexColor('#C9E1FD')),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text('00:30:32',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21, right: 21),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'สัปดาห์เเห่งการลดน้ำหนัก',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _showPermission();
                          },
                          child: Icon(
                            Icons.notifications,
                            color: Color(hexColor('#FFC556')),
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          size: 16,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "40 coins",
                          style: TextStyle(
                            fontSize: 16,
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
                          size: 16,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "1 สัปดาห์",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'แถบความคืบหน้า',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Image.asset('assets/images/trophyPercent.png'),
                              Text(
                                ' 50 / 100 % ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Color(hexColor('#484554')),
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 13,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 0.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(hexColor('#FFC556'))),
                          backgroundColor: Color(hexColor('#F2F2F2')),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 33,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ดูกระดานคนเก่ง',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _showRank = !_showRank;
                            });
                          },
                          child: Container(
                            child: Icon(
                              _showRank
                                  ? Icons.keyboard_arrow_down_rounded
                                  : Icons.keyboard_arrow_right_rounded,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    _showRank
                        ? Container(
                            child: Column(
                              children: rank,
                            ),
                          )
                        : Container(),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(hexColor('#DBDBDB')),
                            thickness: 1,
                            indent: 22,
                            endIndent: 22,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Text(
                      'รายละเอียด',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.topCenter,
                            child: Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isChecked1,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked1 = !isChecked1;
                                });
                                if (isChecked2 && isChecked1) {
                                  _showPermission();
                                }
                              },
                            )),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(hexColor('#F2F2F2')),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              'detailshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 37,
                    ),
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.topCenter,
                            child: Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: isChecked2,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked2 = !isChecked2;
                                });
                                if (isChecked2 && isChecked1) {
                                  _showPermission();
                                }
                              },
                            )),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(hexColor('#F2F2F2')),
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              'detailshhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 37,
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
