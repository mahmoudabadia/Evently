import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/event_model.dart';
import 'model/user_model.dart';

class FirebaseUtilis {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
      fromFirestore: (snapshot, options) =>
          MyUser.fromFireStore(snapshot.data()!),
      toFirestore: (myUser, options) => myUser.toFireStore(),
    );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    CollectionReference<MyUser> collectionRef = getUsersCollection();

    DocumentReference<MyUser> docRef = collectionRef.doc(myUser.uId);

    return docRef.set(myUser);
  }

  static Future<MyUser?> getUserFromFireStore(String uId) async {
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
  }

  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance.collection(Event.collectionName).
     withConverter<Event>(
       fromFirestore: (snapshot, options) => Event.fromFireStore(snapshot.data()!),
       toFirestore: (event, options) => event.toFireStore(),
     );
  }

  static Future<void> addEventToFireStore(Event event) {
    CollectionReference<Event> collectionRef = getEventCollection();
    DocumentReference<Event> docRef = collectionRef.doc();
    event.eventId = docRef.id;
    return docRef.set(event);

  }
}
