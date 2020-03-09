import 'package:scoped_model/scoped_model.dart';

class ComeShopModel extends Model{
  List _data;

  List get data => _data;

  set data(List data) {
    _data = data;
    notifyListeners();
  }
}