import 'package:tasky_app/features/tasks/data/models/image_response.dart';
import 'package:tasky_app/features/tasks/domain/entities/image_entity.dart';

extension ImageMapper on ImageResponse {
  ImageEntity toEntity() => ImageEntity(
        image: image,
      );
}
