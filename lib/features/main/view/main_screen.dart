import 'package:arch/application/bloc/main_screen/main_screen_bloc.dart';
import 'package:arch/application/repositories/main_screen/main_screen_repository.dart';
import 'package:arch/application/repositories/main_screen/products_categories_repository.dart';
import 'package:arch/features/main/view/products_categories.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = MainScreenRepository();

    return BlocProvider(
      create: (context) => MainScreenBloc(repository),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          toolbarHeight: 140,
          title: const _AppBarColumn(),
        ),
        body: BlocBuilder<MainScreenBloc, MainScreenState>(
          builder: (context, state) {
            context.read<MainScreenBloc>().add(LoadItemsList());
            if (state is ItemsLoaded) {
              List<Map<String, String>> itemsList = state.itemsList.map((item) {
                return {
                  'name': item.name,
                  'image': item.image,
                };
              }).toList();

              return SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MainContainer(),
                      Categories(items: itemsList),
                    ],
                  ),
                ),
              );
            }

            return const Center(
                child: CircularProgressIndicator(
              color: Colors.lightBlue,
            ));
          },
        ),
      ),
    );
  }
}

class _AppBarColumn extends StatelessWidget {
  const _AppBarColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Image(
              image: AssetImage('assets/images/medtehicon.png'),
              width: 35,
              height: 35,
            ),
            SizedBox(width: 8),
            Text(
              'Medtehnika - path to health',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Поиск',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search, color: Colors.black),
              suffixIcon: const Icon(Icons.qr_code),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(15),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
          ),
        ),
      ],
    );
  }
}

class Categories extends StatelessWidget {
  final List<Map<String, String>> items;

  const Categories({super.key, required this.items});
  Future<void> saveIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selected_index', index);
  }

  @override
  Widget build(BuildContext context) {
    final repository = ProductsCategoriesRepository();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderWidget(),
          const SizedBox(height: 8),
          HorizontalScrollWidget(
            items: items,
            onItemTap: (index) async {
              await saveIndex(index);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsCategoriesPage(
                      productsCategoriesRepository: repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          const SectionTitle(title: 'Ходунки'),
          HorizontalScrollWidget(
            items: items,
            onItemTap: (index) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>  ProductsCategoriesPage(productsCategoriesRepository: repository),
              //   ),
              // );
            },
          ),
          const SectionTitle(title: 'Ингаляторы'),
          StaticHorizontalScrollWidget(
            itemCount: 5,
            itemBuilder: (index) => CategoryItem(
              icon: Icons.title,
              text: 'Категория ${index + 1}',
            ),
          ),
          const SectionTitle(title: 'Тонометры'),
          StaticHorizontalScrollWidget(
            itemCount: 5,
            itemBuilder: (index) => CategoryItem(
              icon: Icons.title,
              text: 'Категория ${index + 1}',
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Категории',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class HorizontalScrollWidget extends StatelessWidget {
  final List<Map<String, String>> items;
  final void Function(int index) onItemTap;

  const HorizontalScrollWidget({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onItemTap(index),
            child: CategoryItem(
              imagePath: items[index]['image'],
              text: items[index]['name']!,
            ),
          );
        },
      ),
    );
  }
}

class StaticHorizontalScrollWidget extends StatelessWidget {
  final int itemCount;
  final Widget Function(int index) itemBuilder;

  const StaticHorizontalScrollWidget({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) => itemBuilder(index),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String? imagePath;
  final String text;
  final IconData? icon;

  const CategoryItem({
    super.key,
    this.imagePath,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(169, 169, 169, 0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          if (imagePath != null)
            Image.asset(
              imagePath!,
              width: 120,
              height: 120,
            )
          else if (icon != null)
            Icon(icon, size: 75),
          const SizedBox(height: 2),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(169, 169, 169, 0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: IconTextItem(
                    icon: Icons.discount_sharp,
                    text: 'Дисконт',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: IconTextItem(
                    icon: Icons.store_mall_directory,
                    text: 'Каталог',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: IconTextItem(
                    icon: Icons.more_horiz,
                    text: 'Больше',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IconTextItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconTextItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 35),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
