import 'package:scoped_model/scoped_model.dart';

class IndexModel extends Model {
  Map _data;

  Map get data => _data;

  set data(Map data) {
    _data = data;
    notifyListeners();
  }
  List _ware;

  List get ware => _ware;

  set ware(List ware) {
    _ware = ware;
    notifyListeners();
  }
}
