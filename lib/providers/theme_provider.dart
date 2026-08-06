import 'package:evently_app/utilis/app_theme.dart';

import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeData appTheme = AppTheme.lightTheme;
  void changeTheme(ThemeData newTheme){
    if (newTheme == appTheme){
      return ;
    }
    appTheme = newTheme;
    notifyListeners();
  }
  bool isDarkMode(){
    return appTheme == AppTheme.darkTheme;
  }
}
