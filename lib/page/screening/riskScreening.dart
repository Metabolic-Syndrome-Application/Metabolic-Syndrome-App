import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/screening/riskResult.dart';
import 'package:flutter_application_1/page/screening/startScreening.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(RiskScreening());
}

class RiskScreening extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Progress Indicator',
      home: RiskScreeningPage(title: 'Step Progress Indicator'),
    );
  }
}

class RiskScreeningPage extends StatefulWidget {
  RiskScreeningPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _RiskScreeningPageState createState() => _RiskScreeningPageState();
}

class _RiskScreeningPageState extends State<RiskScreeningPage> {
  final _stepsText = [
    "พฤติกรรม",
    "ประวัติโรค",
    "ประวัติโรคครอบครัว",
    "ออกกำลังกาย"
  ];

  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 150.0;

  Color _activeColor = Color(hexColor('#2F4EF1'));

  Color _inactiveColor = Color(hexColor('#DBDBDB'));

  TextStyle _headerStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  late Size _safeAreaSize;

  int _curPage = 1;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  StepProgressView _getStepProgress() {
    return StepProgressView(
      _pageController,
      _stepsText,
      _curPage,
      _stepProgressViewHeight,
      _safeAreaSize.width,
      _stepCircleRadius,
      _activeColor,
      _inactiveColor,
      _headerStyle,
      _stepStyle,
      decoration: BoxDecoration(color: Color(hexColor('#FAFCFB'))),
      padding: EdgeInsets.only(top: 53.0),
    );
  }

  String? dropdownValue;

  int initial = 1;
  bool isPayment = false;
  late final CustomSegmentedController<int> controller;

  @override
  void initState() {
    super.initState();
    controller = CustomSegmentedController();
    _controllerAnother =
        TextEditingController(text: anotherData ?? anotherData);
    _controllerAnotherParent =
        TextEditingController(text: anotherParentData ?? anotherParentData);
  }

  Color unactiveColor = Color(hexColor('#FDFEFF'));
  Color activeColor = Color(hexColor('#A6CFFF'));

  //--Behavior step
  bool sleep = false;
  bool alcohol = false;
  bool smoke = false;
  bool healthCheck = false;

  //--History step
  bool noDeseaseHistory = false;
  bool cancer = false;
  bool diabetes = false;
  bool highPressure = false;
  bool heartAttack = false;
  bool kidney = false;
  bool another = false;
  String? anotherData;

  //--Parent History step
  bool noDeseaseHistoryParent = false;
  bool cancerParent = false;
  bool diabetesParent = false;
  bool highPressureParent = false;
  bool heartAttackParent = false;
  bool kidneyParent = false;
  bool anotherParent = false;
  String? anotherParentData;

  //--Exercise step
  String? exerciseFrequency;
  String? exercisePeriod;

  bool isHover = false;

  final ScrollController _scrollController = ScrollController();

  late TextEditingController _controllerAnother;
  late TextEditingController _controllerAnotherParent;

  List<String> _disease = [];
  List<String> _family = [];

  // var _diseaseResult;
  String diabetesResult = "";
  String hyperlipidemiaResult = "";
  String hypertensionResult = "";
  String obesityResult = "";

  Future<void> fetchDisease(List<String> disease, List<String> family) async {
    String? token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      Map<String, dynamic> response =
          await postDisease(token!, disease, family);
      setState(() {
        diabetesResult = response['data']['diseaseRisk']['diabetes'];
        hyperlipidemiaResult =
            response['data']['diseaseRisk']['hyperlipidemia'];
        hypertensionResult = response['data']['diseaseRisk']['hypertension'];
        obesityResult = response['data']['diseaseRisk']['obesity'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQD = MediaQuery.of(context);
    _safeAreaSize = mediaQD.size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            _getStepProgress(),
            Expanded(
              flex: 7,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (i) {
                      setState(() {
                        _curPage = i + 1;
                      });
                    },
                    children: <Widget>[
                      Scaffold(
                        backgroundColor: Color(hexColor('#FAFCFB')),
                        body: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 44),
                              RichText(
                                text: const TextSpan(
                                  text: 'ท่านมีพฤติกรรมดังต่อไปนี้หรือไม่',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: const TextSpan(
                                  text:
                                      'ตอบได้มากกว่า 1 ข้อ หากไม่มีพฤติกรรมเหล่านี้ กดถัดไป',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.3),
                                          blurRadius: 4.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(
                                            2.0,
                                            4.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: MaterialButton(
                                        color:
                                            sleep ? activeColor : unactiveColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            sleep = !sleep;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 21,
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image.asset(
                                                  'assets/images/sleep.png'),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              'นอนกรนและเหนื่อย\nเพลียหลังตื่นนอน',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    width: 31,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.3),
                                          blurRadius: 4.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(
                                            2.0,
                                            4.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: MaterialButton(
                                        color: alcohol
                                            ? activeColor
                                            : unactiveColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            alcohol = !alcohol;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image.asset(
                                                  'assets/images/alcohol.png'),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              'ดื่มแอลกอฮอล์เกิน\nกว่าวันละ 2 แก้วเป็น\nประจำ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 31,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.3),
                                          blurRadius: 4.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(
                                            2.0,
                                            4.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: MaterialButton(
                                        color:
                                            smoke ? activeColor : unactiveColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            smoke = !smoke;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 21,
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image.asset(
                                                  'assets/images/smoking.png'),
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              'สูบบุหรี่',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 31,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.3),
                                          blurRadius: 4.0,
                                          spreadRadius: 1.0,
                                          offset: const Offset(
                                            2.0,
                                            4.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: MaterialButton(
                                        color: healthCheck
                                            ? activeColor
                                            : unactiveColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            healthCheck = !healthCheck;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 21,
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: Image.asset(
                                                  'assets/images/medicalReport.png'),
                                            ),
                                            SizedBox(
                                              height: 18,
                                            ),
                                            Text(
                                              'ไม่เคยตรวจสุขภาพ',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Scaffold(
                        backgroundColor: Color(hexColor('#FAFCFB')),
                        body: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              const SizedBox(height: 44),
                              RichText(
                                text: const TextSpan(
                                  text:
                                      'ท่านมีประวัติเป็นโรค ดังต่อไปนี้หรือไม่',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: const TextSpan(
                                  text:
                                      'ตอบได้มากกว่า 1 ข้อ หากไม่มีพฤติกรรมเหล่านี้ กดถัดไป',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: noDeseaseHistory &&
                                          (!cancer &&
                                              !diabetes &&
                                              !highPressure &&
                                              !heartAttack &&
                                              !kidney &&
                                              !another)
                                      ? activeColor
                                      : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      noDeseaseHistory = !noDeseaseHistory;
                                      if (noDeseaseHistory == true) {
                                        cancer = false;
                                        diabetes = false;
                                        highPressure = false;
                                        heartAttack = false;
                                        kidney = false;
                                        another = false;
                                      }
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin:
                                              const EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/noHistoryIcon.png')),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text("ไม่มีโรคประจำตัว",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: cancer ? activeColor : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      cancer = !cancer;
                                      noDeseaseHistory = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin:
                                              const EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/cancerIcon.png')),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text("โรคมะเร็ง",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: diabetes ? activeColor : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      diabetes = !diabetes;
                                      noDeseaseHistory = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin:
                                              const EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/diabetesIcon.png')),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text("โรคเบาหวาน",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: highPressure
                                      ? activeColor
                                      : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      highPressure = !highPressure;
                                      noDeseaseHistory = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin: EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/hypertensionIcon.png')),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("โรคความดันเลือดสูง",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color:
                                      heartAttack ? activeColor : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      heartAttack = !heartAttack;
                                      noDeseaseHistory = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin: EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/heartAttackIcon.png')),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("โรคหัวใจ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: kidney ? activeColor : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      kidney = !kidney;
                                      noDeseaseHistory = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin: EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/kidneyIcon.png')),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("โรคไต",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: another ? activeColor : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      another = !another;
                                      noDeseaseHistory = false;
                                    });
                                    if (another == true) {
                                      _scrollController.animateTo(
                                        _scrollController
                                                .position.maxScrollExtent +
                                            100,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin: EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/addIcon.png')),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("อื่นๆ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              another
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          left: 22, right: 22, bottom: 90),
                                      height: 56,
                                      child: TextFormField(
                                        controller: _controllerAnother,
                                        onChanged: (value) {
                                          setState(() {
                                            anotherData = value;
                                          });
                                        },
                                        textDirection: TextDirection.ltr,
                                        decoration: InputDecoration(
                                          hintText: 'กรอกข้อมูลอื่นๆ',
                                          hintStyle: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor("#999999")),
                                            fontWeight: FontWeight.normal,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 35),
                                          fillColor: Color(hexColor('#C9E1FD')),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24)),
                                              borderSide: BorderSide(
                                                color:
                                                    Color(hexColor('#C9E1FD')),
                                                width: 1,
                                              )),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(height: 80),
                              const SizedBox(height: 20)
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        controller: _scrollController,
                        child: Container(
                          alignment: Alignment.center,
                          color: Color(hexColor('#FAFCFB')),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              RichText(
                                text: const TextSpan(
                                  text:
                                      'ครอบครัวมีประวัติเป็นโรค\nดังต่อไปนี้หรือไม่',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: const TextSpan(
                                  text:
                                      'ตอบได้มากกว่า 1 ข้อ หากไม่มีพฤติกรรมเหล่านี้ กดถัดไป',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: noDeseaseHistoryParent &&
                                          (!cancerParent &&
                                              !diabetesParent &&
                                              !highPressureParent &&
                                              !heartAttackParent &&
                                              !kidneyParent &&
                                              !anotherParent)
                                      ? activeColor
                                      : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      noDeseaseHistoryParent =
                                          !noDeseaseHistoryParent;
                                      if (noDeseaseHistoryParent == true) {
                                        cancerParent = false;
                                        diabetesParent = false;
                                        highPressureParent = false;
                                        heartAttackParent = false;
                                        kidneyParent = false;
                                        anotherParent = false;
                                      }
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin:
                                              const EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/noHistoryIcon.png')),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text("ไม่มีโรคประจำตัว",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: cancerParent
                                      ? activeColor
                                      : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      cancerParent = !cancerParent;
                                      noDeseaseHistoryParent = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin:
                                              const EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/cancerIcon.png')),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text("โรคมะเร็ง",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: diabetesParent
                                      ? activeColor
                                      : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      diabetesParent = !diabetesParent;
                                      noDeseaseHistoryParent = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin: EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/diabetesIcon.png')),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("โรคเบาหวาน",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: highPressureParent
                                      ? activeColor
                                      : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      highPressureParent = !highPressureParent;
                                      noDeseaseHistoryParent = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin: EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/hypertensionIcon.png')),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("โรคความดันเลือดสูง",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: heartAttackParent
                                      ? activeColor
                                      : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      heartAttackParent = !heartAttackParent;
                                      noDeseaseHistoryParent = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin: EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/heartAttackIcon.png')),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("โรคหัวใจ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: kidneyParent
                                      ? activeColor
                                      : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      kidneyParent = !kidneyParent;
                                      noDeseaseHistoryParent = false;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin: EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/kidneyIcon.png')),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("โรคไต",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 22, right: 22, bottom: 20),
                                height: 56,
                                child: MaterialButton(
                                  color: anotherParent
                                      ? activeColor
                                      : unactiveColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: BorderSide(
                                        color: Color(hexColor('#DBDBDB')),
                                        width: 1,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      anotherParent = !anotherParent;
                                      noDeseaseHistoryParent = false;
                                    });
                                    if (anotherParent == true) {
                                      _scrollController.animateTo(
                                        _scrollController
                                                .position.maxScrollExtent +
                                            100,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 36,
                                          margin: EdgeInsets.only(left: 16),
                                          child: Image.asset(
                                              'assets/images/addIcon.png')),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("อื่นๆ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                              anotherParent
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          left: 22, right: 22, bottom: 90),
                                      height: 56,
                                      child: TextFormField(
                                        controller: _controllerAnotherParent,
                                        onChanged: (value) {
                                          setState(() {
                                            anotherParentData = value;
                                          });
                                        },
                                        textDirection: TextDirection.ltr,
                                        decoration: InputDecoration(
                                          hintText: 'กรอกข้อมูลอื่นๆ',
                                          hintStyle: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor("#999999")),
                                            fontWeight: FontWeight.normal,
                                          ),
                                          contentPadding:
                                              EdgeInsets.only(left: 35),
                                          fillColor: Color(hexColor('#C9E1FD')),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24)),
                                              borderSide: BorderSide(
                                                color:
                                                    Color(hexColor('#C9E1FD')),
                                                width: 1,
                                              )),
                                        ),
                                      ),
                                    )
                                  : SizedBox(height: 80),
                              SizedBox(height: 20)
                            ],
                          ),
                        ),
                      ),
                      Scaffold(
                        backgroundColor: Color(hexColor('#FAFCFB')),
                        body: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: 44),
                                RichText(
                                  text: TextSpan(
                                    text: 'คุณออกกำลังกายกี่ครั้งต่อสัปดาห์',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 27,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 26, right: 26, bottom: 26),
                                  height: 50,
                                  child: MaterialButton(
                                    color: exerciseFrequency == "น้อยกว่า 3 วัน"
                                        ? activeColor
                                        : unactiveColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        side: BorderSide(
                                          color: Color(hexColor('#DBDBDB')),
                                          width: 1,
                                        )),
                                    onPressed: () {
                                      setState(() {
                                        exerciseFrequency = "น้อยกว่า 3 วัน";
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("น้อยกว่า 3 วัน",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 26, right: 26, bottom: 26),
                                  height: 50,
                                  child: MaterialButton(
                                    color: exerciseFrequency == "3 - 5 วัน"
                                        ? activeColor
                                        : unactiveColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        side: BorderSide(
                                          color: Color(hexColor('#DBDBDB')),
                                          width: 1,
                                        )),
                                    onPressed: () {
                                      setState(() {
                                        exerciseFrequency = "3 - 5 วัน";
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("3 - 5 วัน",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 26, right: 26, bottom: 26),
                                  height: 50,
                                  child: MaterialButton(
                                    color: exerciseFrequency == "6 - 7 วัน"
                                        ? activeColor
                                        : unactiveColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        side: BorderSide(
                                          color: Color(hexColor('#DBDBDB')),
                                          width: 1,
                                        )),
                                    onPressed: () {
                                      setState(() {
                                        exerciseFrequency = "6 - 7 วัน";
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("6 - 7 วัน",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 26, right: 26, bottom: 26),
                                  height: 50,
                                  child: MaterialButton(
                                    color: exerciseFrequency == "ไม่ออกกำลังกาย"
                                        ? activeColor
                                        : unactiveColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        side: BorderSide(
                                          color: Color(hexColor('#DBDBDB')),
                                          width: 1,
                                        )),
                                    onPressed: () {
                                      setState(() {
                                        exerciseFrequency = "ไม่ออกกำลังกาย";
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("ไม่ออกกำลังกาย",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 41,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'คุณออกกำลังกายครั้งละกี่นาที',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 27,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 26, right: 26, bottom: 26),
                                  height: 50,
                                  child: MaterialButton(
                                    color: exercisePeriod == "น้อยกว่า 15 นาที"
                                        ? activeColor
                                        : unactiveColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        side: BorderSide(
                                          color: Color(hexColor('#DBDBDB')),
                                          width: 1,
                                        )),
                                    onPressed: () {
                                      setState(() {
                                        exercisePeriod = "น้อยกว่า 15 นาที";
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("น้อยกว่า 15 นาที",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 26, right: 26, bottom: 26),
                                  height: 50,
                                  child: MaterialButton(
                                    color: exercisePeriod == "15 - 30 นาที"
                                        ? activeColor
                                        : unactiveColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        side: BorderSide(
                                          color: Color(hexColor('#DBDBDB')),
                                          width: 1,
                                        )),
                                    onPressed: () {
                                      setState(() {
                                        exercisePeriod = "15 - 30 นาที";
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("15 - 30 นาที",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.purple,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.purple
                            ],
                            stops: [
                              0.0,
                              0.2,
                              1.0,
                              1.0
                            ], // 10% purple, 80% transparent, 10% purple
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: Container(
                          height: 120,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 22, right: 22, bottom: 50),
                        child: SizedBox(
                          height: 44,
                          child: MaterialButton(
                            color: Color(hexColor('#2F4EF1')),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23.5),
                            ),
                            onPressed: () async {
                              if (_pageController.hasClients && _curPage < 4) {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              } else {
                                if (noDeseaseHistory) {
                                  _disease = [];
                                } else {
                                  if (cancer) {
                                    _disease.add("cancer");
                                  }
                                  if (diabetes) {
                                    _disease.add("diabetes");
                                  }
                                  if (highPressure) {
                                    _disease.add("hypertension");
                                  }
                                  if (heartAttack) {
                                    _disease.add("heartDisease");
                                  }
                                  if (kidney) {
                                    _disease.add("kidneyDisease");
                                  }
                                }

                                if (noDeseaseHistoryParent) {
                                  _family = [];
                                } else {
                                  if (cancerParent) {
                                    _family.add("cancer");
                                  }
                                  if (diabetesParent) {
                                    _family.add("diabetes");
                                  }
                                  if (highPressureParent) {
                                    _family.add("hypertension");
                                  }
                                  if (heartAttackParent) {
                                    _family.add("heartDisease");
                                  }
                                  if (kidneyParent) {
                                    _family.add("kidneyDisease");
                                  }
                                }
                                await fetchDisease(_disease, _family);
                                _disease = [];
                                _family = [];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RiskResultPage()));
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text("ถัดไป",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class StepProgressView extends StatelessWidget {
  const StepProgressView(
    PageController pageController,
    List<String> stepsText,
    int curStep,
    double height,
    double width,
    double dotRadius,
    Color activeColor,
    Color inactiveColor,
    TextStyle headerStyle,
    TextStyle stepsStyle, {
    Key? key,
    required this.decoration,
    required this.padding,
    this.lineHeight = 5.0,
  })  : _stepsText = stepsText,
        _pageController = pageController,
        _curStep = curStep,
        _height = height,
        _width = width,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        assert(curStep > 0 == true && curStep <= stepsText.length),
        assert(width > 0),
        assert(height >= 2 * dotRadius),
        assert(width >= dotRadius * 2 * stepsText.length),
        super(key: key);

  //height of the container
  final double _height;
  //width of the container
  final double _width;
  //container decoration
  final BoxDecoration decoration;
  //list of texts to be shown for each step
  final List<String> _stepsText;
  //cur step identifier
  final int _curStep;
  //active color
  final Color _activeColor;
  //in-active color
  final Color _inactiveColor;

  //dot radius
  final PageController _pageController;
  //container padding
  final EdgeInsets padding;
  //line height
  final double lineHeight;

  List<Widget> _buildProgressStep() {
    var wids = <Widget>[];
    _stepsText.asMap().forEach((i, text) {
      var lineColor = _curStep > i ? _activeColor : _inactiveColor;

      //add a line separator
      //0-------0--------0
      if (i != _stepsText.length) {
        wids.add(
          Expanded(
            child: Container(
              height: lineHeight,
              color: lineColor,
            ),
          ),
        );
      }
    });

    return wids;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              IconButton(
                  iconSize: 24,
                  icon: const Icon(Icons.keyboard_arrow_left),
                  onPressed: () {
                    if (_curStep > 1) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartScreening()));
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "ขั้นตอนที่ ${_curStep + 3} จาก ${_stepsText.length + 3}",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#2F4EF1')),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: _buildProgressStep(),
          ),
        ],
      ),
    );
  }
}
