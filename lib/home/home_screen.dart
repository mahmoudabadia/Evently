import 'package:evently_app/home/tabs/favorite/favorite_tab.dart';
import 'package:evently_app/home/tabs/home/home_tab.dart';
import 'package:evently_app/home/tabs/profile/profile_tab.dart';
import 'package:evently_app/utilis/app_colors.dart';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utilis/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      const HomeTab(),
      const FavoriteTab(),
      const ProfileTab(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          builtBottomNavBarItem(
            selectedIcon: Icon(Icons.home),
            unselectedIcon: Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.home,
            isSelected: selectedIndex == 0,
          ),
          builtBottomNavBarItem(
            selectedIcon: Icon(Icons.favorite),
            unselectedIcon: Icon(Icons.favorite_outline_outlined),
            label: AppLocalizations.of(context)!.favorite,
            isSelected: selectedIndex == 1,
          ),
          builtBottomNavBarItem(
            selectedIcon: Icon(Icons.person),
            unselectedIcon: Icon(Icons.person_outline_outlined),
            label: AppLocalizations.of(context)!.profile,
            isSelected: selectedIndex == 2,
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainLightColor,
        onPressed: ()  {
           Navigator.of(context).pushNamed(AppRoutes.addEventRouteName);
           },
        child: Icon(Icons.add, color: AppColors.whiteColor,size: 35,),

      ),
    );
  }

  BottomNavigationBarItem builtBottomNavBarItem({
    required Widget selectedIcon,
    required Widget unselectedIcon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: isSelected ? selectedIcon : unselectedIcon,
      label: label,
    );
  }
}
