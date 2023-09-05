import 'dart:convert';

class DiscoveryModel {
  DiscoveryModel({
    required this.title,
    required this.description,
    required this.imgPreviewPath,
    required this.imgPaths,
    required this.videoPaths,
    required this.kindId,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.stateId,
  });
  String title;
  String description;

  String imgPreviewPath;
  List<String> imgPaths;
  List<String> videoPaths;
  int kindId;
  double longitude;
  double latitude;
  String address;
  int stateId;

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'img_preview_path': imgPreviewPath,
        'img_paths': imgPaths,
        'video_paths': videoPaths,
        'coordinate_gps': '$latitude $longitude',
        'address': address,
        'kind_id': kindId,
        'state_id': stateId,
      };

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

UpdateDiscoveryModel toUpdateDiscoveryModel(Map<String, dynamic> response) {
  String coordinateGPS = response['coordinate_gps'];
  List<String> coordinates = coordinateGPS.split(' ');
  double lat = double.parse(coordinates[0]);
  double lon = double.parse(coordinates[1]);

  return UpdateDiscoveryModel(
    id: response['id'],
    title: response['title'],
    description: response['description'],
    address: response['address'],
    kindId: response['kind_id'],
    latitude: lat,
    longitude: lon,
    videoPaths: List<String>.from(response['video_paths']),
    imgPreviewPath: response['img_preview_path'],
    imgPaths: List<String>.from(response['img_paths']),
    stateId: response['state_id'],
  );
}

class UpdateDiscoveryModel extends DiscoveryModel {
  UpdateDiscoveryModel({
    required this.id,
    required String title,
    required String description,
    required String imgPreviewPath,
    required List<String> imgPaths,
    required List<String> videoPaths,
    required int kindId,
    required double longitude,
    required double latitude,
    required String address,
    required int stateId,
  }) : super(
          title: title,
          description: description,
          imgPreviewPath: imgPreviewPath,
          imgPaths: imgPaths,
          videoPaths: videoPaths,
          address: address,
          kindId: kindId,
          latitude: latitude,
          longitude: longitude,
          stateId: stateId,
        );

  int id;
}
