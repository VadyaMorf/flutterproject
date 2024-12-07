import 'package:arch/application/bloc/products_categories/products_categories_bloc.dart';
import 'package:arch/application/model/product.dart';
import 'package:arch/application/repositories/main_screen/products_categories_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCategoriesPage extends StatelessWidget {
  final ProductsCategoriesRepository productsCategoriesRepository;

  const ProductsCategoriesPage({
    super.key,
    required this.productsCategoriesRepository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCategoriesBloc(productsCategoriesRepository)
        ..add(LoadProductsList()),
      child: const ProductsCategoriesView(),
    );
  }
}

class ProductsCategoriesView extends StatefulWidget {
  const ProductsCategoriesView({super.key});
  @override
  _ProductsCategoriesViewState createState() => _ProductsCategoriesViewState();
}

class _ProductsCategoriesViewState extends State<ProductsCategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductsCategoriesBloc, ProductsCategoriesState>(
        builder: (context, state) {
          if (state is ProductsListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsListLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.lightBlue,
                  pinned: false,
                  floating: true,
                  snap: true,
                  expandedHeight: 40,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.chevron_left,
                              size: 35, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Главная",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    background: Container(color: Colors.lightBlue),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: _searchWidget(),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: _rowWidget(),
                      ),
                      if (state.categoriesList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                          child: _listWidget(
                              items: state.categoriesList.take(5).toList()),
                        ),
                      const SizedBox(height: 8),
                      const Divider(),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 16),
                      //   child: _imagesRowWidget(
                      //     isFirstImageSelected: false,
                      //     isSecondImageActive: false,
                      //     onFirstImageTap: () => context
                      //         .read<ProductsCategoriesBloc>()
                      //         .add(SelectFirstImage()),
                      //     onSecondImageTap: () => context
                      //         .read<ProductsCategoriesBloc>()
                      //         .add(SelectSecondImage()),
                      //   ),
                      // ),
                      const Divider(),
                      Column(
                        children: [
                          // if (state is ImageSelectionChanged && state.isSecondImageActive)
                          _listViewResponseItemsWidget(
                              responseItems: state.productList),
                          // if (state is ImageSelectionChanged && state.isFirstImageSelected)
                          //    _gridViewResponseItemsWidget(responseItems: state.filteredProducts),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _gridViewResponseItemsWidget extends StatelessWidget {
  const _gridViewResponseItemsWidget({
    super.key,
    required this.responseItems,
  });

  final List<Product> responseItems;
  Future<void> navigateToProductInfo(BuildContext context, String id) async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ChangeNotifierProvider(
    //       create: (_) => ProductsCategoriesViewModel(),
    //       child: ProductsInfoScreen(id: id),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2 / 4),
        itemCount: responseItems.length,
        itemBuilder: (context, index) {
          final item = responseItems[index];
          return GestureDetector(
            onTap: () {
              navigateToProductInfo(context, item.id);
            },
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(bottom: 8),
              elevation: 4,
              child: SizedBox(
                width: double.infinity,
                height: 240,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(item.imageLink,
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.contain)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              maxLines: 3,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            Text(item.brand,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            const Spacer(),
                            Text(
                              '${item.price} грн.',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            if (item.availability == "out of stock")
                              const Text(
                                "Немає в наявності",
                                style: TextStyle(color: Colors.red),
                              )
                            else
                              const Text("В наявності",
                                  style: TextStyle(color: Colors.green)),
                            const SizedBox(height: 4),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 54),
                              ),
                              child: const Text(
                                "Купити",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _listViewResponseItemsWidget extends StatelessWidget {
  const _listViewResponseItemsWidget({
    super.key,
    required this.responseItems,
  });

  final List<Product> responseItems;
  Future<void> navigateToProductInfo(BuildContext context, String id) async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ChangeNotifierProvider(
    //       create: (_) => ProductsCategoriesViewModel(),
    //       child: ProductsInfoScreen(id: id),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return responseItems.isEmpty
        ? const Center(
            child: Text(
            "Ничего не найдено",
            style: TextStyle(fontSize: 18),
          ))
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: responseItems.length,
            itemBuilder: (context, index) {
              final item = responseItems[index];
              return GestureDetector(
                onTap: () {
                  navigateToProductInfo(context, item.id);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 4,
                    child: SizedBox(
                      height: 220,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(item.imageLink,
                                      width: 140,
                                      height: 140,
                                      fit: BoxFit.contain)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(item.brand,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                  const Spacer(),
                                  Text(
                                    '${item.price} грн.',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (item.availability == "out of stock")
                                    const Text(
                                      "Нет наличии",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  else
                                    const Text("В наличии",
                                        style: TextStyle(color: Colors.green)),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 64),
                                    ),
                                    child: const Text(
                                      "Купить",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class _listWidget extends StatelessWidget {
  const _listWidget({
    super.key,
    required this.items,
  });

  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: List.generate(items.length, (index) {
          return Container(
            width: 112,
            height: 118,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Image(
                    image: AssetImage(items[index]['image']!),
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain),
                const SizedBox(height: 0),
                Center(
                    child: Text(
                  items[index]['name']!,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 14),
                )),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _rowWidget extends StatelessWidget {
  const _rowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "Тонометрі",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _searchWidget extends StatelessWidget {
  const _searchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final vm = context.watch<ProductsCategoriesViewModel>();
    return TextField(
      // onChanged: (value){
      //   vm.searchProductByName(value);
      // },
      decoration: InputDecoration(
        fillColor: Colors.grey[30],
        filled: true,
        label: const Text('Пошук'),
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
    );
  }
}

class _imagesRowWidget extends StatelessWidget {
  final bool isFirstImageSelected;
  final bool isSecondImageActive;
  final VoidCallback onFirstImageTap;
  final VoidCallback onSecondImageTap;
  const _imagesRowWidget({
    super.key,
    required this.isFirstImageSelected,
    required this.isSecondImageActive,
    required this.onFirstImageTap,
    required this.onSecondImageTap,
  });

  @override
  Widget build(BuildContext context) {
    //final vm = context.watch<ProductsCategoriesViewModel>();
    return const Row(
      children: [
        Image(
            image: AssetImage('assets/images/picker_image.png'),
            width: 20,
            height: 20),
        // DropdownButton<String>(
        //   underline: const SizedBox(),
        //   icon: const SizedBox(),
        //   value: vm.selectedValue,
        //   hint: Text(vm.selectedValue ?? vm.pickerItems[0], style: TextStyle(fontSize: 14)),
        //   items: vm.pickerItems.map((String item) {
        //     return DropdownMenuItem<String>(
        //       value: item,
        //       child: Text(item),
        //     );
        //   }).toList(),
        //   onChanged: vm.changeSelectedValue
        // ),
        // GestureDetector(
        //   onTap: vm.selectFirstImage,
        //   child: Image.asset(
        //     vm.isFirstImageSelected ? 'assets/images/4cart_active.png' : 'assets/images/4cart.png',
        //     width: 30,
        //     height: 30,
        //   ),
        // ),
        // const SizedBox(width: 8),
        // GestureDetector(
        //   onTap: vm.selectSecondImage,
        //   child: Image.asset(
        //      vm.isSecondImageActive ? 'assets/images/2cart_active.png' : 'assets/images/2cart.png',
        //     width: 30,
        //     height: 30,
        //   ),
        // ),
        SizedBox(width: 32),
      ],
    );
  }
}
