import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/learning/searchLearning.dart';
import 'package:flutter_application_1/widget/learning/allArticle.dart';
import 'package:flutter_application_1/widget/learning/behavierArticle.dart';
import 'package:flutter_application_1/widget/learning/foodArticle.dart';
import 'package:flutter_application_1/widget/learning/medicineArticle.dart';

import '../../extension/Color.dart';

class MainLearning extends StatelessWidget {
  const MainLearning({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Learning Page',
      home: MainLearningPage(),
    );
  }
}

class MainLearningPage extends StatefulWidget {
  const MainLearningPage({super.key});

  @override
  State<MainLearningPage> createState() => _MainLearningPageState();
}

class _MainLearningPageState extends State<MainLearningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: <Widget>[
              SizedBox(
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
                                  builder: (context) => SearchingLearning()));
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(hexColor('#484554')),
                          size: 24,
                        ),
                      ),
                      Text(
                        'โรคอ้วน',
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
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ButtonsTabBar(
                  height: 32,
                  buttonMargin: EdgeInsets.symmetric(horizontal: 5),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  borderColor: Color(hexColor('#2F4EF1')),
                  backgroundColor: Color(hexColor('#2F4EF1')),
                  unselectedBackgroundColor: Colors.white,
                  labelStyle: TextStyle(
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
                    AllArticle(),
                    FoodArticle(),
                    MedicineArticle(),
                    BehavierArticle(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
