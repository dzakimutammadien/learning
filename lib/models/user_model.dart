class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String programStudi;
  final String fakultas;
  final String firstAccess;
  final String lastAccess;
  final String? profileImage;
  final String description;
  final String? photoUrl;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.programStudi,
    required this.fakultas,
    required this.firstAccess,
    required this.lastAccess,
    this.profileImage,
    this.description = '',
    this.photoUrl,
  });

  String get fullName => '$firstName $lastName';
}