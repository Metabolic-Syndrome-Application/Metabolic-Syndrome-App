import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/challenge/allChallenge.dart';
import 'package:flutter_application_1/page/challenge/challenge.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

class JoinChallenge extends StatefulWidget {
  final String id;
  const JoinChallenge({super.key, required this.id});

  @override
  State<JoinChallenge> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<JoinChallenge> {
  String name = '-';
  int points = 0;
  int participants = 0;
  String description = '';
  int numDays = 0;
  Future<void> fetchChallengeById() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getChallengeById(token!, widget.id);
      setState(() {
        name = response['data']['daily']['name'];
        points = response['data']['daily']['points'];
        participants = response['data']['daily']['participants'];
        description = response['data']['daily']['description'];
        numDays = response['data']['daily']['numDays'];
        print(response);
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  Future<void> fetchUpdateProfile(
    String challengeId,
  ) async {
    try {
      print('pop');
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      print(challengeId);
      Map<String, dynamic> response =
          await postJoinChallenge(token, challengeId);
      print(response);
      setState(() {
        print(response);
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  void initState() {
    fetchChallengeById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('FAFCFB')),
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
                                  builder: (context) => const AllChallenge()));
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 24,
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
                        child: Text('ผู้ท้าดวล $participants คน',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  )
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
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
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
                          "$points คะแนน",
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
                          "$numDays วัน",
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
                      height: 39,
                    ),
                    Text(
                      'รายละเอียด',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 23, bottom: 23),
                      decoration: BoxDecoration(
                          color: Color(hexColor('#F2F2F2')),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 44),
                    MaterialButton(
                      color: Color(hexColor('#2F4EF1')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.5),
                      ),
                      onPressed: () {
                        print(widget.id);
                        setState(() {
                          fetchUpdateProfile(widget.id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChallengePage(
                                        id: widget.id,
                                      )));
                        });
                      },
                      child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        child: Text('เข้าร่วม',
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
