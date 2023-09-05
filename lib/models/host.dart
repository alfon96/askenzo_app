import 'dart:convert';

class Host {
  Host({
    this.id = 0,
    required this.email,
    required this.imgProfile,
    required this.name,
    required this.stateId,
  });
  int id;
  String name;
  String email;
  String imgProfile;
  int stateId;

  toJson() => json.encode({
        "name": name,
        "email": email,
        "img_profile": imgProfile,
        "state_id": stateId,
      });

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

Host toHost(Map<String, dynamic> response) {
  return Host(
    id: response['id'],
    name: response['name'],
    email: response['email'],
    imgProfile: response['img_profile'],
    stateId: response['state_id'],
  );
}

// Host Register

class HostRegister extends Host {
  HostRegister({
    int id = 0,
    required String name,
    required String email,
    required String imgProfile,
    required int stateId,
    required this.password,
  }) : super(
          id: id,
          name: name,
          email: email,
          imgProfile: imgProfile,
          stateId: stateId,
        );

  String password;

  @override
  toJson() => json.encode({
        "name": name,
        "email": email,
        "img_profile": imgProfile,
        "state_id": stateId,
        "password": password,
      });
}

HostRegister toHostRegister(Map<String, dynamic> response) {
  return HostRegister(
    id: response['id'],
    name: response['name'],
    email: response['email'],
    imgProfile: response['img_profile'],
    stateId: response['state_id'],
    password: response['password'],
  );
}
