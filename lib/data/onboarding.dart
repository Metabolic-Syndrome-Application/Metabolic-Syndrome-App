import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';

class OnbordingContent {
  String image;
  String title;
  String discription;
  Color backgroundColor;
  String titleButton;
  OnbordingContent({
    required this.image,
    required this.title,
    required this.discription,
    required this.backgroundColor,
    required this.titleButton,
  });
}

// Created By Flutter Baba
List<OnbordingContent> contentsList = [
  OnbordingContent(
      backgroundColor: Color(hexColor('#6D81E9')),
      title: "แผนสุขภาพ\nเฉพาะบุคคล",
      image: 'assets/images/healthPlanPage.png',
      discription:
          "วิเคราะห์ความเสี่ยงเเละติดตามผลสุขภาพในเเบบของคุณรวมถึงเเนะนำขั้นตอนการปรับเปลี่ยนพฤติกรรมที่เกิดจากภาวะเมตาบอลิกซินโดรม",
      titleButton: "ถัดไป"),
  OnbordingContent(
      backgroundColor: Color(hexColor('#42884B')),
      title: "บันทึกประจำวัน\n",
      image: 'assets/images/healthNotePage.png',
      discription:
          "สามารถจดบันทึกค่าสุขภาพในเเต่ละวันได้พร้อมทั้งติดตามเเนวโน้มสุขภาพของคุณรวมถึงการเเจ้งเตือนสำคัญต่างๆ ที่ต้องทำ",
      titleButton: "ถัดไป"),
  OnbordingContent(
      backgroundColor: Color(hexColor('#F94B4B')),
      title: "ความรู้เเละความท้าทาย \n",
      image: 'assets/images/knowledgeChallenge.png',
      discription:
          "ช่วยให้ความรู้เเละความเข้าใจเกี่ยวกับภาวะเมตาบอลิกซินโดรม เเถมยังเพลิดเพลินกับกิจกรรมความท้าทายภายในเเอปพลิเคชัน",
      titleButton: "เริ่มใช้งานกันเลย !"),
];
