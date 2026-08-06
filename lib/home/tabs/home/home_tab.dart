import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/home/tabs/home/tab_item_widget.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/utilis/app_assets.dart';
import 'package:evently_app/utilis/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utilis.dart';
import '../../../providers/language_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_routes.dart';
import '../../../utilis/app_theme.dart';
import '../../../utilis/size_utilis.dart';
import 'event_item_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  List<Event> eventsList = [];
  List<Event> filterList = [];

  @override
  void initState() {
    super.initState();
    getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meetingT,
      AppLocalizations.of(context)!.bookClup,
      AppLocalizations.of(context)!.exhibitionT,
    ];
    List<String> eventsIconsList = [
      AppAssets.icAll,
      AppAssets.icSport,
      AppAssets.icBirthday,
      AppAssets.icBook,
      AppAssets.icBook,
    ];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * .04,
        vertical: height * .02,
      ),
      child: SafeArea(
        child: DefaultTabController(
          length: eventsNameList.length,
          child: Column(
            children: [
              Row(
                spacing: width * 0.04,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge,
                      ),
                      Text(() {
                        final user = FirebaseAuth.instance.currentUser;

                        if (user?.displayName != null &&
                            user!.displayName!.trim().isNotEmpty) {
                          return user.displayName!.trim().split(' ')[0];
                        }

                        if (user?.email != null && user!.email!.contains('@')) {
                          String emailName = user.email!.split('@')[0];
                          return emailName[0].toUpperCase() +
                              emailName.substring(1);
                        }

                        return "User";
                      }(), style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      themeProvider.changeTheme(AppTheme.darkTheme);
                    },
                    child: Image.asset(
                      themeProvider.isDarkMode()
                          ? AppAssets.icDark
                          : AppAssets.icLight,
                      color: Theme
                          .of(context)
                          .cardColor,
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .02,
                      vertical: height * .01,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme
                          .of(context)
                          .cardColor,
                    ),
                    child: Text(
                      languageProvider.appLanguage.toUpperCase(),
                      style: AppStyles.semi14White,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .02),
              TabBar(
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                dividerColor: AppColors.transparentColor,
                indicatorColor: AppColors.transparentColor,
                labelPadding: EdgeInsets.symmetric(horizontal: width * 0.01),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                tabs: eventsNameList.map((event) {
                  return TabItemWidget(
                    isSelected: selectedIndex == eventsNameList.indexOf(event),
                    unselectedColor: themeProvider.isDarkMode()
                        ? AppColors.darkBgColor
                        : AppColors.whiteColor,
                    eventName: event,
                  );
                }).toList(),
              ),
              SizedBox(height: height * .02),
              Expanded(
                child: StreamBuilder(
                  stream: getAllEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error : ${snapshot.error}",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium,
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainLightColor,
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.noEventsFound,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium,
                        ),
                      );
                    } else {
                      eventsList = snapshot.data!;
                      if (selectedIndex == 0) {
                        filterList = eventsList;
                      } else {
                        filterList = eventsList.where((event) {
                          return event.eventCategoryIndex == selectedIndex;
                        }).toList();
                        filterList.sort((event1, event2) {
                          return event1.eventDate.compareTo(event2.eventDate);
                        });
                      }
                      return filterList.isEmpty
                          ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.noEventsFound,
                          style: Theme
                              .of(
                            context,
                          )
                              .textTheme
                              .headlineMedium,
                        ),
                      )
                          : ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.eventDetailsRouteName);
                              arguments: filterList[index];
                            },
                            child: EventItemWidget(
                              event: filterList[index],
                              index: index,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: height * .02);
                        },
                        itemCount: filterList.length,


                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Stream<List<Event>> getAllEvents() {
    Stream<QuerySnapshot<Event>> stream = FirebaseUtilis.getEventCollection()
        .snapshots();
    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }
}
