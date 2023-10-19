import 'package:flutter/material.dart';

import '../../extension/Color.dart';
import '../../page/learning/mainLearning.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainLearning()));
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: 115,
                child: Image.asset('assets/images/exampleLearning.png'),
              ),
              SizedBox(
                width: 9,
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'โรคอ้วน',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'IBMPlexSansThai',
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Color(hexColor('#7B7B7B')),
                            ),
                          ],
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. ',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'IBMPlexSansThai',
                            color: Color(hexColor('#999999')),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
