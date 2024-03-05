// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:flutter_application_1/page/calendar.dart/calendar.dart' as _i2;
import 'package:flutter_application_1/page/calendar.dart/selectCalendar.dart'
    as _i7;
import 'package:flutter_application_1/page/challenge/allChallenge.dart' as _i1;
import 'package:flutter_application_1/page/home/home.dart' as _i3;
import 'package:flutter_application_1/page/homeSceening.dart' as _i4;
import 'package:flutter_application_1/page/mainSceening.dart' as _i5;
import 'package:flutter_application_1/page/profile/profile.dart' as _i6;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AllChallenge.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AllChallenge(),
      );
    },
    CalendarRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CalendarPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    HomeSceen.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomeSceen(),
      );
    },
    MainScene.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MainScene(),
      );
    },
    Profile.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.Profile(),
      );
    },
    SelectedDate.name: (routeData) {
      final args = routeData.argsAs<SelectedDateArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SelectedDate(
          args.selectedDate,
          args.hasPlan,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AllChallenge]
class AllChallenge extends _i8.PageRouteInfo<void> {
  const AllChallenge({List<_i8.PageRouteInfo>? children})
      : super(
          AllChallenge.name,
          initialChildren: children,
        );

  static const String name = 'AllChallenge';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CalendarPage]
class CalendarRoute extends _i8.PageRouteInfo<void> {
  const CalendarRoute({List<_i8.PageRouteInfo>? children})
      : super(
          CalendarRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomeSceen]
class HomeSceen extends _i8.PageRouteInfo<void> {
  const HomeSceen({List<_i8.PageRouteInfo>? children})
      : super(
          HomeSceen.name,
          initialChildren: children,
        );

  static const String name = 'HomeSceen';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.MainScene]
class MainScene extends _i8.PageRouteInfo<void> {
  const MainScene({List<_i8.PageRouteInfo>? children})
      : super(
          MainScene.name,
          initialChildren: children,
        );

  static const String name = 'MainScene';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.Profile]
class Profile extends _i8.PageRouteInfo<void> {
  const Profile({List<_i8.PageRouteInfo>? children})
      : super(
          Profile.name,
          initialChildren: children,
        );

  static const String name = 'Profile';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SelectedDate]
class SelectedDate extends _i8.PageRouteInfo<SelectedDateArgs> {
  SelectedDate({
    required DateTime selectedDate,
    required bool hasPlan,
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          SelectedDate.name,
          args: SelectedDateArgs(
            selectedDate: selectedDate,
            hasPlan: hasPlan,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectedDate';

  static const _i8.PageInfo<SelectedDateArgs> page =
      _i8.PageInfo<SelectedDateArgs>(name);
}

class SelectedDateArgs {
  const SelectedDateArgs({
    required this.selectedDate,
    required this.hasPlan,
    this.key,
  });

  final DateTime selectedDate;

  final bool hasPlan;

  final _i9.Key? key;

  @override
  String toString() {
    return 'SelectedDateArgs{selectedDate: $selectedDate, hasPlan: $hasPlan, key: $key}';
  }
}
