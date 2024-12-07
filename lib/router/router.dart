import 'package:arch/features/basket/view/basket_screen.dart';
import 'package:arch/features/catalog/view/catalog_screen.dart';
import 'package:arch/features/home/view/home_screen.dart';
import 'package:arch/features/main/view/main_screen.dart';
import 'package:arch/features/profile/view/profile_screen.dart';
import 'package:auto_route/auto_route.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/', children: [
          AutoRoute(
            page: MainScreenRoute.page,
            path: 'main',
          ),
          AutoRoute(
            page: CatalogRoute.page,
            path: 'catalog',
          ),
          AutoRoute(
            page: BasketRoute.page,
            path: 'basket',
          ),
          AutoRoute(
            page: ProfileRoute.page,
            path: 'profile',
          ),
        ]),
      ];
}
