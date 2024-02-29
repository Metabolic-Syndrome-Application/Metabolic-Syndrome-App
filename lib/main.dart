import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/loginRegister/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'extension/Color.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  initializeDateFormatting().then((_) => runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider(), child: MyApp())));

  // runApp(ChangeNotifierProvider(
  //     create: (context) => AuthProvider(), child: MyApp()));
}

//สร้าง Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //navigatorKey: navigatorKey,
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
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _currentIndex = 0;
  // final List _children = [
  //   const Home(),
  //   const Calendar(),
  //   const TodayNote(),
  //   const AllChallenge(),
  //   const Profile()
  // ];

  // void onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#FAFCFB')),
      body: const LoginPage(),
      // body: _children[_currentIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: onTabTapped,
      //   currentIndex: _currentIndex,
      //   items: [
      //     new BottomNavigationBarItem(
      //         backgroundColor: Color(hexColor('#1438F3')),
      //         icon: Icon(Icons.home),
      //         label: 'หน้าหลัก'),
      //     new BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'ปฏิทิน'),
      //     new BottomNavigationBarItem(
      //         icon: Icon(Icons.person), label: 'บันทึก'),
      //     new BottomNavigationBarItem(
      //         icon: Icon(Icons.battery_alert_outlined), label: 'ท้าดวล'),
      //     new BottomNavigationBarItem(
      //         icon: Icon(Icons.person), label: 'โปรไฟล์'),
      //   ],
      // ),
    );
  }
}
