class User {
  final String username;
  final String password;

  //Consturctor
  User({required this.username, required this.password});

  static User nullUser() {
    return User(username: "", password: "");
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'] ?? "", password: json["password"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"username": username, "password": password};
  }
}
