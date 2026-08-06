import 'package:evently_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser? newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
