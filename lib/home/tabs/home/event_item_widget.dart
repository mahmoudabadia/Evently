import 'package:evently_app/utilis/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utilis.dart';
import '../../../l10n/app_localizations.dart';
import '../../../model/event_model.dart';
import '../../../providers/theme_provider.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_routes.dart';
import '../../../utilis/size_utilis.dart';
import '../../../utilis/toast_utilis.dart';

class EventItemWidget extends StatefulWidget {
  final Event? event;
  final int index;

  EventItemWidget({super.key, required this.index, this.event});

  @override
  State<EventItemWidget> createState() => _EventItemWidgetState();
}

class _EventItemWidgetState extends State<EventItemWidget> {
  final List<String> evenLightImagesList = [
    AppAssets.sport,
    AppAssets.birthday,
    AppAssets.meeting,
    AppAssets.bookClub,
    AppAssets.exhibition,
  ];

  final List<String> evenDarkImagesList = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.event == null) {
      return const SizedBox.shrink();
    }

    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    int imageIndex = widget.index % evenLightImagesList.length;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.eventDetailsRouteName,
          arguments: widget.event,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * .02,
          vertical: height * .01,
        ),
        height: height * .25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor, width: 2),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              widget.event!.eventImage,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * .02,
                vertical: height * .01,
              ),
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode()
                    ? AppColors.darkBgColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              child: Text(
                DateFormat("dd MMM").format(widget.event!.eventDate),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * .02,
                vertical: height * .001,
              ),
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode()
                    ? AppColors.darkBgColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.event!.evenTitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  IconButton(
                    onPressed: () {
                      updateIsFavorite();
                    },
                    icon: Icon(
                      widget.event!.isFavorite
                          ? Icons.favorite_outlined
                          : Icons.favorite_outline_outlined,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateIsFavorite() {
    if (widget.event == null) return Future.value();

    bool newFavoriteStatus = !widget.event!.isFavorite;

    return FirebaseUtilis.getEventCollection()
        .doc(widget.event!.eventId)
        .update({"is_favorite": newFavoriteStatus})
        .then((value) {
          if (newFavoriteStatus) {
            ToastUtilis.showToastMessage(
              message: AppLocalizations.of(context)!.eventAddedToFavorites,
              backgroundColor: Colors.green,
              textColor: AppColors.whiteColor,
            );
          } else {
            ToastUtilis.showToastMessage(
              message: AppLocalizations.of(context)!.eventRemovedFromFavorites,
              backgroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor,
            );
          }

        })
        .catchError((error) {
          ToastUtilis.showToastMessage(
            message: AppLocalizations.of(context)!.failed,
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor,
          );
          print(error.toString());
        });
  }
}
