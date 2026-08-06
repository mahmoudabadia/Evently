import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/utilis/app_colors.dart';
import 'package:evently_app/utilis/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../utilis/size_utilis.dart';
import '../../firebase_utilis.dart';
import '../../utilis/toast_utilis.dart';

class DetailsEventScreen extends StatefulWidget {
  const DetailsEventScreen({super.key});

  @override
  State<DetailsEventScreen> createState() => _DetailsEventScreenState();
}

class _DetailsEventScreenState extends State<DetailsEventScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! Event) {
      return Scaffold(
        body: const Center(
          child: Text("No Event Data Found!", textAlign: TextAlign.center),
        ),
      );
    }
    Event event = args;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = context.width;
    var height = context.height;
    String formattedDate = DateFormat('dd MMMM yyyy').format(event.eventDate);
    String formattedTime = DateFormat('hh:mm a').format(event.eventDate);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.details,
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
        actions: [
          Container(
            margin: EdgeInsetsDirectional.only(
              start: width * .02,
              top: height * .01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: themeProvider.isDarkMode()
                  ? AppColors.darkBgColor
                  : AppColors.whiteColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.editEventRouteName, arguments: event);
              },
              icon: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              margin: EdgeInsetsDirectional.only(
                start: width * .02,
                top: height * .01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeProvider.isDarkMode()
                    ? AppColors.darkBgColor
                    : AppColors.whiteColor,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              child: IconButton(
                onPressed: () async {
                  try {
                    await FirebaseUtilis.getEventCollection()
                        .doc(event.eventId)
                        .delete();
                    ToastUtilis.showToastMessage(
                      message: AppLocalizations.of(context)!.delete,
                      backgroundColor: AppColors.redColor,
                      textColor: AppColors.whiteColor,
                    );
                    Navigator.of(context).pop();
                  } catch (error) {
                    ToastUtilis.showToastMessage(
                      message: AppLocalizations.of(context)!.noAction,
                      backgroundColor: AppColors.redColor,
                      textColor: AppColors.whiteColor,
                    );
                  }
                },
                icon: Icon(Icons.delete_outline, color: AppColors.redColor),
              ),
            ),
          ),
        ],
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
                    event.eventImage,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  event.evenTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),

                Container(
                  padding: EdgeInsets.all(width * 0.03),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode()
                        ? AppColors.transparentColor
                        : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: themeProvider.isDarkMode()
                              ? AppColors.transparentColor
                              : AppColors.strokeWhiteColor,
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          size: height * 0.04,
                          Icons.date_range_sharp,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedDate,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            formattedTime,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),

                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),

                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 120),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode()
                        ? AppColors.transparentColor
                        : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    event.eventDescription.isEmpty
                        ? "No Description"
                        : event.eventDescription,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
