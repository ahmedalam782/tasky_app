import 'package:tasky_app/features/auth/data/models/register_request.dart';
import 'package:tasky_app/features/auth/domain/entities/post_register_entity.dart';

extension LoginMapper on PostRegisterEntity {
  RegisterRequest toModel() => RegisterRequest(
        phone: phone,
        password: password,
        name: name,
        yearOfExperience: yearOfExperience,
        experienceLevel: experienceLevel,
        address: address,
      );
}
