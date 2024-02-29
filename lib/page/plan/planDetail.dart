import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/calendar.dart/calendar.dart';
import 'package:flutter_application_1/response/api.dart';
import 'package:provider/provider.dart';

import '../../extension/Color.dart';

class PlanDetail extends StatefulWidget {
  final String planId;
  const PlanDetail({required this.planId, super.key});

  @override
  State<PlanDetail> createState() => _PlanDetailState();
}

class _PlanDetailState extends State<PlanDetail> {
  String plan = '';
  String name = '';
  Map<String, dynamic> response = {};
  Future<void> fetchAndPrintPlan(String planId) async {
    try {
      String? token = Provider.of<AuthProvider>(context, listen: false).token;
      response = await getPlanById(token!, planId);
      setState(() {});
      name = response['data']['plan']['name'];
    } catch (e) {
      // print('Error fetching plan: $e');
    }
  }

  String htmlContent = """
<p>อาหารเเละโภชนาการ</p>
<ul>
    <li><p>จดบันทึกการกินอาหารภายใน 1 วัน</p></li>
    <li><p>ปริมาณเเคลอรี่อาหารในเเต่ละหมวดที่ต้องการน้ำหนัก</p></li>
    <li><p>วิธีการเลือกอาหารโซนสีเพื่อลดน้ำหนัก คือ โซนสีเขียว โซนสีเหลือง โซนสีเเดง</p></li>
    <li><p>เทคนิคการลด หวาน มัน เค็ม</p></li>
    <li><p>แนะนำการเพิ่มการมีกิจกรรมทางกายในชีวิตประจำวัน / พลังงานที่ใช้ไป</p></li>
</ul>
<hr>
<p>การออกกำลังกาย</p>
<ul>
    <li><p>ประเภทของการออกกำลังกาย </p></li>
    <li><p>หลักของการออกกำลังกาย (FITT : ความบ่อย, ความหนัก / เหนื่อย, ความนาน และชนิด / ประเภทกิจกรรม) </p></li>
    <li>
        <p>ขั้นตอนการออกกำลังกาย 3 ขั้นตอน ได้แก่</p>
        <blockquote><p>1. อบอุ่นร่างกาย </p></blockquote>
        <p>2. ออกกำลังกาย </p>
        <blockquote><p>3. การคลายอุ่น / คูลดาวน์ </p></blockquote>
    </li>
</ul>
""";

  Map<String, dynamic> convertHtmlToJson(String html) {
    var categories = <String, List<String>>{};

    // Splitting the HTML content by '<hr>' to separate categories.
    var parts = html.split('<hr>');
    for (var part in parts) {
      // Finding the title by locating the first '<p>' and the following '</p>'
      var titleStart = part.indexOf('<p>');
      var titleEnd = part.indexOf('</p>');
      var title = part.substring(titleStart + 3, titleEnd).trim();

      // Extracting the content of each <ul> block
      var itemsStart = part.indexOf('<ul>');
      var itemsEnd = part.indexOf('</ul>', itemsStart);
      var itemsContent = part.substring(itemsStart + 4, itemsEnd).trim();

      // Adjusting the RegExp to handle more complex structures within <li> tags
      var itemMatches =
          RegExp('<li>(.*?)</li>', dotAll: true).allMatches(itemsContent);

      var items = itemMatches.map((m) {
        // Removing <p> tags and capturing the inner content accurately
        var content = m
            .group(1)!
            .replaceAll(RegExp('<p>|</p>|<blockquote>|</blockquote>'), '')
            .trim();
        // Replacing multiple spaces (if any) with a single space for cleanliness
        content = content.replaceAll(RegExp(' +'), ' ');
        return content;
      }).toList();

      categories[title] = items;
    }

    return categories;
  }

  Widget cardComponent(String key, List<dynamic> item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            blurRadius: 4.0,
            spreadRadius: .1,
            offset: const Offset(
              0.0,
              4.0,
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                key == "อาหารและโภชนาการ"
                    ? "assets/images/food_note_icon.png"
                    : key == "การออกกำลังกาย"
                        ? "assets/images/exercise_note_icon.png"
                        : "assets/images/food_note_icon.png",
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                key,
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: [item].length,
            itemBuilder: (context, index) {
              return Row(
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
              ); // Return an empty SizedBox if the condition is not met
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: item.length,
            itemBuilder: (context, index) {
              return Row(
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
                      item[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      fetchAndPrintPlan(widget.planId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var jsonMap = convertHtmlToJson(response['data']['plan']['description']);
    //var jsonString = jsonEncode(jsonMap);

    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 44, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CalendarPage()));
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
                    name,
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
                    "100 coins",
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
              // Row(
              //   children: [
              //     Icon(
              //       Icons.access_time_outlined,
              //       color: Color(hexColor('#484554')),
              //       size: 16,
              //     ),
              //     SizedBox(width: 10),
              //     Text(
              //       "1 สัปดาห์",
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontFamily: 'IBMPlexSansThai',
              //         color: Color(hexColor('#484554')),
              //         fontWeight: FontWeight.normal,
              //       ),
              //       textAlign: TextAlign.left,
              //     )
              //   ],
              // ),
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: jsonMap.keys.length,
                itemBuilder: (context, index) {
                  String key = jsonMap.keys.elementAt(index);
                  List<dynamic> items = jsonMap[key];
                  return cardComponent(key, items);
                  // return ExpansionTile(
                  //   title: Text(key,
                  //       style: TextStyle(
                  //           fontSize: 20, fontWeight: FontWeight.bold)),
                  //   children: items
                  //       .map<Widget>((item) => ListTile(title: Text(item)))
                  //       .toList(),
                  // );
                },
              ),
              SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      ),
    );
  }
}
