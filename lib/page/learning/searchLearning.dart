import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/widget/learning/learningCard.dart';

import '../../extension/Color.dart';

class SearchingLearning extends StatefulWidget {
  const SearchingLearning({super.key});

  @override
  State<SearchingLearning> createState() => _SearchingLearningState();
}

class _SearchingLearningState extends State<SearchingLearning> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: Padding(
        padding: EdgeInsets.only(top: 58, left: 20, right: 20),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(hexColor('#484554')),
                  size: 24,
                ),
              ),
              Text(
                'ความรู้',
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
              height: 35,
            ),
            Container(
                height: 35,
                // Add padding around the search bar
                alignment: Alignment.center,
                // Use a Material design search bar
                child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: 'IBMPlexSansThai',
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    hintText: 'ค้นหาโรคหรืออาการ',
                    // Add a search icon or button to the search bar
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 20,
                      ),
                      onPressed: () {
                        // Perform the search here
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            ArticleCard()
          ],
        ),
      ),
    );
  }
}
