import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/calendar.dart/calendar.dart';
import 'package:flutter_application_1/page/calendar.dart/selectCalendar.dart';
import 'package:flutter_application_1/page/challenge/allChallenge.dart';
import 'package:flutter_application_1/page/home/home.dart';
import 'package:flutter_application_1/page/profile/profile.dart';

class Navbar extends StatefulWidget {
  const Navbar({
    super.key,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
//   @override
//   Widget build(BuildContext context) {
//     AppRouter appRouter = AppRouter();
//     return MaterialApp.router(
//       routerConfig: appRouter.config(),
//     );
//   }
//   // late PageController _myPage;
//   // var selectedPage;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _myPage = PageController(initialPage: 0);
//   //   selectedPage = 0;
//   // }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //       body: PageView(
//   //         physics: NeverScrollableScrollPhysics(),
//   //         controller: _myPage,
//   //         children: <Widget>[
//   //           HomePage(),
//   //           CalendarPage(),
//   //           SelectedDate(DateTime.now(), true),
//   //           AllChallenge(),
//   //           Profile(),
//   //           Center(
//   //             child: Text("Another Page"),
//   //           ),
//   //           Center(
//   //               child: Column(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             children: <Widget>[
//   //               Text("Page 1"),
//   //               MaterialButton(
//   //                 onPressed: () {
//   //                   _myPage.jumpToPage(0);
//   //                   setState(() {
//   //                     selectedPage = 0;
//   //                   });
//   //                 },
//   //                 child: Text("Go to another page"),
//   //               )
//   //             ],
//   //           )),
//   //           Center(child: Text("Page 2")),
//   //           Center(child: Text("Page 3")),
//   //         ],
//   //       ),
//   //       bottomNavigationBar: BottomAppBar(
//   //         child: Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //           children: <Widget>[
//   //             IconButton(
//   //               icon: Icon(Icons.home),
//   //               color: selectedPage == 0 ? Colors.blue : Colors.grey,
//   //               onPressed: () {
//   //                 _myPage.jumpToPage(0);
//   //                 setState(() {
//   //                   selectedPage = 0;
//   //                 });
//   //               },
//   //             ),
//   //             IconButton(
//   //               icon: Icon(Icons.star),
//   //               color: selectedPage == 1 ? Colors.blue : Colors.grey,
//   //               onPressed: () {
//   //                 _myPage.jumpToPage(1);
//   //                 setState(() {
//   //                   selectedPage = 1;
//   //                 });
//   //               },
//   //             ),
//   //             IconButton(
//   //               icon: Icon(
//   //                 Icons.settings,
//   //               ),
//   //               color: selectedPage == 2 ? Colors.blue : Colors.grey,
//   //               onPressed: () {
//   //                 _myPage.jumpToPage(2);
//   //                 setState(() {
//   //                   selectedPage = 2;
//   //                 });
//   //               },
//   //             ),
//   //             IconButton(
//   //               icon: Icon(Icons.star),
//   //               color: selectedPage == 3 ? Colors.blue : Colors.grey,
//   //               onPressed: () {
//   //                 _myPage.jumpToPage(3);
//   //                 setState(() {
//   //                   selectedPage = 3;
//   //                 });
//   //               },
//   //             ),
//   //             IconButton(
//   //               icon: Icon(
//   //                 Icons.settings,
//   //               ),
//   //               color: selectedPage == 4 ? Colors.blue : Colors.grey,
//   //               onPressed: () {
//   //                 _myPage.jumpToPage(4);
//   //                 setState(() {
//   //                   selectedPage = 4;
//   //                 });
//   //               },
//   //             ),
//   //           ],
//   //         ),
//   //       ));
// }
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const CalendarPage(),
    SelectedDate(DateTime.now(), true),
    const AllChallenge(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 26,
        selectedLabelStyle: TextStyle(
          fontSize: 14,
          fontFamily: 'IBMPlexSansThai',
          color: Color(hexColor('#1438F3')),
          fontWeight: FontWeight.normal,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'IBMPlexSansThai',
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/home_navbar.png'),
            activeIcon: Image.asset('assets/images/home_navbar_active.png'),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/calendar_navbar.png'),
            activeIcon: Image.asset('assets/images/calendar_navbar_active.png'),
            label: 'ปฏิทิน',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/note_navbar.png'),
            activeIcon: Image.asset('assets/images/note_navbar_active.png'),
            label: 'บันทึก',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/challenge_navbar.png'),
            activeIcon:
                Image.asset('assets/images/challenge_navbar_active.png'),
            label: 'ท้าดวล',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/profile_navbar.png'),
            activeIcon: Image.asset('assets/images/profile_navbar_active.png'),
            label: 'โปรไฟล์',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(hexColor('#1438F3')),
        unselectedItemColor: Color(hexColor('#000000')),
        onTap: _onItemTapped,
      ),
    );
  }
}
