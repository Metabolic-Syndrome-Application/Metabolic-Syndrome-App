import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/healthChart/allLipidRecord.dart';
import 'package:flutter_application_1/page/healthChart/allPressureRecord.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:flutter_application_1/widget/chart/lipidChart.dart/dayChart.dart';
import 'package:flutter_application_1/widget/chart/lipidChart.dart/sixMonthChart.dart';
import 'package:flutter_application_1/widget/chart/lipidChart.dart/threeMonthChart.dart';
import 'package:flutter_application_1/widget/chart/lipidChart.dart/weekChart.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';
import '../../widget/chart/lipidChart.dart/monthChart.dart';
import '../profile/healthChart.dart';

class LipidChart extends StatefulWidget {
  const LipidChart({super.key});

  @override
  State<LipidChart> createState() => _LipidChartState();
}

class _LipidChartState extends State<LipidChart> {
  String? period = 'day';
  int _cholesterol = 0;
  int _hdl = 0;
  int _ldl = 0;
  int _triglyceride = 0;
  final _controllerSystolicPressure = TextEditingController();
  final _controllerDiastolicPressure = TextEditingController();
  final _controllerPulseRate = TextEditingController();
  final bool _validateSystolicPressure = false;
  final bool _validateDiastolicPressure = false;
  final bool _validatePulseRate = false;

  Future<void> fetchLatest() async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      Map<String, dynamic> response = await getLatestRecord(token!);
      setState(() {
        _cholesterol = response['data']['record'][0]['cholesterol'];
        _hdl = response['data']['record'][0]['hdl'];
        _ldl = response['data']['record'][0]['ldl'];
        _triglyceride = response['data']['record'][0]['triglyceride'];
      });
    } catch (e) {
      // print('Error fetching profile: $e');
    }
  }

  @override
  void initState() {
    fetchLatest();

    super.initState();
  }

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
                        'ความดันโลหิต',
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
                          onChanged: (value) {
                            // _cholesterol = value;
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
                                'mmHg',
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
                          onChanged: (value) {
                            // _diastolicPressure = value;
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
                                'mmHg',
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
                          onChanged: (value) {
                            // _hdl = value;
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
                                'ครั้ง/นาที',
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
              child: Stack(alignment: Alignment.center, children: [
                Row(
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
                  ],
                ),
                const Text(
                  'ไขมันในเลือด',
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
                            backgroundColor: Color(hexColor('#2F4EF1')),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'ไขมันดี',
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
                        "$_ldl mg/dL",
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
                            backgroundColor: Color(hexColor('#FB6262')),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'ไขมันอันตราย',
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
                        "$_hdl mg/dL",
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
                            'ไตรกลีเซอไรด์',
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
                        "$_triglyceride mg/dL",
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
                      'ไขมันในเลือด',
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
                              'สาเหตุของภาวะไขมันในเลือดสูง\n',
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
                                'เกิดได้จากการรับประทานอาหารที่มีส่วนผสมของไขมันมากเกินไป โดยเฉพาะไขมันชนิดอิ่มตัวและไขมันทรานส์ การไม่ออกกำลังกาย การสูบบุหรี่ การดื่มแอลกอฮอล์ กรรมพันธุ์ การมีโรคประจำตัวบางชนิด เช่น โรคตับ ตับอ่อน ภาวะพร่องไทรอยด์ ภาวะถุงน้ำในรังไข่จำนวนมาก โรคไตวาย โรคเบาหวาน หรือการใช้ยาบางชนิด เช่น ฮอร์โมนหรือยาคุมกำเนิด ยาสเตียรอยด์ ยาต้านไวรัส HIV\n',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            Text(
                              'เกณฑ์ความดัน\n',
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
                                'โดยทั่วไปแล้วในผู้ที่อายุมากกว่า 20 ปี ควรมีค่า\n• Total cholesterol : < 200 mg/dL\n• HDL: มากกว่า 40 mg/dL ในเพศชาย และมากกว่า 50 mg/dL ในเพศหญิง\n• LDL: < 130 mg/dL\n• Triglycerides: < 150 mg/dL',
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
                                        const AllLipidRecord()));
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
