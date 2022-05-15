class User {
  final String email;
  final String name;
  final String surname;
  final String password;
  final bool admin;

  const User(
      {required this.email,
      required this.name,
      required this.surname,
      required this.password,
      required this.admin});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        name: json['name'],
        surname: json['surname'],
        password: json['password'],
        admin: json['admin']);
  }
}
