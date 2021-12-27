class User {
  final String username;
  final String email;
  final List<String> roles;

  User({
    required this.username,
    required this.email,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      roles: List<String>.from(json['roles'].map((role) => role.toString())),
    );
  }
}
