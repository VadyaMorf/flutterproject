import 'package:arch/features/main/view/main_screen.dart';
import 'package:arch/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        MainScreenRoute(),
        CatalogRoute(),
        BasketRoute(),
        ProfileRoute()
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index)=>_openPage(index, tabsRouter),
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Главная'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_input_component_sharp), label: 'Каталог'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'Корзина'),
              BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Профиль'),
            ],
          ),
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}