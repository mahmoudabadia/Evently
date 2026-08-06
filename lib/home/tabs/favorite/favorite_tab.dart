import 'package:evently_app/home/widgets/custom_text_field.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/utilis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utilis.dart';
import '../../../model/event_model.dart';
import '../../../providers/theme_provider.dart';
import '../../../utilis/size_utilis.dart';
import '../home/event_item_widget.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  Stream<List<Event>>? stream;
  List<Event> favoriteList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream = grtAllFavoriteEvents();
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          vertical: height * .04,
          horizontal: width * .04,
        ),
        child: Column(
          children: [
            CustomTextField(
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              hintText: AppLocalizations.of(context)!.search,
              suffixIcon: Icon(
                Icons.search,
                color: Theme.of(context).cardColor,
              ),
              fill: true,
              fillColor: themeProvider.isDarkMode()
                  ? AppColors.darkBgColor
                  : AppColors.whiteColor,
              borderColor: Theme.of(context).dividerColor,
            ),
            SizedBox(height: height * .02),
            Expanded(
              child: StreamBuilder<List<Event>>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error : ${snapshot.error}",
                        style: Theme.of(context).textTheme.headlineMedium,
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
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    );
                  } else {
                    favoriteList = snapshot.data!;
                    return favoriteList.isEmpty
                        ? Center(
                            child: Text(
                              AppLocalizations.of(context)!.noEventsFound,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return EventItemWidget(
                                index: index,
                                event: favoriteList[index]
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: height * .02);
                            },
                            itemCount: favoriteList.length,
                          );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Stream<List<Event>> grtAllFavoriteEvents() {
    return FirebaseUtilis.getEventCollection()
        .where("is_favorite", isEqualTo: true)
        .orderBy("event_date")
        .snapshots()
        .map<List<Event>>((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

}
