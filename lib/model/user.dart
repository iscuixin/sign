import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  Map _loginData;

  Map _defaulSignEmployee;

  Map get loginData => _loginData;

  Map get defaulSignEmployee => _defaulSignEmployee;


  set loginData(Map loginData) {
    _loginData = loginData;
    notifyListeners();
  }

  set defaulSignEmployee(Map defaulSignEmployee) {
    _defaulSignEmployee = defaulSignEmployee;
    notifyListeners();
  }
}
