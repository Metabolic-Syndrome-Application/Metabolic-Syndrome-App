import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/healthChart/allBMIRecord.dart';
import 'package:flutter_application_1/page/healthChart/allPressureRecord.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/dayChart.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/sixMonthChart.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/threeMonthChart.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/weekChart.dart';

import '../../extension/Color.dart';
import '../../widget/chart/pressureChart.dart/monthChart.dart';
import '../profile/healthChart.dart';

class BMIChart extends StatelessWidget {
  const BMIChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BMIChartPage(),
    );
  }
}

class BMIChartPage extends StatefulWidget {
  const BMIChartPage({super.key});

  @override
  State<BMIChartPage> createState() => _BMIChartPageState();
}

class _BMIChartPageState extends State<BMIChartPage> {
  String? period = 'day';
  String _systolicPressure = '';
  String _diastolicPressure = '';
  String _pulseRate = '';
  final _controllerSystolicPressure = TextEditingController();
  final _controllerDiastolicPressure = TextEditingController();
  final _controllerPulseRate = TextEditingController();
  final bool _validateSystolicPressure = false;
  final bool _validateDiastolicPressure = false;
  final bool _validatePulseRate = false;

  @override
  void dispose() {
    _controllerSystolicPressure.dispose();
    _controllerDiastolicPressure.dispose();
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
                        'ดัชนีมวลกาย',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '14 ส.ค. 09:45',
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
                        'น้ำหนัก',
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
                          onChanged: (value) {
                            _systolicPressure = value;
                          },
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#FB6262')),
                                  width: 1,
                                )),
                            contentPadding: const EdgeInsets.only(left: 10),
                            fillColor: Colors.white,
                            suffixIcon: Container(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 3, right: 10),
                              child: Text(
                                'กก.',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Color(hexColor('#484554')),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(24)),
                                borderSide: BorderSide(
                                  color: _validateSystolicPressure
                                      ? Color(hexColor('#E9E9E9'))
                                      : Color(hexColor('#FB6262')),
                                  width: 1,
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
                        'ส่วนสูง',
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
                          onChanged: (value) {
                            _diastolicPressure = value;
                          },
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            fillColor: Colors.white,
                            suffixIcon: Container(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 3, right: 10),
                              child: Text(
                                'ซม.',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Color(hexColor('#484554')),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(24)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#E9E9E9')),
                                  width: 1,
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
                        'รอบเอว',
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
                          onChanged: (value) {
                            _pulseRate = value;
                          },
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            fillColor: Colors.white,
                            suffixIcon: Container(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 3, right: 10),
                              child: Text(
                                'นิ้ว',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'IBMPlexSansThai',
                                    color: Color(hexColor('#484554')),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(24)),
                                borderSide: BorderSide(
                                  color: Color(hexColor('#E9E9E9')),
                                  width: 1,
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HealthChart()));
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
                    const Text(
                      'ดัชนีมวลกาย',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Material(
                      color: Color(hexColor('#2F4EF1')),
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: () {
                          _addPressure();
                        },
                        child: Container(
                          width: 76,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("เพิ่ม",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'IBMPlexSansThai',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    )
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
                            'น้ำหนัก',
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
                      const Text(
                        '55 กก.',
                        style: TextStyle(
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
                            'ค่าดัชนีมวลกาย',
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
                      const Text(
                        '17.2 กก./ม.',
                        style: TextStyle(
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
                            'รอบเอว',
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
                      const Text(
                        '25 นิ้ว',
                        style: TextStyle(
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ค่าดัชนีมวลกาย',
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
                          'คือ การมีดัชนีมวลกายก่อนมากกว่าหรือเท่ากับ 2\n5 กิโลกรัม/ตารางเมตร\n\nแบ่งเป็น 4 ระดับ คือ',
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
                            '• ระดับ 1a 25.0-29.9\n• ระดับ 1b 30-34.9\n• ระดับ 2 35.0-39.9\n• ระดับ 3 ≥ 40.0 กิโลกรัม/ตารางเมตร',
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
                SizedBox(
                  height: 15,
                ),
                Text(
                  'รอบเอว',
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
                          'ค่าปกติของเส้นรอบเอว',
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
                            '• ผู้หญิง ไม่ควรเกิน 80 เซนติเมตร / 32 นิ้ว\n• ผู้ชาย ไม่ควรเกิน 90 เซนติเมตร / 36 นิ้ว',
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
                                builder: (context) => const AllBMIRecord()));
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
            ),
          ],
        ),
      ),
    );
  }
}
