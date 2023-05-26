class User{
  String? name;
  String? email;
  String? password;
  String? phone;
  String? uuid;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.uuid
  });

  factory User.fromMap(Map userMap){
    return User(
        name: userMap['name'],
        email: userMap['email'],
        password: userMap['password'],
        phone: userMap['phone'],
        uuid: userMap['uuid']
    );
  }
}