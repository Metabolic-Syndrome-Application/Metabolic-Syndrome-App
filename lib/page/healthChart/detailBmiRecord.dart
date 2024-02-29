import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/healthChart/allBMIRecord.dart';
import 'package:flutter_application_1/page/healthChart/allPressureRecord.dart';

class DetailBmiRecordPage extends StatefulWidget {
  final double bmi;
  final int waistline;
  final String timestamp;

  const DetailBmiRecordPage(
      {super.key,
      required this.bmi,
      required this.waistline,
      required this.timestamp});

  @override
  State<DetailBmiRecordPage> createState() => _DetailBmiRecordPageState();
}

class _DetailBmiRecordPageState extends State<DetailBmiRecordPage> {
  @override
  Widget build(BuildContext context) {
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
                            builder: (context) => const AllBMIRecord()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(hexColor('#484554')),
                    size: 24,
                  ),
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
                          'ดัชนีมวลกาย',
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
                          'ค่าดัชนีมวลกาย (BMI)',
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
                            '${widget.bmi.toStringAsFixed(2)} mmHg',
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
                          'รอบเอว',
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
                            '${widget.waistline} นิ้ว',
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
