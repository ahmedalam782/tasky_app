import 'package:tasky_app/core/network/remote/end_point.dart';

class ImageResponse {
 final String? image;

 const ImageResponse({this.image});

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        image: json[ApiKey.image] as String?,
      );

  Map<String, dynamic> toJson() => {
        ApiKey.image: image,
      };
}
