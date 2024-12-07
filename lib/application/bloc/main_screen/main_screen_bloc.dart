import 'package:arch/application/model/item.dart';
import 'package:arch/application/repositories/main_screen/main_screen_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final MainScreenRepository repository;
  MainScreenBloc(this.repository) : super(MainSceenCategoriesInitial()) {
    on<LoadItemsList>((event, emit) async {
      final list = await repository.getItemsList();
      emit(ItemsLoaded(itemsList: list));
    });
  }
}
