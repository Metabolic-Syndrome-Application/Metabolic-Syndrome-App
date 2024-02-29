import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/data/challengeList.dart';
import 'package:flutter_application_1/page/challenge/allChallenge.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';

class ChallengePage extends StatefulWidget {
  final String id;
  const ChallengePage({super.key, required this.id});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  bool _showRank = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  dynamic myChallenge = '';
  dynamic myDailyList = '';
  int participants = 0;
  String name = '-';
  int points = 0;
  int numDays = 0;
  int day = 0;
  List<ChallengeDetail> myList = [];
  Timer? _timer;
  Duration _duration = const Duration();

  Future<void> fetchMydaily() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getMyDaily(token!);
      setState(() {
        myChallenge = response['data']['daily'];
        participants = myChallenge['participants'];
        name = myChallenge['name'];
        points = myChallenge['points'];
        numDays = myChallenge['numDays'];
        fetchDailyList();
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  Future<void> fetchDailyList() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getDailyList(token!);
      setState(() {
        myDailyList = response['data'];
        day = myDailyList['day'];
        myList.clear();
        for (var item in response['data']['list']) {
          myList.add(ChallengeDetail(
            name: item['name'],
            check: item['check'],
          ));
        }
        _timer?.cancel();
        final now = DateTime.now();
        final midnight = DateTime(now.year, now.month, now.day + 1);
        final timeLeftToday = midnight.difference(now);
        _duration = timeLeftToday;

        if (numDays - day >= 1) {
          _duration = Duration(hours: (numDays - day) * 24) + timeLeftToday;
        }

        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _duration -= const Duration(seconds: 1);
          });

          if (_duration.inSeconds <= 0) {
            timer.cancel();
          }
        });
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  Future<void> fetchUpdateChallenge(
      List<Map<String, dynamic>> listUpdate) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;

      await postUpdateChallenge(
        token!,
        listUpdate,
      );
      setState(() {});
    } catch (e) {
      // Handle errors appropriately
    }
  }

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
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Image.asset('assets/images/compliment.png',
                            height: 132)),
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
                  ],
                ),
                const Text(
                  'คุณทำได้ดีเเล้ว !',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
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
          );
        });
  }

  @override
  void initState() {
    fetchMydaily();
    // fetchDailyList();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget taskManagement(List<ChallengeDetail> planItem, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Color(hexColor('#FFFFFF')),
          borderRadius: BorderRadius.circular(20),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                activeColor: Color(hexColor('#2F4EF1')),
                shape: const CircleBorder(),
                value: planItem[index].check,
                onChanged: (value) {
                  setState(() {
                    planItem[index].check = value!;
                    List<Map<String, dynamic>> itemList =
                        planItem.map((item) => item.toMap()).toList();
                    fetchUpdateChallenge(itemList);
                    bool allChecked = planItem.every((item) => item.check);
                    if (allChecked) {
                      _showPermission();
                    }
                  });
                },
              ),
              Expanded(
                child: Text(
                  planItem[index].name,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      decoration: planItem[index].check == true
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));

    List<Widget> rank = [];
    for (int x = 1; x <= 5; x++) {
      rank.add(Container(
        margin: const EdgeInsets.only(bottom: 13),
        padding: const EdgeInsets.only(left: 20, right: 20),
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
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/person.png'),
                ),
                const SizedBox(
                  width: 7,
                ),
                const Text(
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
                const SizedBox(
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
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.only(left: 20, right: 20),
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
                child: const Text(
                  '-',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/person.png'),
              ),
              const SizedBox(
                width: 7,
              ),
              const Text(
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
              const SizedBox(
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
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 54),
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
                                  builder: (context) => const AllChallenge()));
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 24,
                          color: Color(hexColor('#484554')),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        height: 123,
                        child: Image.asset('assets/images/login.png'),
                      ),
                      const SizedBox(
                        width: 24,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: 34,
                        decoration: BoxDecoration(
                            color: Color(hexColor('#C9E1FD')),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                            'ผู้ท้าดวล ${participants == 0 ? '-' : participants} คน',
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        height: 34,
                        decoration: BoxDecoration(
                            color: Color(hexColor('#C9E1FD')),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text('$hours:$minutes:$seconds',
                            style: const TextStyle(
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
            const SizedBox(
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
                          name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     _showPermission();
                        //   },
                        //   child: Icon(
                        //     Icons.notifications,
                        //     color: Color(hexColor('#FFC556')),
                        //     size: 30,
                        //   ),
                        // )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.monetization_on_outlined,
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "$points คะแนน",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Color(hexColor('#484554')),
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "$numDays วัน",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Color(hexColor('#484554')),
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'แถบความคืบหน้า',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/trophyPercent.png'),
                            Text(
                              day == 0
                                  ? ' 0 / 100%'
                                  : " ${(day / numDays * 100).toStringAsFixed(0)} / 100%",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#484554')),
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 13,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: day == 0 ? 0 : day / numDays,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(hexColor('#FFC556'))),
                          backgroundColor: Color(hexColor('#F2F2F2')),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text(
                    //       'ดูกระดานคนเก่ง',
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         fontFamily: 'IBMPlexSansThai',
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //       textAlign: TextAlign.left,
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         setState(() {
                    //           _showRank = !_showRank;
                    //         });
                    //       },
                    //       child: Icon(
                    //         _showRank
                    //             ? Icons.keyboard_arrow_down_rounded
                    //             : Icons.keyboard_arrow_right_rounded,
                    //         size: 24,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 21,
                    // ),
                    // _showRank
                    //     ? Column(
                    //         children: rank,
                    //       )
                    //     : Container(),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Divider(
                    //         color: Color(hexColor('#DBDBDB')),
                    //         thickness: 1,
                    //         indent: 22,
                    //         endIndent: 22,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      'รายละเอียด',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'วันที่ $day',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: myList.length,
                        itemBuilder: (context, index) {
                          return taskManagement(myList, index);
                        }),
                    const SizedBox(
                      height: 37,
                    ),
                    const SizedBox(
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
