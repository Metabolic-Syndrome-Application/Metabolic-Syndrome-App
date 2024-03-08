import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  int myRank = 0;
  int collectPoints = 0;
  String name = '';
  String photo = '';
  String firstname = '';

  Future<void> fetchProfile() async {
    String? token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      Map<String, dynamic> response = await getProfile(token!);
      setState(() {
        firstname = response['data']['user']['firstName'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  Future<void> fetchMyRank() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getMyRank(token!);
      setState(() {
        myRank = response['data']['rank'];
        collectPoints = response['data']['collectPoints'];
        name = response['data']['name'];
        photo = response['data']['photo'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  dynamic listOfRank = '';
  Future<void> fetchAllRank() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getTopFive(token!);
      setState(() {
        listOfRank = response['data'];
        print(listOfRank);
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  void initState() {
    fetchProfile();
    fetchMyRank();
    fetchAllRank();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rank = [];
    for (int x = 0; x <= 4; x++) {
      if (x <= listOfRank.length - 1) {
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
                    '0${x + 1}',
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
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    backgroundImage: AssetImage(listOfRank[x]['photo'] == ''
                        ? "assets/images/photoNull.png"
                        : listOfRank[x]['photo']),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text(
                    listOfRank[x]['name']
                    // == ''
                    //     ? firstname
                    //     : listOfRank[x]['name']
                    ,
                    style: const TextStyle(
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
                    listOfRank[x]['collectPoints'].toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansThai',
                      color: Color(hexColor('#42884B')),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
      } else {
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
                    '0${x + 1}',
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
                    backgroundImage: AssetImage(''),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Text(
                    '-',
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
                    '0',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansThai',
                      color: Color(hexColor('#42884B')),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
      }
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
                child: Text(
                  myRank.toString().length == 1
                      ? '0$myRank'
                      : myRank.toString(),
                  style: const TextStyle(
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
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(photo),
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                name == '' ? firstname : name,
                style: const TextStyle(
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
                collectPoints.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBMPlexSansThai',
                  color: Color(hexColor('#42884B')),
                  fontWeight: FontWeight.bold,
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
          padding: const EdgeInsets.only(top: 58, left: 20, right: 20),
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
                              child: const HomePage()));
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(hexColor('#484554')),
                      size: 24,
                    ),
                  ),
                  const Text(
                    'กระดานคนเก่ง',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  )
                ],
              ),
              const SizedBox(height: 34),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromARGB(255, 255, 205, 131),
                                  Color.fromARGB(117, 255, 205, 131),
                                ]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset('assets/images/trophy.png'),
                              ],
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'เก่งที่สุด !',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                          ],
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              Row(
                children: [
                  Image.asset('assets/images/leaderboard.png'),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'อันดับ',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Column(
                  children: rank,
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              Row(
                children: [
                  Image.asset('assets/images/coins.png'),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
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
              const SizedBox(
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
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    collectPoints.toString() + " คะแนน",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IBMPlexSansThai',
                      color: Color(hexColor('#42884B')),
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 21,
              ),
              // Container(
              //   height: 42,
              //   padding: EdgeInsets.only(left: 10, right: 10),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(30),
              //       color: Colors.white),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'คุณมีคะเเนนสะสมทั้งหมด',
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontFamily: 'IBMPlexSansThai',
              //           color: Colors.black,
              //           fontWeight: FontWeight.normal,
              //         ),
              //       ),
              //       Text(
              //         '+ 100',
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontFamily: 'IBMPlexSansThai',
              //           color: Color(hexColor('#42884B')),
              //           fontWeight: FontWeight.normal,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 220,
              )
            ],
          ),
        ),
      ),
    );
  }
}
