import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const String collectionName = "Events";
  String eventId;
  String eventImage;
  int eventCategoryIndex;
  String eventName;
  String evenTitle;
  String eventDescription;
  DateTime eventDate;
  bool isFavorite;

  Event({
    this.eventId = "",
    required this.eventImage,
    required this.eventName,
    required this.evenTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventCategoryIndex  ,
    this.isFavorite = false,
  });
   Event.fromFireStore(Map<String, dynamic> data):this(
     eventId: data["event_id"],
     eventImage: data["event_image"],
     eventName: data["event_name"],
     eventCategoryIndex: data["event_category_index"],
     evenTitle: data["even_title"],
     eventDescription: data["event_description"],
     eventDate: (data["event_date"] as Timestamp).toDate(),
     isFavorite: data["is_favorite"],

   );
   Map<String, dynamic> toFireStore() {
    return {
      "event_id": eventId,
      "event_image": eventImage,
      "event_category_index": eventCategoryIndex,
      "event_name": eventName,
      "even_title": evenTitle,
      "event_description": eventDescription,
      "event_date": Timestamp.fromDate(eventDate),
      "is_favorite": isFavorite,
    };
  }
}
