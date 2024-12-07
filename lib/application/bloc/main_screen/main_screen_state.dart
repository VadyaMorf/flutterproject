part of 'main_screen_bloc.dart';

abstract class MainScreenState {}

class MainSceenCategoriesInitial extends MainScreenState {}
class ItemsListLoading extends MainScreenState{}
class ItemsLoaded extends MainScreenState{
  final List<Item> itemsList;
  ItemsLoaded({required this.itemsList});
}