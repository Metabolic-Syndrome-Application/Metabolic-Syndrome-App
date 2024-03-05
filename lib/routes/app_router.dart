import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainScene.page, initial: true, children: [
          AutoRoute(
              // page: HomeRoute.page,
              page: HomeSceen.page,
              children: [
                AutoRoute(page: HomeRoute.page, initial: true),
                AutoRoute(page: Profile.page),
                AutoRoute(page: SelectedDate.page,),
              ]),
          AutoRoute(page: CalendarRoute.page),
          AutoRoute(page: SelectedDate.page),
          AutoRoute(page: AllChallenge.page),
          AutoRoute(
            page: Profile.page,
          ),
        ]),
      ];
}
