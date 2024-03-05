import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/routes/app_router.gr.dart';

@RoutePage()
class MainScene extends StatelessWidget {
  const MainScene({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        HomeRoute(),
        CalendarRoute(),
        SelectedDate(selectedDate: DateTime.now(), hasPlan: true),
        AllChallenge(),
        Profile()
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
            body: child,
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
              selectedItemColor: Color(hexColor('#1438F3')),
              unselectedItemColor: Color(hexColor('#000000')),
              currentIndex: tabsRouter.activeIndex,
              onTap: (value) {
                tabsRouter.setActiveIndex(value);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/home_navbar.png'),
                    activeIcon:
                        Image.asset('assets/images/home_navbar_active.png'),
                    label: "หน้าหลัก"),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/calendar_navbar.png'),
                    activeIcon:
                        Image.asset('assets/images/calendar_navbar_active.png'),
                    label: "ปฏิทิน"),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/note_navbar.png'),
                    activeIcon:
                        Image.asset('assets/images/note_navbar_active.png'),
                    label: "บันทึก"),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/challenge_navbar.png'),
                    activeIcon: Image.asset(
                        'assets/images/challenge_navbar_active.png'),
                    label: "ท้าดวล"),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/profile_navbar.png'),
                    activeIcon:
                        Image.asset('assets/images/profile_navbar_active.png'),
                    label: "โปรไฟล์")
              ],
            ));
      },
    );
  }
}
