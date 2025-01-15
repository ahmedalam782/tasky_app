class PostRegisterEntity {
  final String name;
  final String phone;
  final int yearOfExperience;
  final String experienceLevel;
  final String? address;
  final String password;

  const PostRegisterEntity({
    required this.name,
    required this.phone,
    required this.yearOfExperience,
    required this.experienceLevel,
    this.address,
    required this.password,
  });
}
