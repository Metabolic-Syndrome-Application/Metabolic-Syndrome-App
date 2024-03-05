import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:flutter_application_1/widget/challenge/challenge.dart';
import 'package:flutter_application_1/widget/challenge/question.dart';
import 'package:flutter_application_1/widget/challenge/yourChallenge.dart';
import 'package:provider/provider.dart';

@RoutePage()

class AllChallenge extends StatelessWidget {
  const AllChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllChallenge',
      home: AllChallengePage(),
    );
  }
}

class AllChallengePage extends StatefulWidget {
  const AllChallengePage({super.key});

  @override
  State<AllChallengePage> createState() => _AllChallengePageState();
}

class _AllChallengePageState extends State<AllChallengePage> {
  bool checkQuiz = true;
  Map<String, dynamic> quiz = {};
  dynamic listOfChallenge = [];
  dynamic myChallenge = [];
  dynamic myDailyList = [];
  String id = '';
  String name = '-';
  int points = 0;
  int numDays = 0;
  int day = 0;

  Future<void> fetchMydaily() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getMyDaily(token!);
      setState(() {
        myChallenge = response['data']['daily'];
        id = myChallenge['id'];
        name = myChallenge['name'];
        points = myChallenge['points'];
        numDays = myChallenge['numDays'];
        if (id != '') {
          fetchDailyList();
        }
        print(myChallenge);
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
        print(myDailyList);
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  Future<void> fetchCheckQuiz() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getCheckQuiz(token!);
      setState(() {
        checkQuiz = response['check'];
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  Future<void> fetchAllChallenge() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getDailyChallengeAll(token!);
      setState(() {
        listOfChallenge = response['data']['daily'];
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  Future<void> fetchRandomQuiz() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getRandomQuiz(token!);
      setState(() {
        quiz = response['data']['quiz'];
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  @override
  void initState() {
    fetchMydaily();
    // fetchDailyList();
    fetchCheckQuiz();
    fetchAllChallenge();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(hexColor('#FAFCFB')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 58),
            child: Column(
              children: [
                Text(
                  "ท้าดวล",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(children: [
                  Image.asset('assets/images/your_challenge_icon.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text("ภารกิจของคุณ",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ))
                ]),
                SizedBox(
                  height: 22,
                ),
                id == ''
                    ? Material(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(hexColor('#D9D9D9')),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 7, right: 7),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 110,
                                          child: Image.asset(
                                              'assets/images/your_challenge_image_default.png')),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Container(
                                        child: Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 18,
                                                bottom: 18,
                                                left: 10,
                                                right: 10),
                                            child: Text(
                                                'คุณยังไม่ได้เข้าร่วมภารกิจ',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ]))))
                    : YourChallengeCard(
                        id: id,
                        name: name,
                        points: points,
                        numDays: numDays,
                        day: day,
                      ),
                SizedBox(
                  height: 46,
                ),
                Row(children: [
                  Image.asset('assets/images/question_challenge_icon.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text("คำถามประจำวัน",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ))
                ]),
                SizedBox(
                  height: 22,
                ),
                QuestionCard(
                  checkQuiz: checkQuiz,
                ),
                SizedBox(
                  height: 46,
                ),
                Row(children: [
                  Image.asset('assets/images/hit_challenge_icon.png'),
                  SizedBox(
                    width: 5,
                  ),
                  Text("ภารกิจมาเเรง",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ))
                ]),
                listOfChallenge == null
                    ? Material(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(hexColor('#D9D9D9')),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.only(left: 7, right: 7),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 110,
                                          child: Image.asset(
                                              'assets/images/your_challenge_image_default.png')),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      const Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 18,
                                              bottom: 18,
                                              left: 10,
                                              right: 10),
                                          child: Text(
                                              'ยังไม่มีภารกิจให้เข้าร่วมในเวลานี้',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              )),
                                        ),
                                      ),
                                    ]))))
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listOfChallenge.length,
                        itemBuilder: (context, index) {
                          if (listOfChallenge[index] == null ||
                              listOfChallenge[index] is! Map) {
                            return const SizedBox.shrink();
                          }

                          final item = listOfChallenge[index] as Map;
                          final id = item['id'];
                          final name = item['name'];
                          final points = item['points'];
                          final numDays = item['numDays'];

                          if (id == null ||
                              name == null ||
                              points == null ||
                              numDays == null) {
                            return const SizedBox.shrink();
                          }

                          return ChallengeCard(
                            id: id,
                            name: name,
                            points: points,
                            numDays: numDays,
                            enable: myChallenge == null ? true : false,
                          );
                        },
                      )
              ],
            ),
          ),
        ));
  }
}
