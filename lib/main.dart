import 'package:flutter/material.dart';
import 'package:flutter_application_1/authProvider.dart';
import 'package:flutter_application_1/page/loginRegister/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'extension/Color.dart';

void main() {
  //await dotenv.load(fileName: ".env");
  // initializeDateFormatting().then((_) => runApp(MyApp()));

  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider(), child: MyApp()));
}

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// final navigatorKey = GlobalKey<NavigatorState>();

//สร้าง Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      body: LoginPage(),
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
