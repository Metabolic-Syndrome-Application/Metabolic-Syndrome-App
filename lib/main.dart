import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/calendar.dart/calendar.dart';
import 'package:flutter_application_1/page/challenge/allChallenge.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/note/todayNote.dart';
import 'package:flutter_application_1/page/profile/profile.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

//สร้าง Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('th', 'TH'),
      ],
      locale: Locale('th', 'TH'),
      title: "My App",
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List _children = [
    const Home(),
    const Calendar(),
    const TodayNote(),
    const AllChallenge(),
    const Profile()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
              backgroundColor: Color(hexColor('#1438F3')),
              icon: Icon(Icons.home),
              label: 'หน้าหลัก'),
          new BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'ปฏิทิน'),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'บันทึก'),
          new BottomNavigationBarItem(
              icon: Icon(Icons.battery_alert_outlined), label: 'ท้าดวล'),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'โปรไฟล์'),
        ],
      ),
    );
  }
}
