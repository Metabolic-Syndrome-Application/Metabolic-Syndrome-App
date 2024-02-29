import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/healthChart/allPressureRecord.dart';

class DetailPressureRecordPage extends StatefulWidget {
  final int systolicBloodPressure;
  final int diastolicBloodPressure;
  final int pulseRate;
  final String timestamp;

  const DetailPressureRecordPage(
      {super.key,
      required this.systolicBloodPressure,
      required this.diastolicBloodPressure,
      required this.pulseRate,
      required this.timestamp});

  @override
  State<DetailPressureRecordPage> createState() =>
      _DetailPressureRecordPageState();
}

class _DetailPressureRecordPageState extends State<DetailPressureRecordPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.systolicBloodPressure);
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 58,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AllPressureRecordPage()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(hexColor('#484554')),
                    size: 24,
                  ),
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
                SizedBox(
                  width: 24,
                )
              ]),
              SizedBox(
                height: 25,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ความดันโลหิต',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.timestamp,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Color(hexColor('#7B7B7B')),
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ช่วงหัวใจบีบตัว (ตัวบน)',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: 130,
                          alignment: Alignment.centerRight,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color(hexColor('#E9E9E9')))),
                          child: Text(
                            '${widget.systolicBloodPressure} mmHg',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#484554')),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ช่วงหัวใจบีบตัว (ตัวล่าง)',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: 130,
                          alignment: Alignment.centerRight,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color(hexColor('#E9E9E9')))),
                          child: Text(
                            '${widget.diastolicBloodPressure} mmHg',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#484554')),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'อัตราการเต้นของหัวใจ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Container(
                          width: 130,
                          alignment: Alignment.centerRight,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color(hexColor('#E9E9E9')))),
                          child: Text(
                            '${widget.pulseRate} ครั้ง/นาที',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'IBMPlexSansThai',
                              color: Color(hexColor('#484554')),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
