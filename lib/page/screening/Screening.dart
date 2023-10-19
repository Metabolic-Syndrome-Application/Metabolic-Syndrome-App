import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/screening/metabolicResult.dart';
import 'package:flutter_application_1/page/screening/startScreening.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(Screening());
}

class Screening extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Progress Indicator',
      home: ScreeningPage(title: 'Step Progress Indicator'),
    );
  }
}

class ScreeningPage extends StatefulWidget {
  ScreeningPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ScreeningPageState createState() => _ScreeningPageState();
}

class _ScreeningPageState extends State<ScreeningPage> {
  final _stepsText = [
    "เพศของคุณ",
    "อาชีพของคุณ",
    "ข้อมูลสุขภาพของคุณ",
    "ข้อมูลสุขภาพเพิ่มเติม"
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
  bool _isObscure = false;

  int initial = 1;
  bool isPayment = false;
  late final CustomSegmentedController<int> controller;

  @override
  void initState() {
    super.initState();
    controller = CustomSegmentedController();
    controller.addListener(() {
      print('listener ${controller.value}');
    });
  }

  int _currentValue = 2543;

//Build method of Main Page
  Widget build(BuildContext context) {
    var mediaQD = MediaQuery.of(context);
    _safeAreaSize = mediaQD.size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(child: _getStepProgress()),
            Expanded(
              flex: 5,
              child: PageView(
                physics: new NeverScrollableScrollPhysics(),
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
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 44),
                            RichText(
                              text: TextSpan(
                                text: 'เพศของคุณ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 33,
                            ),
                            CustomSlidingSegmentedControl<int>(
                              initialValue: initial,
                              height: 124,
                              innerPadding: EdgeInsets.all(12),
                              controller: controller,
                              children: {
                                1: Container(
                                  width: 100,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //SizedBox(height: 20,),
                                        Icon(Icons.male, size: 60.0),
                                        Text(
                                          'ชาย',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#2F4EF1')),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ]),
                                ),
                                2: Container(
                                  width: 100,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.female, size: 60.0),
                                        Text(
                                          'หญิง',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#2F4EF1')),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ]),
                                ),
                              },
                              decoration: BoxDecoration(
                                color: Color(hexColor('#C9E1FD')),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              thumbDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(62),
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
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInToLinear,
                              onValueChanged: (v) {},
                            ),
                            SizedBox(
                              height: 46,
                            ),
                            Text(
                              'ปีเกิด',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            NumberPicker(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              selectedTextStyle: TextStyle(
                                fontSize: 20,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#2F4EF1')),
                                fontWeight: FontWeight.normal,
                              ),
                              value: _currentValue,
                              minValue: 2466,
                              maxValue: 2550,
                              onChanged: (value) =>
                                  setState(() => _currentValue = value),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),

                                // color: Color(hexColor('#C9E1FD')),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Scaffold(
                    body: SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        color: Color(hexColor('#FAFCFB')),
                        child: Column(
                          children: [
                            SizedBox(height: 44),
                            RichText(
                              text: TextSpan(
                                text: 'อาชีพของคุณ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 570,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  DropdownButton<String>(
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                      iconSize: 30,
                                      itemHeight: 60,
                                      dropdownColor: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      hint: const Text(
                                        'โปรดเลือกอาชีพ   ',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      value: dropdownValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                      items: <String>[
                                        'Apple',
                                        'Mango',
                                        'Banana',
                                        'Peach'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: 'IBMPlexSansThai',
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        );
                                      }).toList()),
                                  SizedBox(
                                    height: 145,
                                  ),
                                  Container(
                                      child: Image.asset(
                                          'assets/images/Career.png')),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Scaffold(
                    backgroundColor: Color(hexColor('#FAFCFB')),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 44),
                          RichText(
                            text: TextSpan(
                              text: 'ข้อมูลสุขภาพของคุณ',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 38, right: 38),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text('ส่วนสูง ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.start),
                                        Text('*',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'IBMPlexSansThai',
                                                color:
                                                    Color(hexColor('#FB6262')),
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.start),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 36,
                                      width: 205,
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          fillColor: Colors.white,
                                          suffixIcon: Container(
                                            padding: EdgeInsets.only(
                                                top: 4, left: 15, right: 20),
                                            child: Text(
                                              'ซม.',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#484554')),
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24)),
                                              borderSide: BorderSide(
                                                color:
                                                    Color(hexColor('#E9E9E9')),
                                                width: 1,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 55,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text('น้ำหนัก ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.start),
                                        Text('*',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'IBMPlexSansThai',
                                                color:
                                                    Color(hexColor('#FB6262')),
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.start),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 36,
                                      width: 205,
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          fillColor: Colors.white,
                                          suffixIcon: Container(
                                            padding: EdgeInsets.only(
                                                top: 4, left: 20, right: 20),
                                            child: Text(
                                              'กก.',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#484554')),
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24)),
                                              borderSide: BorderSide(
                                                color:
                                                    Color(hexColor('#E9E9E9')),
                                                width: 1,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 55,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('BMI ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.start),
                                    SizedBox(
                                      height: 36,
                                      width: 205,
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          fillColor: Colors.white,
                                          suffixIcon: Container(
                                            padding: EdgeInsets.only(
                                                top: 4, left: 20, right: 20),
                                            child: Text(
                                              'กก./ม.',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#484554')),
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24)),
                                              borderSide: BorderSide(
                                                color:
                                                    Color(hexColor('#E9E9E9')),
                                                width: 1,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 55,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('รอบเอว ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.start),
                                    SizedBox(
                                      height: 36,
                                      width: 205,
                                      child: TextFormField(
                                        textDirection: TextDirection.rtl,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          fillColor: Colors.white,
                                          suffixIcon: Container(
                                            padding: EdgeInsets.only(
                                                top: 4, left: 20, right: 20),
                                            child: Text(
                                              'นิ้ว',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#484554')),
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24)),
                                              borderSide: BorderSide(
                                                color:
                                                    Color(hexColor('#E9E9E9')),
                                                width: 1,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 53,
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 44),
                        RichText(
                          text: TextSpan(
                            text: 'ข้อมูลสุขภาพเพิ่มเติม',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 28, right: 28),
                          height: 570,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 26,
                              ),
                              Row(
                                children: [
                                  Text('ความดันโลหิต',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('ช่วงหัวใจบีบตัว (ตัวบน)',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.start),
                                  SizedBox(
                                    height: 34,
                                    width: 137,
                                    child: TextFormField(
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 20),
                                        fillColor: Colors.white,
                                        suffixIcon: Container(
                                          padding: EdgeInsets.only(
                                              top: 4, left: 15, right: 20),
                                          child: Text(
                                            'mmHg',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'IBMPlexSansThai',
                                                color:
                                                    Color(hexColor('#484554')),
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24)),
                                            borderSide: BorderSide(
                                              color: Color(hexColor('#E9E9E9')),
                                              width: 1,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('ช่วงหัวใจคลายตัว (ตัวล่าง)',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.start),
                                  SizedBox(
                                    height: 34,
                                    width: 137,
                                    child: TextFormField(
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 20),
                                        fillColor: Colors.white,
                                        suffixIcon: Container(
                                          padding: EdgeInsets.only(
                                              top: 4, left: 15, right: 20),
                                          child: Text(
                                            'mmHg',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'IBMPlexSansThai',
                                                color:
                                                    Color(hexColor('#484554')),
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24)),
                                            borderSide: BorderSide(
                                              color: Color(hexColor('#E9E9E9')),
                                              width: 1,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('อัตราการเต้นของหัวใจ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.start),
                                  SizedBox(
                                    height: 34,
                                    width: 137,
                                    child: TextFormField(
                                      textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 20),
                                        fillColor: Colors.white,
                                        suffixIcon: Container(
                                          padding: EdgeInsets.only(
                                              top: 4, left: 15, right: 20),
                                          child: Text(
                                            'ครั้ง/นาที',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'IBMPlexSansThai',
                                                color:
                                                    Color(hexColor('#484554')),
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24)),
                                            borderSide: BorderSide(
                                              color: Color(hexColor('#E9E9E9')),
                                              width: 1,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 44,
                              ),
                              Row(
                                children: [
                                  Text('ไตรกลีเซอไรด์ในเลือด',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 36,
                                child: TextFormField(
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
                                    fillColor: Colors.white,
                                    suffixIcon: Container(
                                      padding: EdgeInsets.only(
                                          top: 4, left: 15, right: 20),
                                      child: Text(
                                        'mg/dl.',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#484554')),
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24)),
                                        borderSide: BorderSide(
                                          color: Color(hexColor('#E9E9E9')),
                                          width: 1,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text('ไขมันดี (HDL)',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 36,
                                child: TextFormField(
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
                                    fillColor: Colors.white,
                                    suffixIcon: Container(
                                      padding: EdgeInsets.only(
                                          top: 4, left: 15, right: 20),
                                      child: Text(
                                        'mg/dl.',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#484554')),
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24)),
                                        borderSide: BorderSide(
                                          color: Color(hexColor('#E9E9E9')),
                                          width: 1,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text('น้ำตาลในเลือด',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                height: 36,
                                child: TextFormField(
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 20),
                                    fillColor: Colors.white,
                                    suffixIcon: Container(
                                      padding: EdgeInsets.only(
                                          top: 4, left: 15, right: 20),
                                      child: Text(
                                        'mg/dl.',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'IBMPlexSansThai',
                                            color: Color(hexColor('#484554')),
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(24)),
                                        borderSide: BorderSide(
                                          color: Color(hexColor('#E9E9E9')),
                                          width: 1,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 53,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 93,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 22.5, right: 22.5),
                        child: MaterialButton(
                          height: 44,
                          color: Color(hexColor('#2F4EF1')),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.5),
                          ),
                          onPressed: () {
                            if (_pageController.hasClients && _curPage < 4) {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MetabolicResult()));
                            }
                          },
                          child: Container(
                            height: 47,
                            alignment: Alignment.center,
                            child: Text("ถัดไป",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
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

  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: this.decoration,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 24,
                child: IconButton(
                    iconSize: 24,
                    icon: const Icon(Icons.keyboard_arrow_left),
                    onPressed: () {
                      if (_curStep > 1) {
                        _pageController.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.linear,
                        );
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StartScreening()));
                      }
                    }),
              ),
              Container(
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "ขั้นตอนที่ " +
                              (_curStep).toString() +
                              " จาก " +
                              _stepsText.length.toString(),
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
              ),
              Container(width: 24)
            ],
          ),
          SizedBox(
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
