import 'package:scoped_model/scoped_model.dart';

class CountModel extends Model{
  Map _cateData;

  Map get cateData => _cateData;

  set cateData(Map cateData) {
    _cateData = cateData;
    notifyListeners();
  }
  Map _cateSumData;

  Map get cateSumData => _cateSumData;

  set cateSumData(Map cateSumData) {
    _cateSumData = cateSumData;
    notifyListeners();
  }
  Map _consumeData;

  Map get consumeData => _consumeData;

  set consumeData(Map consumeData) {
    _consumeData = consumeData;
    notifyListeners();
  }
  Map _payTypeData;

  Map get payTypeData => _payTypeData;

  set payTypeData(Map payTypeData) {
    _payTypeData = payTypeData;
    notifyListeners();
  }
  Map _sendData;

  Map get sendData => _sendData;

  set sendData(Map sendData) {
    _sendData = sendData;
    notifyListeners();
  }
  double _consumeTotal;

  double get consumeTotal => _consumeTotal;

  set consumeTotal(double consumeTotal) {
    _consumeTotal = consumeTotal;
    notifyListeners();
  }
  double _payTotal;

  double get payTotal => _payTotal;

  set payTotal(double payTotal) {
    _payTotal = payTotal;
    notifyListeners();
  }
}