class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final String? job;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    this.job,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatar: json['avatar'] as String,
      job: json['job'] as String?,
    );
  }

  String get fullName => '$firstName $lastName';

  User copyWith({String? name, String? job}) {
    final names = (name?.trim().isNotEmpty == true)
        ? name!.trim().split(' ')
        : [firstName, lastName];
    return User(
      id: id,
      email: email,
      firstName: names.isNotEmpty ? names[0] : firstName,
      lastName: names.length > 1 ? names[1] : lastName,
      avatar: avatar,
      job: job ?? this.job,
    );
  }
}