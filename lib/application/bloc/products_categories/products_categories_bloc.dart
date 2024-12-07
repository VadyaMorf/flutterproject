import 'package:arch/application/model/product.dart';
import 'package:arch/application/repositories/main_screen/products_categories_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_categories_state.dart';
part 'products_categpries_event.dart';

class ProductsCategoriesBloc
    extends Bloc<ProductsCategoriesEvent, ProductsCategoriesState> {
  final ProductsCategoriesRepository repository;
  bool isFirstImageSelected = true;
  bool isSecondImageSelected = false;
  ProductsCategoriesBloc(this.repository) : super(ProductsCategoriesInitial()) {
    on<LoadProductsList>((event, emit) async {
      final responseItems = await repository.getAllProducts();
      final list = await repository.getCategoryList();
      emit(
          ProductsListLoaded(productList: responseItems, categoriesList: list));
    });
    on<ToogleIcon>((event, emit) {
      if (event.isFirstImageSelected) {
        isFirstImageSelected = true;
        isSecondImageSelected = false;
      }
      if (event.isSecondImageSelected) {
        isFirstImageSelected = false;
        isSecondImageSelected = true;
      }
      emit(IconToggled(
          isFirstImageSelected: isFirstImageSelected,
          isSecondImageSelected: isSecondImageSelected));
    });
  }
}
