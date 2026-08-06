class MyUser {
  static const String collectionName = "users";
  String uId;

  String email;

  String name;

  MyUser({required this.uId, required this.email, required this.name});

  ///json => object
  MyUser.fromFireStore(Map<String, dynamic> data)
      :this(uId: data["id"], email: data["email"], name: data["name"]);

  ///object => json
  Map<String, dynamic> toFireStore() {
    return {
      "id": uId,
      "email": email,
      "name": name,
    };
  }
}
