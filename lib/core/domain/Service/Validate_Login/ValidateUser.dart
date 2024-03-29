import 'package:pages_app/core/Config/di.dart';
import 'package:pages_app/core/domain/Service/Data_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValidateUser extends Service{
  bool validateUser(String username, String password,List Teachers) {
    var i = 0;
    while (i < Teachers.length) {
      if (Teachers[i].id == username) {
        break;
      }
      i++;
    }
    if (i >= Teachers.length) {
      return false;
    } else {
      if (Teachers[i].password == password) {
        config.get<SharedPreferences>().setString('name', Teachers[i].name);
        config
            .get<SharedPreferences>()
            .setString('jobType', Teachers[i].JobType);
        return true;
      } else {
        return false;
      }
    }
  }
}