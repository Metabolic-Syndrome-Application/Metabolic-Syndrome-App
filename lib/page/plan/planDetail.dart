import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/home/home.dart';

import '../../extension/Color.dart';

class PlanDetail extends StatelessWidget {
  const PlanDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PlanDetailPage());
  }
}

class PlanDetailPage extends StatefulWidget {
  const PlanDetailPage({super.key});

  @override
  State<PlanDetailPage> createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 44, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(hexColor('#A6CFFF')),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Container(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 21,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 25, bottom: 25),
                        height: 123,
                        child: Image.asset('assets/images/login.png'),
                      ),
                      SizedBox(
                        width: 21,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 29,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'สัปดาห์เเห่งการลดน้ำหนัก',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'IBMPlexSansThai',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    //
                  },
                  child: Icon(
                    Icons.notifications,
                    color: Color(hexColor('#FFC556')),
                    size: 30,
                  ),
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.monetization_on_outlined,
                  color: Color(hexColor('#484554')),
                  size: 16,
                ),
                SizedBox(width: 10),
                Text(
                  "200 coins",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Color(hexColor('#484554')),
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time_outlined,
                  color: Color(hexColor('#484554')),
                  size: 16,
                ),
                SizedBox(width: 10),
                Text(
                  "1 สัปดาห์",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'IBMPlexSansThai',
                    color: Color(hexColor('#484554')),
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
            SizedBox(
              height: 42,
            ),
            Text(
              'รายละเอียด',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'IBMPlexSansThai',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.health_and_safety_outlined,
                        color: Color(hexColor('#FF8D6A')),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'เเบบประเมิน',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: CircleAvatar(
                          radius: 2,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'ทำเเบบประเมินพฤติกรรมการกินเเละออกกำลังกายทวากสวสวส',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.food_bank_outlined,
                        color: Color(hexColor('#42884B')),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'อาหารเเละโภชนาการ',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: CircleAvatar(
                          radius: 2,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'ทำเเบบประเมินพฤติกรรมการกินเเละออกกำลังกายทวากสวสวส',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.file_copy_rounded,
                        color: Color(hexColor('#7B7B7B')),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'เเนะนำเเนวทาง',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: CircleAvatar(
                          radius: 2,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'ทำเเบบประเมินพฤติกรรมการกินเเละออกกำลังกายทวากสวสวส',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'IBMPlexSansThai',
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
