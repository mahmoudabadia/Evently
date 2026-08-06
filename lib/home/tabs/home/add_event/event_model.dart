class EventModel {
  String title;
  String description;
  String? eventName;
  String? eventImage;
  DateTime? dateTime;

  EventModel({
    required this.title,
    required this.description,
    this.eventName,
    this.eventImage,
    this.dateTime,
  });
}