import 'package:flutter/material.dart';

class MedicineArticle extends StatelessWidget {
  const MedicineArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.only(left: 12, right: 12, top: 25, bottom: 25),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 140,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: Image.asset('assets/images/exampleMainArticle.png')),
            SizedBox(
              height: 14,
            ),
            Text(
              'ยา',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'IBMPlexSansThai',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Lorem ipsum dolor sit amet consectetur. Fermentum tortor non metus odio purus aliquet ',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'IBMPlexSansThai',
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Text(
              'ลักษณะอาการ',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'IBMPlexSansThai',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Lorem ipsum dolor sit amet consectetur. Fermentum tortor non metus odio purus aliquet ',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'IBMPlexSansThai',
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Text(
              'ลักษณะอาการ',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'IBMPlexSansThai',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Lorem ipsum dolor sit amet consectetur. Fermentum tortor non metus odio purus aliquet ',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'IBMPlexSansThai',
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 22,
            ),
          ],
        ),
      ),
    );
  }
}
