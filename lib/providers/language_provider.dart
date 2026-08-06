import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier{
  String appLanguage = 'en';
   void changeLanguage(String newLanguage){
     if (newLanguage == appLanguage){
       return ;
     }
     appLanguage = newLanguage;
     notifyListeners();
   }

}