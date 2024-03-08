import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/calendar.dart/calendar.dart';
import 'package:flutter_svg/svg.dart';

import '../../extension/Color.dart';

class PlanDetail extends StatefulWidget {
  final String planId;
  final String name;
  final String type;
  final String description;
  final String photo;
  const PlanDetail(
      {required this.planId,
      super.key,
      required this.name,
      required this.photo,
      required this.type,
      required this.description});

  @override
  State<PlanDetail> createState() => _PlanDetailState();
}

class _PlanDetailState extends State<PlanDetail> {
  // String plan = '';
  // String name = '';
  // String description = '';
  // Map<String, dynamic> jsonMap = {};

  // Future<void> fetchPlanDetail(String planId) async {
  //   try {
  //     String? token = Provider.of<AuthProvider>(context, listen: false).token;
  //     Map<String, dynamic> response = await getPlanById(token!, planId);
  //     setState(() {
  //       name = response['data']['plan']['name'];
  //       description = response['data']['plan']['description'];
  //       jsonMap = convertHtmlToJson(description);
  //     });
  //   } catch (e) {
  //     // print('Error fetching plan: $e');
  //   }
  // }

  Map<String, dynamic> convertHtmlToJson(String html) {
    var categories = <String, List<String>>{};

    var parts = html.split('<hr>');
    for (var part in parts) {
      var titleStart = part.indexOf('<p>');
      var titleEnd = part.indexOf('</p>');
      var title = part.substring(titleStart + 3, titleEnd).trim();

      var itemsStart = part.indexOf('<ul>');
      var itemsEnd = part.indexOf('</ul>', itemsStart);
      var itemsContent = part.substring(itemsStart + 4, itemsEnd).trim();

      var itemMatches =
          RegExp('<li>(.*?)</li>', dotAll: true).allMatches(itemsContent);

      var items = itemMatches.map((m) {
        var content = m
            .group(1)!
            .replaceAll(RegExp('<p>|</p>|<blockquote>|</blockquote>'), '')
            .trim();
        content = content.replaceAll(RegExp(' +'), ' ');
        return content;
      }).toList();

      categories[title] = items;
    }

    return categories;
  }

  Widget cardComponent(String key, List<dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.only(bottom: 22),
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
              const SizedBox(
                width: 10,
              ),
              Text(
                key,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: item.length,
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: CircleAvatar(
                      radius: 2,
                      backgroundColor: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      item[index],
                      style: const TextStyle(
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
    // fetchPlanDetail(widget.planId);
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> jsonMap = convertHtmlToJson(widget.description);

    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 44, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
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
                                    builder: (context) =>
                                        const CalendarPage()));
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 21,
                          ),
                        ),
                        SvgPicture.network(
                          height: 110,
                          widget.photo,
                          semanticsLabel: 'A shark?!',
                          placeholderBuilder: (BuildContext context) =>
                              Container(
                                  padding: const EdgeInsets.all(30.0),
                                  child: const CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          width: 21,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 29,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     //
                  //   },
                  //   child: Icon(
                  //     Icons.notifications,
                  //     color: Color(hexColor('#FFC556')),
                  //     size: 30,
                  //   ),
                  // )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.monetization_on_outlined,
                    color: Color(hexColor('#484554')),
                    size: 16,
                  ),
                  const SizedBox(width: 10),
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
              const SizedBox(
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
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 23, bottom: 23),
                decoration: BoxDecoration(
                    color: Color(hexColor('#F2F2F2')),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'IBMPlexSansThai',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ListView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: jsonMap.keys.length,
              //   itemBuilder: (context, index) {
              //     String key = jsonMap.keys.elementAt(index);
              //     List<dynamic> items = jsonMap[key];
              //     return cardComponent(key, items);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
