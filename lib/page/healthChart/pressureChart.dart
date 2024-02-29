import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/healthChart/allPressureRecord.dart';
import 'package:flutter_application_1/page/nav.dart/nav.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/dayChart.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/sixMonthChart.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/threeMonthChart.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/weekChart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';
import '../../widget/chart/pressureChart.dart/monthChart.dart';
import '../profile/healthChart.dart';

class PressureChart extends StatelessWidget {
  const PressureChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PressureChartPage(),
    );
  }
}

class PressureChartPage extends StatefulWidget {
  const PressureChartPage({super.key});

  @override
  State<PressureChartPage> createState() => _PressureChartPageState();
}

class _PressureChartPageState extends State<PressureChartPage> {
  String? period = 'day';
  int _systolicPressure = 0;
  int _diastolicPressure = 0;
  int _pulseRate = 0;

  String _timeStamp = '';

  Future<void> fetchLatest() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getLatestRecord(token!);
      setState(() {
        _systolicPressure =
            response['data']['record'][0]['systolicBloodPressure'];
        _diastolicPressure =
            response['data']['record'][0]['diastolicBloodPressure'];
        _pulseRate = response['data']['record'][0]['pulseRate'];
        _timeStamp = response['data']['record'][0]['timestamp'];
        DateTime inputDateTime = DateTime.parse(_timeStamp);
        _timeStamp = DateFormat('dd MMM HH:mm', 'th').format(inputDateTime);
        print(_timeStamp);
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  late TextEditingController _controllerSystolicBloodPressure;
  late TextEditingController _controllerDiastolicBloodPressure;
  late TextEditingController _controllerPulseRate;

  bool checkBloodPressure = false;

  @override
  void initState() {
    fetchLatest();
    _controllerSystolicBloodPressure = TextEditingController(
        text: _systolicPressure == 0 ? null : _systolicPressure.toString());
    _controllerDiastolicBloodPressure = TextEditingController(
        text: _diastolicPressure == 0 ? null : _diastolicPressure.toString());
    _controllerPulseRate = TextEditingController(
        text: _pulseRate == 0 ? null : _pulseRate.toString());
    super.initState();
  }

  @override
  void dispose() {
    _controllerSystolicBloodPressure.dispose();
    _controllerDiastolicBloodPressure.dispose();
    _controllerPulseRate.dispose();
    super.dispose();
  }

  void _addPressure() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 265,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ความดันโลหิต',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _timeStamp,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Color(hexColor('#484554')),
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'ช่วงหัวใจบีบตัว (ตัวบน)',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 34,
                        width: 125,
                        child: TextFormField(
                          controller: _controllerSystolicBloodPressure,
                          onChanged: (value) {
                            setState(() {
                              _systolicPressure =
                                  (value == '') ? 0 : int.parse(value);
                              if (_controllerSystolicBloodPressure.text == "" &&
                                  _controllerDiastolicBloodPressure.text ==
                                      "" &&
                                  _controllerPulseRate.text == "") {
                                checkBloodPressure = false;
                              } else if (!(_controllerSystolicBloodPressure
                                          .text ==
                                      "" &&
                                  _controllerDiastolicBloodPressure.text ==
                                      "" &&
                                  _controllerPulseRate.text == "")) {
                                checkBloodPressure = false;
                              }
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 15),
                            fillColor: Colors.white,
                            suffixIcon: Container(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 15, right: 10),
                              child: Text(
                                'mmHg',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Color(hexColor('#484554')),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            hintText: _systolicPressure.toString(),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#999999')),
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: checkBloodPressure &&
                                          _controllerSystolicBloodPressure
                                                  .text ==
                                              ""
                                      ? Color(hexColor('#FB6262'))
                                      : Color(hexColor('#DBDBDB')),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: checkBloodPressure &&
                                          _controllerSystolicBloodPressure
                                                  .text ==
                                              ""
                                      ? Color(hexColor('#FB6262'))
                                      : Color(hexColor('#DBDBDB')),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: checkBloodPressure &&
                                          _controllerSystolicBloodPressure
                                                  .text ==
                                              ""
                                      ? Color(hexColor('#FB6262'))
                                      : Color(hexColor('#DBDBDB')),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'ช่วงหัวใจคลายตัว (ตัวล่าง)',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 34,
                        width: 125,
                        child: TextFormField(
                          controller: _controllerDiastolicBloodPressure,
                          onChanged: (value) {
                            _diastolicPressure =
                                (value == '') ? 0 : int.parse(value);
                            if (_controllerSystolicBloodPressure.text == "" &&
                                _controllerDiastolicBloodPressure.text == "" &&
                                _controllerPulseRate.text == "") {
                              checkBloodPressure = false;
                            } else if (!(_controllerSystolicBloodPressure
                                        .text ==
                                    "" &&
                                _controllerDiastolicBloodPressure.text == "" &&
                                _controllerPulseRate.text == "")) {
                              checkBloodPressure = false;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 15),
                            fillColor: Colors.white,
                            suffixIcon: Container(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 15, right: 10),
                              child: Text(
                                'mmHg',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Color(hexColor('#484554')),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            hintText: _diastolicPressure.toString(),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#999999')),
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: checkBloodPressure &&
                                          _controllerSystolicBloodPressure
                                                  .text ==
                                              ""
                                      ? Color(hexColor('#FB6262'))
                                      : Color(hexColor('#DBDBDB')),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: checkBloodPressure &&
                                          _controllerSystolicBloodPressure
                                                  .text ==
                                              ""
                                      ? Color(hexColor('#FB6262'))
                                      : Color(hexColor('#DBDBDB')),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: checkBloodPressure &&
                                          _controllerSystolicBloodPressure
                                                  .text ==
                                              ""
                                      ? Color(hexColor('#FB6262'))
                                      : Color(hexColor('#DBDBDB')),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'อัตราการเต้นของหัวใจ',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 34,
                        width: 125,
                        child: TextFormField(
                          controller: _controllerPulseRate,
                          onChanged: (value) {
                            _pulseRate = (value == '') ? 0 : int.parse(value);
                            if (_controllerSystolicBloodPressure.text == "" &&
                                _controllerDiastolicBloodPressure.text == "" &&
                                _controllerPulseRate.text == "") {
                              checkBloodPressure = false;
                            } else if (!(_controllerSystolicBloodPressure
                                        .text ==
                                    "" &&
                                _controllerDiastolicBloodPressure.text == "" &&
                                _controllerPulseRate.text == "")) {
                              checkBloodPressure = false;
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 15),
                            fillColor: Colors.white,
                            suffixIcon: Container(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 15, right: 10),
                              child: Text(
                                'ครั้ง/นาที',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Color(hexColor('#484554')),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            hintText: _pulseRate.toString(),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#999999')),
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: checkBloodPressure &&
                                          _controllerSystolicBloodPressure
                                                  .text ==
                                              ""
                                      ? Color(hexColor('#FB6262'))
                                      : Color(hexColor('#DBDBDB')),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: checkBloodPressure &&
                                          _controllerSystolicBloodPressure
                                                  .text ==
                                              ""
                                      ? Color(hexColor('#FB6262'))
                                      : Color(hexColor('#DBDBDB')),
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: checkBloodPressure &&
                                          _controllerSystolicBloodPressure
                                                  .text ==
                                              ""
                                      ? Color(hexColor('#FB6262'))
                                      : Color(hexColor('#DBDBDB')),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'ยกเลิก',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#7B7B7B')),
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Material(
                        color: Color(hexColor('#2F4EF1')),
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: const Text(
                              'บันทึก',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 58),
              child: Stack(alignment: Alignment.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Navbar(
                                      selectedIndex: 0,
                                    )));
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(hexColor('#484554')),
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                const Text(
                  'ความดันโลหิต',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Material(
                //   color: Color(hexColor('#2F4EF1')),
                //   borderRadius: BorderRadius.circular(30),
                //   child: InkWell(
                //     onTap: () {
                //       _addPressure();
                //     },
                //     child: Container(
                //       width: 76,
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //       child: const Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Icon(
                //             Icons.add_circle_outline_rounded,
                //             color: Colors.white,
                //             size: 20,
                //           ),
                //           SizedBox(
                //             width: 5,
                //           ),
                //           Text("เพิ่ม",
                //               style: TextStyle(
                //                   fontSize: 18,
                //                   fontFamily: 'IBMPlexSansThai',
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold),
                //               textAlign: TextAlign.center),
                //         ],
                //       ),
                //     ),
                //   ),
                // )
              ]),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        period = 'day';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: period == 'day'
                              ? Color(hexColor('#2F4EF1'))
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: period == 'day'
                                  ? Color(hexColor('#2F4EF1'))
                                  : Color(hexColor('#DBDBDB')))),
                      child: Text(
                        'วัน',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: period == 'day' ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Material(
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        period = 'week';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: period == 'week'
                              ? Color(hexColor('#2F4EF1'))
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: period == 'week'
                                  ? Color(hexColor('#2F4EF1'))
                                  : Color(hexColor('#DBDBDB')))),
                      child: Text(
                        'อาทิตย์',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: period == 'week' ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Material(
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        period = 'month';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: period == 'month'
                              ? Color(hexColor('#2F4EF1'))
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: period == 'month'
                                  ? Color(hexColor('#2F4EF1'))
                                  : Color(hexColor('#DBDBDB')))),
                      child: Text(
                        'เดือน',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color:
                              period == 'month' ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Material(
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        period = '3month';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: period == '3month'
                              ? Color(hexColor('#2F4EF1'))
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: period == '3month'
                                  ? Color(hexColor('#2F4EF1'))
                                  : Color(hexColor('#DBDBDB')))),
                      child: Text(
                        '3 เดือน',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color:
                              period == '3month' ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Material(
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      setState(() {
                        period = '6month';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: period == '6month'
                              ? Color(hexColor('#2F4EF1'))
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: period == '6month'
                                  ? Color(hexColor('#2F4EF1'))
                                  : Color(hexColor('#DBDBDB')))),
                      child: Text(
                        '6 เดือน',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color:
                              period == '6month' ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Color(hexColor('#FB6262')),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'ความดันตัวบน',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#7B7B7B')),
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "$_systolicPressure mmHg",
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Color(hexColor('#2F4EF1')),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'ความดันตัวล่าง',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#7B7B7B')),
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "$_diastolicPressure mmHg",
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Color(hexColor('#42884B')),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'ชีพจร',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'IBMPlexSansThai',
                                color: Color(hexColor('#7B7B7B')),
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "$_pulseRate ครั้ง/นาที",
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: period == 'day'
                  ? const DayChart()
                  : period == 'week'
                      ? const WeekChart()
                      : period == 'month'
                          ? const MonthChart()
                          : period == '3month'
                              ? const ThreeMonthChart()
                              : const SixMonthChart(),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'เกี่ยวกับความดันโลหิต',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ค่าบนเครื่องวัดความดัน\n',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                '1. Systolic blood pressure (SBP) ตัวบน คือ ความดันของเลือดสูงสุดขณะหัวใจห้องล่างบีบตัว\n\n2. Diastolic blood pressure (DBP) ตัวล่าง คือ ความดันเลือดที่ต่ำสุดขณะหัวใจห้องล่างคลายตัว\n',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Text(
                              '• เกณฑ์ความดัน\n',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                '- ความดันโลหิตเกณฑ์ปกติ คือ 120/80 (mm/Hg)\n\n- ความดันโลหิตค่อนข้างสูง แต่ยังอยู่ในเกณฑ์ปกติ คือ 121-139/80-89 (mm/Hg)\n\n- ความดันโลหิตสูงมาก คือ ความดันโลหิตตัวบน มากกว่า (หรือเท่ากับ) 140 (mm/Hg) และตัวล่างมากกว่า (หรือเท่ากับ) 90 (mm/Hg)\n\n- ความดันโลหิตระดับอันตราย 160/100 (mm/Hg)',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'ข้อมูลที่บันทึกทั้งหมด',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AllPressureRecordPage()));
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
