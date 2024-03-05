import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/learning/searchLearning.dart';
import 'package:flutter_application_1/widget/learning/allArticle.dart';

import '../../extension/Color.dart';

class MainLearning extends StatefulWidget {
  // final String disease;
  final String photo;
  final String name;
  final String details;
  final String symptoms;
  final String medications;
  final String behaviors;
  const MainLearning({
    super.key,
    required this.photo,
    required this.name,
    required this.details,
    required this.symptoms,
    required this.medications,
    required this.behaviors,
  });

  @override
  State<MainLearning> createState() => _MainLearningState();
}

class _MainLearningState extends State<MainLearning> {
  @override
  void initState() {
    // fetchKnowledge(widget.disease);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 58,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SearchingLearning()));
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(hexColor('#484554')),
                        size: 24,
                      ),
                    ),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'IBMPlexSansThai',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    )
                  ]),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonsTabBar(
                height: 32,
                buttonMargin: const EdgeInsets.symmetric(horizontal: 5),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                borderColor: Color(hexColor('#2F4EF1')),
                backgroundColor: Color(hexColor('#2F4EF1')),
                unselectedBackgroundColor: Colors.white,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBMPlexSansThai',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                borderWidth: 1,
                unselectedBorderColor: Color(hexColor('#DBDBDB')),
                radius: 100,
                tabs: [
                  Tab(
                    text: "ทั้งหมด",
                  ),
                  Tab(
                    text: "โรคเเละอาการ",
                  ),
                  Tab(
                    text: "ยา",
                  ),
                  Tab(
                    text: "การปรับพฤติกรรม",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  AllArticle(
                    photo: widget.photo,
                    name: widget.name,
                    details: widget.details,
                    symptoms: widget.symptoms,
                    medications: widget.medications,
                    behaviors: widget.behaviors,
                  ),
                  AllArticle(
                    photo: widget.photo,
                    name: widget.name,
                    details: widget.details,
                    symptoms: widget.symptoms,
                  ),
                  AllArticle(
                    photo: widget.photo,
                    medications: widget.medications,
                  ),
                  AllArticle(
                    photo: widget.photo,
                    behaviors: widget.behaviors,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
