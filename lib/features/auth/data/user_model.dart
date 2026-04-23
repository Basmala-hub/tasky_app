 class UserdData {
  UserdData({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
  });
  String name;
  String email;
  String password;
  String id;
  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "password": password};
  }

  factory UserdData.fromJson(Map<String, dynamic> json) {
    return UserdData(
      name: json["name"],
      email: json["email"],
      password: json["password"],
      id: json["id"],
    );
  }
}
