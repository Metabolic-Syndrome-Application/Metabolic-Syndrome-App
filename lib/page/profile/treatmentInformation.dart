import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/profile/profile.dart';

import '../../extension/Color.dart';

class TreatmentInformation extends StatelessWidget {
  const TreatmentInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TreatmentInformationPage(),
    );
  }
}

class TreatmentInformationPage extends StatefulWidget {
  const TreatmentInformationPage({super.key});

  @override
  State<TreatmentInformationPage> createState() =>
      _TreatmentInformationPageState();
}

class _TreatmentInformationPageState extends State<TreatmentInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(hexColor('#484554')),
                    size: 24,
                  ),
                ),
                Text(
                  'ข้อมูลการรักษา',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  width: 24,
                )
              ]),
              SizedBox(
                height: 53,
              ),
              Text(
                'เเพทย์ผู้รักษา',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border:
                      Border.all(width: 1, color: Color(hexColor('#E9E9E9'))),
                ),
                child: Text(
                  'นายเเพทย์สมรักษ์ คำดี',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'อาการของคนไข้',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                height: 47,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border:
                      Border.all(width: 1, color: Color(hexColor('#E9E9E9'))),
                ),
                child: Text(
                  'ความดันโลหิตสูง',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
