import 'package:arch/application/model/item.dart';

class MainScreenRepository {
  Future<List<Item>> getItemsList() async {
    return [
      Item(name: 'Тонометры', image: 'assets/images/tonometr.png'),
      Item(name: 'Корсеты', image: 'assets/images/corset.png'),
      Item(name: 'Стельки', image: 'assets/images/stelki.png'),
      Item(name: 'Глюкометры', image: 'assets/images/glukometr.png'),
      Item(name: 'Ирегаторы', image: 'assets/images/iregator.png'),
      Item(name: 'Ингаляторы', image: 'assets/images/ingalator.png'),
    ];
  }
}
