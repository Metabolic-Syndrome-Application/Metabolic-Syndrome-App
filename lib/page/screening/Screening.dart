import 'dart:math';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/screening/metabolicResult.dart';
import 'package:flutter_application_1/page/screening/startScreening.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

class ScreeningPage extends StatefulWidget {
  const ScreeningPage({Key? key}) : super(key: key);

  @override
  _ScreeningPageState createState() => _ScreeningPageState();
}

class _ScreeningPageState extends State<ScreeningPage> {
  final _stepsText = [
    "อาชีพของคุณ",
    "ข้อมูลสุขภาพของคุณ",
    "ข้อมูลสุขภาพเพิ่มเติม"
  ];

  late double height = 0;
  late double weight = 0;
  late double bmi = 0;
  late double waistline = 0;
  late int systolicBloodPressure = 0;
  late int diastolicBloodPressure = 0;
  late int pulseRate = 0;
  late double bloodGlucose = 0;
  late double triglyceride = 0;
  late double hdl = 0;
  String metabolicResult = '';

  late TextEditingController _controllerHeight;
  late TextEditingController _controllerWeight;
  late TextEditingController _controllerBmi;
  late TextEditingController _controllerWaistline;
  late TextEditingController _controllerSystolicBloodPressure;
  late TextEditingController _controllerDiastolicBloodPressure;
  late TextEditingController _controllerPulseRate;
  late TextEditingController _controllerBloodGlucose;
  late TextEditingController _controllerTriglyceride;
  late TextEditingController _controllerHdl;

  final _stepCircleRadius = 10.0;

  final _stepProgressViewHeight = 150.0;

  final Color _activeColor = Color(hexColor('#2F4EF1'));

  final Color _inactiveColor = Color(hexColor('#DBDBDB'));

  final TextStyle _headerStyle =
      const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  final TextStyle _stepStyle =
      const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

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
      padding: const EdgeInsets.only(top: 53.0),
    );
  }

  String? dropdownValue;

  int initial = 1;
  bool isPayment = false;
  late final CustomSegmentedController<int> controller;

  bool checkHeight = false;
  bool checkWeight = false;
  bool checkWaistline = false;
  bool checkSystolic = false;
  bool checkDiastolic = false;
  bool checkPulse = false;
  bool checkGlucose = false;
  bool checkTrigly = false;
  bool checkHdl = false;

  @override
  void initState() {
    controller = CustomSegmentedController();
    _controllerHeight = TextEditingController(
        text: height == 0 ? null : height.round().toString());
    _controllerWeight = TextEditingController(
        text: weight == 0 ? null : weight.round().toString());
    _controllerWaistline = TextEditingController(
        text: waistline == 0 ? null : waistline.round().toString());
    _controllerBmi = TextEditingController(text: bmi.toString());
    _controllerSystolicBloodPressure = TextEditingController(
        text: systolicBloodPressure == 0
            ? null
            : systolicBloodPressure.toString());
    _controllerDiastolicBloodPressure = TextEditingController(
        text: diastolicBloodPressure == 0
            ? null
            : diastolicBloodPressure.toString());
    _controllerPulseRate = TextEditingController(
        text: pulseRate == 0 ? null : pulseRate.toString());
    _controllerBloodGlucose = TextEditingController(
        text: bloodGlucose == 0 ? null : bloodGlucose.round().toString());
    _controllerTriglyceride = TextEditingController(
        text: triglyceride == 0 ? null : triglyceride.round().toString());
    _controllerHdl =
        TextEditingController(text: hdl == 0 ? null : hdl.round().toString());
    super.initState();
  }

  Future<void> fetchMetabolic(
      String accesstoken,
      String occupation,
      double heigth,
      double weight,
      double bmi,
      double waistline,
      int systolicBloodPressure,
      int diastolicBloodPressure,
      int pulseRate,
      double bloodGlucose,
      double triglyceride,
      double hdl) async {
    String? token = Provider.of<AuthProvider>(context, listen: false).token;
    try {
      Map<String, dynamic> response = await postMetabolic(
          token!,
          occupation,
          heigth,
          weight,
          bmi,
          waistline,
          systolicBloodPressure,
          diastolicBloodPressure,
          pulseRate,
          bloodGlucose,
          triglyceride,
          hdl);
      setState(() {
        metabolicResult = response['data']['metabolicRisk'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? token = Provider.of<AuthProvider>(context).token;

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
                          child: Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 44),
                                RichText(
                                  text: const TextSpan(
                                    text: 'อาชีพของคุณ',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 570,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      DropdownButton2<String>(
                                          alignment: Alignment.centerLeft,
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: 200,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(.3),
                                                  blurRadius: 4.0,
                                                  spreadRadius: .1,
                                                  offset: const Offset(
                                                    2.0,
                                                    4.0,
                                                  ),
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              color: Colors.white,
                                            ),
                                            scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(3),
                                              thickness: MaterialStateProperty
                                                  .all<double>(6),
                                              thumbVisibility:
                                                  MaterialStateProperty.all<
                                                      bool>(true),
                                            ),
                                          ),
                                          // menuMaxHeight: 500,
                                          // icon: const Icon(Icons
                                          //     .keyboard_arrow_down_outlined),
                                          // iconSize: 30,
                                          // itemHeight: 60,
                                          // dropdownColor: Colors.white,
                                          // borderRadius:
                                          // BorderRadius.circular(20),
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
                                            'แพทย์',
                                            'วิศวกร',
                                            'ค้าขาย',
                                            'นักศึกษา/นักศึกษา',
                                            'ครู/อาจารย์',
                                            'เชฟ',
                                            'นักเขียน',
                                            'โปรแกรมเมอร์',
                                            'สถาปนิก',
                                            'นักเครื่องดนตรี',
                                            'ช่าง',
                                            'ผู้ประกอบการ' 'อื่นๆ'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            );
                                          }).toList()),
                                      const SizedBox(
                                        height: 145,
                                      ),
                                      Image.asset('assets/images/Career.png'),
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
                              const SizedBox(height: 44),
                              RichText(
                                text: const TextSpan(
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
                                padding:
                                    const EdgeInsets.only(left: 38, right: 38),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              const Text('ส่วนสูง ',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily:
                                                          'IBMPlexSansThai',
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.start),
                                              Text('*',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily:
                                                          'IBMPlexSansThai',
                                                      color: Color(
                                                          hexColor('#FB6262')),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.start),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 36,
                                          width: 205,
                                          child: TextFormField(
                                            controller: _controllerHeight,
                                            onChanged: (value) {
                                              setState(() {
                                                checkHeight = false;
                                                height = (value == '' ||
                                                        value == '0')
                                                    ? 0
                                                    : double.parse(value);
                                                bmi =
                                                    (height == 0 || weight == 0)
                                                        ? 0
                                                        : weight /
                                                            pow(
                                                                double.parse(
                                                                        value) /
                                                                    100,
                                                                2);
                                                _controllerBmi.text =
                                                    bmi.toStringAsFixed(2);
                                              });
                                            },
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                decimal: true),
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                    color: checkHeight == true
                                                        ? Color(
                                                            hexColor('#FB6262'))
                                                        : Color(hexColor(
                                                            '#484554')),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(24)),
                                                  borderSide: BorderSide(
                                                    color: checkHeight == true
                                                        ? Color(
                                                            hexColor('#FB6262'))
                                                        : Color(hexColor(
                                                            '#484554')),
                                                    width: 1,
                                                  )),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 20),
                                              fillColor: Colors.white,
                                              suffixIcon: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 8,
                                                    left: 15,
                                                    right: 20),
                                                child: Text(
                                                  'ซม.',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'IBMPlexSansThai',
                                                      color: Color(
                                                          hexColor('#484554')),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(24)),
                                                  borderSide: BorderSide(
                                                    color: Color(
                                                        hexColor('#E9E9E9')),
                                                    width: 1,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    checkHeight == true
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "กรุณากรอกส่วนสูง",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#FB6262')),
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : const Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'IBMPlexSansThai',
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text('น้ำหนัก ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.start),
                                            Text('*',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#FB6262')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.start),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 36,
                                          width: 205,
                                          child: TextFormField(
                                            controller: _controllerWeight,
                                            onChanged: (value) {
                                              setState(() {
                                                weight = (value == '' ||
                                                        value == '0')
                                                    ? 0
                                                    : double.parse(value);
                                                bmi = (height == 0 ||
                                                        weight == 0)
                                                    ? 0
                                                    : weight /
                                                        pow(height / 100, 2);
                                                _controllerBmi.text =
                                                    bmi.toStringAsFixed(2);
                                                checkWeight = false;
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                    color: checkWeight == true
                                                        ? Color(
                                                            hexColor('#FB6262'))
                                                        : Color(hexColor(
                                                            '#484554')),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(24)),
                                                  borderSide: BorderSide(
                                                    color: checkWeight == true
                                                        ? Color(
                                                            hexColor('#FB6262'))
                                                        : Color(hexColor(
                                                            '#484554')),
                                                    width: 1,
                                                  )),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 20),
                                              fillColor: Colors.white,
                                              suffixIcon: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 8,
                                                    left: 20,
                                                    right: 20),
                                                child: Text(
                                                  'กก.',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'IBMPlexSansThai',
                                                      color: Color(
                                                          hexColor('#484554')),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(24)),
                                                  borderSide: BorderSide(
                                                    color: Color(
                                                        hexColor('#E9E9E9')),
                                                    width: 1,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    checkWeight == true
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "กรุณากรอกน้ำหนัก",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#FB6262')),
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : const Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'IBMPlexSansThai',
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('BMI ',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'IBMPlexSansThai',
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.start),
                                        SizedBox(
                                          height: 36,
                                          width: 205,
                                          child: TextField(
                                            enableInteractiveSelection: false,
                                            readOnly: true,
                                            controller: _controllerBmi,
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(24)),
                                                  borderSide: BorderSide(
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    width: 1,
                                                  )),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 20),
                                              fillColor: Colors.white,
                                              suffixIcon: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 8,
                                                    left: 20,
                                                    right: 20),
                                                child: Text(
                                                  'กก./ม.²',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'IBMPlexSansThai',
                                                      color: Color(
                                                          hexColor('#484554')),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(24)),
                                                  borderSide: BorderSide(
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    width: 1,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 55,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text('รอบเอว ',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.start),
                                            Text('*',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#FB6262')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.start),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 36,
                                          width: 205,
                                          child: TextFormField(
                                            controller: _controllerWaistline,
                                            onChanged: (value) {
                                              setState(() {
                                                waistline = (value == '' ||
                                                        value == '0')
                                                    ? 0
                                                    : double.parse(value);
                                                checkWaistline = false;
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            textDirection: TextDirection.rtl,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  borderSide: BorderSide(
                                                    color: checkWaistline ==
                                                            true
                                                        ? Color(
                                                            hexColor('#FB6262'))
                                                        : Color(hexColor(
                                                            '#484554')),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(24)),
                                                  borderSide: BorderSide(
                                                    color: checkWaistline ==
                                                            true
                                                        ? Color(
                                                            hexColor('#FB6262'))
                                                        : Color(hexColor(
                                                            '#484554')),
                                                    width: 1,
                                                  )),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 20),
                                              fillColor: Colors.white,
                                              suffixIcon: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 8,
                                                    left: 20,
                                                    right: 20),
                                                child: Text(
                                                  'นิ้ว',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'IBMPlexSansThai',
                                                      color: Color(
                                                          hexColor('#484554')),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(24)),
                                                  borderSide: BorderSide(
                                                    color: Color(
                                                        hexColor('#E9E9E9')),
                                                    width: 1,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    checkWaistline == true
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "กรุณากรอกค่ารอบเอว",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#FB6262')),
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : const Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'IBMPlexSansThai',
                                                fontWeight: FontWeight.normal),
                                            textAlign: TextAlign.center,
                                          ),
                                    const SizedBox(
                                      height: 32,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                      Scaffold(
                        backgroundColor: Color(hexColor('#FAFCFB')),
                        body: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 44),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'ข้อมูลสุขภาพเพิ่มเติม',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(' *',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: 'IBMPlexSansThai',
                                          color: Color(hexColor('#FB6262')),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start),
                                ],
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 28, right: 28),
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 26,
                                      ),
                                      Row(
                                        children: [
                                          const Text('ความดันโลหิต',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left),
                                          Text(' *',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#FB6262')),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('ช่วงหัวใจบีบตัว (ตัวบน)',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.start),
                                          SizedBox(
                                            height: 34,
                                            width: 137,
                                            child: TextFormField(
                                              controller:
                                                  _controllerSystolicBloodPressure,
                                              onChanged: (value) {
                                                setState(() {
                                                  systolicBloodPressure =
                                                      (value == '' ||
                                                              value == '0')
                                                          ? 0
                                                          : int.parse(value);
                                                  checkSystolic = false;
                                                });
                                              },
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  signed: false),
                                              textDirection: TextDirection.rtl,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderSide: BorderSide(
                                                          color: checkSystolic ==
                                                                  true
                                                              ? Color(hexColor(
                                                                  '#FB6262'))
                                                              : Color(hexColor(
                                                                  '#484554')),
                                                        )),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    24)),
                                                        borderSide: BorderSide(
                                                          color: checkSystolic ==
                                                                  true
                                                              ? Color(hexColor(
                                                                  '#FB6262'))
                                                              : Color(hexColor(
                                                                  '#484554')),
                                                          width: 1,
                                                        )),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 20),
                                                fillColor: Colors.white,
                                                suffixIcon: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 9,
                                                          left: 15,
                                                          right: 15),
                                                  child: Text(
                                                    'mmHg',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'IBMPlexSansThai',
                                                        color: Color(hexColor(
                                                            '#484554')),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                24)),
                                                    borderSide: BorderSide(
                                                      color: Color(
                                                          hexColor('#E9E9E9')),
                                                      width: 1,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      checkSystolic == true
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "กรุณากรอกค่า",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#FB6262')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                              'ช่วงหัวใจคลายตัว (ตัวล่าง)',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.start),
                                          SizedBox(
                                            height: 34,
                                            width: 137,
                                            child: TextFormField(
                                              controller:
                                                  _controllerDiastolicBloodPressure,
                                              onChanged: (value) {
                                                setState(() {
                                                  diastolicBloodPressure =
                                                      (value == '' ||
                                                              value == '0')
                                                          ? 0
                                                          : int.parse(value);
                                                  checkDiastolic = false;
                                                });
                                              },
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  signed: false),
                                              textDirection: TextDirection.rtl,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderSide: BorderSide(
                                                          color: checkDiastolic ==
                                                                  true
                                                              ? Color(hexColor(
                                                                  '#FB6262'))
                                                              : Color(hexColor(
                                                                  '#484554')),
                                                        )),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    24)),
                                                        borderSide: BorderSide(
                                                          color: checkDiastolic ==
                                                                  true
                                                              ? Color(hexColor(
                                                                  '#FB6262'))
                                                              : Color(hexColor(
                                                                  '#484554')),
                                                          width: 1,
                                                        )),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 20),
                                                fillColor: Colors.white,
                                                suffixIcon: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 9,
                                                          left: 15,
                                                          right: 15),
                                                  child: Text(
                                                    'mmHg',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'IBMPlexSansThai',
                                                        color: Color(hexColor(
                                                            '#484554')),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                24)),
                                                    borderSide: BorderSide(
                                                      color: Color(
                                                          hexColor('#E9E9E9')),
                                                      width: 1,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      checkDiastolic == true
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "กรุณากรอกค่า",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#FB6262')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('อัตราการเต้นของหัวใจ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.start),
                                          SizedBox(
                                            height: 34,
                                            width: 137,
                                            child: TextFormField(
                                              controller: _controllerPulseRate,
                                              onChanged: (value) {
                                                setState(() {
                                                  pulseRate = (value == '' ||
                                                          value == '0')
                                                      ? 0
                                                      : int.parse(value);
                                                  checkPulse = false;
                                                });
                                              },
                                              keyboardType: const TextInputType
                                                  .numberWithOptions(
                                                  signed: false),
                                              textDirection: TextDirection.rtl,
                                              decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.0),
                                                        borderSide: BorderSide(
                                                          color: checkPulse ==
                                                                  true
                                                              ? Color(hexColor(
                                                                  '#FB6262'))
                                                              : Color(hexColor(
                                                                  '#484554')),
                                                        )),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    24)),
                                                        borderSide: BorderSide(
                                                          color: checkPulse ==
                                                                  true
                                                              ? Color(hexColor(
                                                                  '#FB6262'))
                                                              : Color(hexColor(
                                                                  '#484554')),
                                                          width: 1,
                                                        )),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 20),
                                                fillColor: Colors.white,
                                                suffixIcon: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 9,
                                                          left: 3,
                                                          right: 15),
                                                  child: Text(
                                                    'ครั้ง/นาที',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'IBMPlexSansThai',
                                                        color: Color(hexColor(
                                                            '#484554')),
                                                        fontWeight:
                                                            FontWeight.normal),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                24)),
                                                    borderSide: BorderSide(
                                                      color: Color(
                                                          hexColor('#E9E9E9')),
                                                      width: 1,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      checkPulse == true
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "กรุณากรอกค่า",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#FB6262')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Text('น้ำตาลในเลือด',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left),
                                          Text(' *',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#FB6262')),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      SizedBox(
                                        height: 36,
                                        child: TextFormField(
                                          controller: _controllerBloodGlucose,
                                          onChanged: (value) {
                                            setState(() {
                                              bloodGlucose =
                                                  (value == '' || value == '0')
                                                      ? 0
                                                      : double.parse(value);
                                              checkGlucose = false;
                                            });
                                          },
                                          keyboardType: const TextInputType
                                              .numberWithOptions(signed: false),
                                          textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkGlucose == true
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#484554')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: checkGlucose == true
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#484554')),
                                                  width: 1,
                                                )),
                                            contentPadding:
                                                const EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 8, left: 15, right: 15),
                                              child: Text(
                                                'mg/dl.',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#E9E9E9')),
                                                  width: 1,
                                                )),
                                          ),
                                        ),
                                      ),
                                      checkGlucose == true
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "กรุณากรอกค่าน้ำตาล",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#FB6262')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text('ไตรกลีเซอไรด์ในเลือด',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left),
                                          Text(' *',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#FB6262')),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      SizedBox(
                                        height: 36,
                                        child: TextFormField(
                                          controller: _controllerTriglyceride,
                                          onChanged: (value) {
                                            setState(() {
                                              triglyceride =
                                                  (value == '' || value == '0')
                                                      ? 0
                                                      : double.parse(value);
                                              checkTrigly = false;
                                            });
                                          },
                                          keyboardType: const TextInputType
                                              .numberWithOptions(signed: false),
                                          textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkTrigly == true
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#484554')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: checkTrigly == true
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#484554')),
                                                  width: 1,
                                                )),
                                            contentPadding:
                                                const EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 8, left: 15, right: 15),
                                              child: Text(
                                                'mg/dl.',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#E9E9E9')),
                                                  width: 1,
                                                )),
                                          ),
                                        ),
                                      ),
                                      checkTrigly == true
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "กรุณากรอกค่าไตรกลีเซอไรด์",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#FB6262')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text('ไขมันดี (HDL)',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left),
                                          Text(' *',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  color: Color(
                                                      hexColor('#FB6262')),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      SizedBox(
                                        height: 36,
                                        child: TextFormField(
                                          controller: _controllerHdl,
                                          onChanged: (value) {
                                            setState(() {
                                              hdl =
                                                  (value == '' || value == '0')
                                                      ? 0
                                                      : double.parse(value);
                                              checkHdl = false;
                                            });
                                          },
                                          keyboardType: const TextInputType
                                              .numberWithOptions(signed: false),
                                          textDirection: TextDirection.rtl,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: checkHdl == true
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#484554')),
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: checkHdl == true
                                                      ? Color(
                                                          hexColor('#FB6262'))
                                                      : Color(
                                                          hexColor('#484554')),
                                                  width: 1,
                                                )),
                                            contentPadding:
                                                const EdgeInsets.only(left: 20),
                                            fillColor: Colors.white,
                                            suffixIcon: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 8, left: 15, right: 15),
                                              child: Text(
                                                'mg/dl.',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#484554')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(24)),
                                                borderSide: BorderSide(
                                                  color: Color(
                                                      hexColor('#E9E9E9')),
                                                  width: 1,
                                                )),
                                          ),
                                        ),
                                      ),
                                      checkHdl == true
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "กรุณากรอกค่าไตรกลีเซอไรด์",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'IBMPlexSansThai',
                                                    color: Color(
                                                        hexColor('#FB6262')),
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : const Text(
                                              "",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'IBMPlexSansThai',
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.center,
                                            ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 150,
                              )
                            ],
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
                            left: 22.5, right: 22.5, bottom: 50),
                        child: MaterialButton(
                          height: 44,
                          color: Color(hexColor('#2F4EF1')),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.5),
                          ),
                          onPressed: () async {
                            if (_pageController.hasClients && _curPage < 3) {
                              if (_curPage == 1) {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn);
                              } else if (_curPage == 2) {
                                if (_controllerHeight.text.isEmpty == true ||
                                    height == 0) {
                                  setState(() {
                                    checkHeight = true;
                                    checkWeight = false;
                                    checkWaistline = false;
                                  });
                                } else if (_controllerWeight.text.isEmpty ==
                                        true ||
                                    weight == 0) {
                                  setState(() {
                                    checkHeight = false;
                                    checkWeight = true;
                                    checkWaistline = false;
                                  });
                                } else if (_controllerWaistline.text.isEmpty ==
                                        true ||
                                    waistline == 0) {
                                  setState(() {
                                    checkHeight = false;
                                    checkWeight = false;
                                    checkWaistline = true;
                                  });
                                } else {
                                  _pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeIn);
                                }
                              }
                            } else {
                              if (_controllerSystolicBloodPressure
                                          .text.isEmpty ==
                                      true ||
                                  systolicBloodPressure == 0) {
                                setState(() {
                                  checkDiastolic = false;
                                  checkSystolic = true;
                                  checkPulse = false;
                                  checkGlucose = false;
                                  checkTrigly = false;
                                  checkHdl = false;
                                });
                              } else if (_controllerDiastolicBloodPressure
                                          .text.isEmpty ==
                                      true ||
                                  diastolicBloodPressure == 0) {
                                setState(() {
                                  checkDiastolic = true;
                                  checkSystolic = false;
                                  checkPulse = false;
                                  checkGlucose = false;
                                  checkTrigly = false;
                                  checkHdl = false;
                                });
                              } else if (_controllerPulseRate.text.isEmpty ==
                                      true ||
                                  pulseRate == 0) {
                                setState(() {
                                  checkDiastolic = false;
                                  checkSystolic = false;
                                  checkPulse = true;
                                  checkGlucose = false;
                                  checkTrigly = false;
                                  checkHdl = false;
                                });
                              } else if (_controllerBloodGlucose.text.isEmpty ==
                                      true ||
                                  bloodGlucose == 0) {
                                setState(() {
                                  checkDiastolic = false;
                                  checkSystolic = false;
                                  checkPulse = false;
                                  checkGlucose = true;
                                  checkTrigly = false;
                                  checkHdl = false;
                                });
                              } else if (_controllerTriglyceride.text.isEmpty ==
                                      true ||
                                  triglyceride == 0) {
                                setState(() {
                                  checkDiastolic = false;
                                  checkSystolic = false;
                                  checkPulse = false;
                                  checkGlucose = false;
                                  checkTrigly = true;
                                  checkHdl = false;
                                });
                              } else if (_controllerHdl.text.isEmpty == true ||
                                  hdl == 0) {
                                setState(() {
                                  checkDiastolic = false;
                                  checkSystolic = false;
                                  checkPulse = false;
                                  checkGlucose = false;
                                  checkTrigly = false;
                                  checkHdl = true;
                                });
                              } else {
                                if (height != 0 &&
                                    weight != 0 &&
                                    bmi != 0 &&
                                    waistline != 0 &&
                                    systolicBloodPressure != 0 &&
                                    diastolicBloodPressure != 0 &&
                                    pulseRate != 0 &&
                                    bloodGlucose != 0 &&
                                    triglyceride != 0 &&
                                    hdl != 0) {
                                  await fetchMetabolic(
                                      token!,
                                      dropdownValue ?? '',
                                      height,
                                      weight,
                                      bmi,
                                      waistline,
                                      systolicBloodPressure,
                                      diastolicBloodPressure,
                                      pulseRate,
                                      bloodGlucose,
                                      triglyceride,
                                      hdl);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MetabolicResultPage(
                                                metabolicResult:
                                                    metabolicResult,
                                              )));
                                }
                              }
                            }
                          },
                          child: Container(
                            height: 47,
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
                    ],
                  )
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 24,
                child: IconButton(
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
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "ขั้นตอนที่ $_curStep จาก ${_stepsText.length}",
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
              Container(width: 24)
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
