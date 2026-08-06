import 'package:evently_app/home/tabs/home/tab_item_widget.dart';
import 'package:evently_app/home/widgets/custom_elevated_button.dart';
import 'package:evently_app/home/widgets/custom_text_field.dart';
import 'package:evently_app/utilis/app_colors.dart';
import 'package:evently_app/utilis/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../firebase_utilis.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../model/event_model.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../utilis/app_assets.dart';
import '../../../../utilis/size_utilis.dart';
import '../../../../utilis/toast_utilis.dart';
import 'date_or_time_widget.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String eventTitle = "";
  String eventDesciption = "";
  DateTime? selectedEventDate;
  TimeOfDay? selectedEventTime;
  String? formatedDate;
  String? formatedTime;
  String? selectedEventName = "";
  String? selectedEventImage = "";

  List<String> evenLightImagesList = [
    AppAssets.sport,
    AppAssets.birthday,
    AppAssets.meeting,
    AppAssets.bookClub,
    AppAssets.exhibition,
  ];
  List<String> evenDarkImagesList = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];
  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meetingT,
      AppLocalizations.of(context)!.bookClup,
      AppLocalizations.of(context)!.exhibitionT,
    ];
    selectedEventName = eventsNameList[selectedIndex];
    selectedEventImage = themeProvider.isDarkMode()
        ? evenDarkImagesList[selectedIndex]
        : evenLightImagesList[selectedIndex];
    var width = context.width;
    var height = context.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.addEvent,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: Container(
          margin: EdgeInsetsDirectional.only(
            start: width * .02,
            top: height * .01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: themeProvider.isDarkMode()
                ? AppColors.darkBgColor
                : AppColors.whiteColor,
            border: Border.all(color: Theme.of(context).dividerColor, width: 2),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Image.asset(
                    height: height * 0.25,
                    themeProvider.isDarkMode()
                        ? evenDarkImagesList[selectedIndex]
                        : evenLightImagesList[selectedIndex],
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: TabItemWidget(
                          isSelected: selectedIndex == index,
                          unselectedColor: themeProvider.isDarkMode()
                              ? AppColors.darkBgColor
                              : AppColors.whiteColor,
                          eventName: eventsNameList[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * 0.02);
                    },
                    itemCount: eventsNameList.length,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  hintText: AppLocalizations.of(context)!.eventTitle,
                  fill: true,
                  fillColor: themeProvider.isDarkMode()
                      ? AppColors.darkBgColor
                      : AppColors.whiteColor,
                  borderColor: Theme.of(context).dividerColor,

                  onChanged: (text) {
                    eventTitle = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your title";
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  hintText: AppLocalizations.of(context)!.eventDescription,
                  fill: true,
                  fillColor: themeProvider.isDarkMode()
                      ? AppColors.darkBgColor
                      : AppColors.whiteColor,
                  borderColor: Theme.of(context).dividerColor,
                  onChanged: (text) {
                    eventDesciption = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return " Please enter your description ";
                    }
                    return null;
                  },

                  maxLines: 6,
                ),
                SizedBox(height: height * 0.02),
                DateOrTimeWidget(
                  eventDateOrTime: AppLocalizations.of(context)!.eventDate,
                  icon: Icon(
                    Icons.date_range_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                  chooseDateOrTime: selectedEventDate == null
                      ? AppLocalizations.of(context)!.eventDate
                      : formatedDate!,
                  onChooseClic: onChooseDate,
                ),
                DateOrTimeWidget(
                  eventDateOrTime: AppLocalizations.of(context)!.eventTime,
                  icon: Icon(
                    Icons.timer_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                  chooseDateOrTime: selectedEventTime == null
                      ? AppLocalizations.of(context)!.eventTime
                      : formatedTime!,
                  onChooseClic: onChooseTime,
                ),
                CustomElevatedButton(
                  verticalPadding: height * 0.01,

                  backgroundColor: Theme.of(context).cardColor,
                  onPressed: addEvent,
                  child: Text(
                    AppLocalizations.of(context)!.addEvent,
                    style: AppStyles.medium20WhiteDarkColor,
                  ),
                ),
                SizedBox(height: height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {}
    Event event = Event(
      eventCategoryIndex: selectedIndex + 1,
      eventImage: selectedEventImage!,
      eventName: selectedEventName!,
      evenTitle: eventTitle,
      eventDescription: eventDesciption,
      eventDate: DateTime(
        selectedEventDate!.year,
        selectedEventDate!.month,
        selectedEventDate!.day,
        selectedEventTime!.hour,
        selectedEventTime!.minute,
      ),
    );
    FirebaseUtilis.addEventToFireStore(event)
        .then((value) {
          ToastUtilis.showToastMessage(
            message: AppLocalizations.of(context)!.eventAddedSuccessfully,
            backgroundColor: Colors.green,
            textColor: AppColors.whiteColor,
          );
          // todo:call method data
          Navigator.pop(context);
        })
        .catchError((error) {
          print(error.toString());
        });
  }

  void onChooseDate() async {
    var themeProvider = Provider.of<AppThemeProvider>(context, listen: false);
    bool isDark = themeProvider.isDarkMode();

    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 730)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? ColorScheme.dark(
                    primary: AppColors.mainLightColor,
                    onPrimary: AppColors.whiteColor,
                    surface: AppColors.darkBgColor,
                    onSurface: AppColors.whiteColor,
                  )
                : ColorScheme.light(
                    primary: AppColors.mainLightColor,
                    onPrimary: AppColors.whiteColor,
                    surface: AppColors.whiteColor,
                    onSurface: Colors.black,
                  ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.mainLightColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (chooseDate != null) {
      selectedEventDate = chooseDate;
      formatedDate = DateFormat('dd/MM/yyyy').format(selectedEventDate!);
      setState(() {});
    }
  }

  void onChooseTime() async {
    var themeProvider = Provider.of<AppThemeProvider>(context, listen: false);
    bool isDark = themeProvider.isDarkMode();
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? ColorScheme.dark(
                    primary: AppColors.mainLightColor,
                    onPrimary: AppColors.whiteColor,
                    surface: AppColors.darkBgColor,
                    onSurface: AppColors.whiteColor,
                  )
                : ColorScheme.light(
                    primary: AppColors.mainLightColor,
                    onPrimary: AppColors.whiteColor,
                    surface: AppColors.whiteColor,
                    onSurface: Colors.black,
                  ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.mainLightColor,
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              dialBackgroundColor: isDark
                  ? AppColors.strokeWhiteColor
                  : AppColors.strokeWhiteColor,
              hourMinuteColor: isDark
                  ? AppColors.strokeWhiteColor
                  : AppColors.strokeWhiteColor,
              hourMinuteTextColor: isDark ? AppColors.whiteColor : Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (chooseTime != null) {
      selectedEventTime = chooseTime;
      formatedTime = chooseTime.format(context);
      setState(() {});
    }
  }
}
