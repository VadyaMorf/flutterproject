part of 'products_categories_bloc.dart';

abstract class ProductsCategoriesState {}

class ProductsCategoriesInitial extends ProductsCategoriesState {}

class ProductsListLoading extends ProductsCategoriesState {}

class ProductsListLoaded extends ProductsCategoriesState {
  ProductsListLoaded({required this.productList, required this.categoriesList});
  final List<Product> productList;
  final List<Map<String, String>> categoriesList;
}

class IconToggled extends ProductsCategoriesState {
  final bool isFirstImageSelected;
  final bool isSecondImageSelected;
  IconToggled(
      {required this.isFirstImageSelected,
      required this.isSecondImageSelected});
}
