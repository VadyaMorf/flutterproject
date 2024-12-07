part of 'products_categories_bloc.dart';

abstract class ProductsCategoriesEvent {}

class LoadProductsList extends ProductsCategoriesEvent {}

class LoadCategoriesList extends ProductsCategoriesEvent {}

class ToogleIcon extends ProductsCategoriesEvent {
  final bool isFirstImageSelected;
  final bool isSecondImageSelected;
  ToogleIcon(
      {required this.isFirstImageSelected,
      required this.isSecondImageSelected});
}
