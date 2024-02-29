import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/challenge/allChallenge.dart';
import 'package:flutter_application_1/page/challenge/success.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(Question());
// }

class Question extends StatelessWidget {
  const Question({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Question Page",
      home: QuestionPage(),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool? _checkCorrect;
  String isCorrect = '';
  int _selectedIndex = -1;

  Color unactiveColor = Color(hexColor('#FDFEFF'));
  Color activeColor = Color(hexColor('#A6CFFF'));

  Map<String, dynamic> quiz = {};
  String question = '';

  @override
  void initState() {
    fetchRandomQuiz();
    super.initState();
  }

  Future<void> fetchRandomQuiz() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getRandomQuiz(token!);
      setState(() {
        quiz = response['data']['quiz'];
        question = quiz['question'];
        print(quiz);
      });
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  Future<void> fetchAnswer() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response =
          await postAnswerQuiz(token!, _checkCorrect!);
      setState(() {
        isCorrect = response["result"];
      });
    } catch (e) {
      print('Error fetching plan: $e');
    }
  }

  void _warningTime(String warningText) {
    showDialog(
        context: context,
        barrierDismissible: false,
        //context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.only(top: 0),
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/icon_warning_record.png',
                      height: 100,
                    ),
                    Text(
                      warningText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      height: 44,
                      color: Color(hexColor('#2F4EF1')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.5),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllChallenge()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text("กลับสู่หน้าท้าดวล",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _warningExit(String warningText) {
    showDialog(
        context: context,
        barrierDismissible: false,
        //context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.only(top: 0),
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/icon_warning_record.png',
                      height: 100,
                    ),
                    Text(
                      warningText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          height: 44,
                          color: Color(hexColor('#2F4EF1')),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.5),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllChallenge()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text("กลับสู่หน้าท้าดวล",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        MaterialButton(
                          height: 44,
                          color: Color(hexColor('#2F4EF1')),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.5),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text("ทำต่อ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _warningAnswer(String warningText) {
    showDialog(
        context: context,
        barrierDismissible: false,
        //context: _scaffoldKey.currentContext,
        builder: (context) {
          return AlertDialog(
            titlePadding: const EdgeInsets.only(top: 0),
            contentPadding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/icon_warning_record.png',
                      height: 100,
                    ),
                    Text(
                      warningText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      height: 44,
                      color: Color(hexColor('#2F4EF1')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.5),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text("ปิด",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget choiceCard(Map<String, dynamic> choiceList, int index) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            setState(() {
              _selectedIndex = index; // Update the selected index on tap
              _checkCorrect = choiceList['isCorrect'];
            });
          },
          child: Container(
              alignment: Alignment.center,
              height: 51,
              decoration: BoxDecoration(
                  color: _selectedIndex == index ? activeColor : unactiveColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color(hexColor('#DBDBDB')))),
              child: Text(
                choiceList['option'],
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              )),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 67,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _warningExit(
                          "หากออกจากการหน้าคำถาม\nคุณจะไม่สามารถกลับเข้ามาตอบคำถามได้อีกในวันนี้\nคุณแน่ใจหรือไม่");
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                    ),
                  ),
                  const Text('ตอบคำถามประจำวัน',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      )),
                  const SizedBox(
                    width: 24,
                  )
                ],
              ),
              const SizedBox(
                height: 42,
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 30),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 79,
                          backgroundColor: Color(hexColor('#FFC556')),
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Color(hexColor('#FEDC86')),
                        ),
                        TweenAnimationBuilder<Duration>(
                            duration: const Duration(minutes: 1),
                            tween: Tween(
                                begin: const Duration(minutes: 1),
                                end: Duration.zero),
                            onEnd: () {
                              _warningTime("หมดเวลา");
                              print('Timer ended');
                            },
                            builder: (BuildContext context, Duration value,
                                Widget? child) {
                              final minutes = value.inMinutes;
                              final seconds = value.inSeconds % 60;
                              bool checkDigit = false;
                              if (seconds.toString().length == 1) {
                                checkDigit = true;
                              } else {
                                checkDigit = false;
                              }

                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                      checkDigit
                                          ? '0$seconds'
                                          : '$seconds',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(hexColor('#FB6262')),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30)));
                            }),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(right: 70),
                      child: Image.asset('assets/images/quiz_people.png')),
                ],
              ),
              SizedBox(height: 25),
              Container(
                alignment: Alignment.center,
                child: Text(
                  question + " ?",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'IBMPlexSansThai',
                    color: Color(hexColor('#2F4EF1')),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: quiz['choices'].length,
                itemBuilder: (context, index) {
                  return choiceCard(quiz['choices'][index], index);
                },
              ),
              MaterialButton(
                height: 44,
                color: Color(hexColor('#2F4EF1')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.5),
                ),
                onPressed: () async {
                  if (_checkCorrect != null) {
                    await fetchAnswer();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SuccessPage(
                                  result: isCorrect,
                                )));
                  } else {
                    _warningAnswer("กรุณาเลือกคำตอบก่อนกดยืนยัน");
                    print(_checkCorrect);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text("ยืนยัน",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
