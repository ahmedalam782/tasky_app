import 'package:tasky_app/core/network/remote/end_point.dart';

class RegisterRequest {
  final String name;
  final String phone;
  final int yearOfExperience;
  final String experienceLevel;
  final String? address;
  final String password;

 const RegisterRequest({
    required this.name,
    required this.phone,
    required this.yearOfExperience,
    required this.experienceLevel,
    this.address,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        ApiKey.displayName: name,
        ApiKey.phone: phone,
        ApiKey.experienceYears: yearOfExperience,
        ApiKey.level: experienceLevel,
        ApiKey.address: address,
        ApiKey.password: password,
      };
}
