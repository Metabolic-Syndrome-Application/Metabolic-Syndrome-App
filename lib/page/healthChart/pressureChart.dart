import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/healthChart/allPressureRecord.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/dayChart.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/sixMonthChart.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/threeMonthChart.dart';
import 'package:flutter_application_1/widget/chart/pressureChart.dart/weekChart.dart';

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
  final _formKey = GlobalKey<FormState>();
  void _addPressure() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(10),
              child: Stack(
                //overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    padding: EdgeInsets.fromLTRB(25, 50, 25,0),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Text(
                            'ความดันโลหิต',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Material(
                            color: Color(hexColor('#2F4EF1')),
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
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
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                child: const Text('Submitß'),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                  )
                ],
              ));
        });
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) {
    //     return AlertDialog(
    //         //titlePadding: EdgeInsets.only(top: 0),
    //         // contentPadding: EdgeInsets.only(left: 25, right: 25, top: 0),
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(20.0))),
    //         title: Row(
    //           children: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: Text(
    //                 'ยกเลิก',
    //                 style: TextStyle(
    //                     fontSize: 18,
    //                     fontFamily: 'IBMPlexSansThai',
    //                     color: Color(hexColor('#7B7B7B')),
    //                     fontWeight: FontWeight.normal),
    //               ),
    //             ),
    //             Text(
    //               'ความดันโลหิต',
    //               style: TextStyle(
    //                   fontSize: 24,
    //                   fontFamily: 'IBMPlexSansThai',
    //                   color: Colors.black,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             Material(
    //               color: Color(hexColor('#2F4EF1')),
    //               borderRadius: BorderRadius.circular(30),
    //               child: InkWell(
    //                 onTap: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: Container(
    //                   padding: EdgeInsets.symmetric(horizontal: 10),
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(30)),
    //                   child: Text(
    //                     'บันทึก',
    //                     style: TextStyle(
    //                         fontSize: 18,
    //                         fontFamily: 'IBMPlexSansThai',
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //         content: Container());
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'ความดันโลหิต',
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
                            'ช่วงหัวใจบีบตัว',
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
                        '110 mmHg',
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
                            'ช่วงหัวใจคลายตัว',
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
                        '75 mmHg',
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
                      const Text(
                        '75 ครั้ง/นาที',
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
                      ? WeekChart()
                      : period == 'month'
                          ? MonthChart()
                          : period == '3month'
                              ? ThreeMonthChart()
                              : SixMonthChart(),
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
                    SizedBox(height: 15),
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
                    SizedBox(height: 40),
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
                                    builder: (context) => AllPressureRecord()));
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
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
