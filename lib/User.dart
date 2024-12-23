class User {
  String name;
  String token;
  User({required this.name, required this.token});

  Map<String, dynamic> toJson() => {'name': name, 'token': token};
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      token: json['token'],
    );
  }
}
