import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  Map _loginData;

  Map get loginData => _loginData;

  set loginData(Map loginData) {
    _loginData = loginData;
    notifyListeners();
  }
}
