import 'dart:convert';

class Tourist {
  Tourist({
    required this.email,
    required this.imgProfile,
    required this.name,
    required this.stateId,
    required this.surname,
    required this.telephone,
  });

  String name;
  String surname;
  String email;
  String telephone;
  String imgProfile;
  int stateId;

  toJson() => json.encode({
        "name": name,
        "surname": surname,
        "email": email,
        "img_profile": imgProfile,
        "state_id": stateId,
        "telephone": telephone,
      });

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

Tourist toTourist(Map<String, dynamic> response) {
  return Tourist(
    name: response['name'],
    surname: response['surname'],
    email: response['email'],
    imgProfile: response['img_profile'],
    telephone: response['telephone'],
    stateId: response['state_id'],
  );
}

// Tourist Register

class TouristRegister extends Tourist {
  TouristRegister({
    required String name,
    required String surname,
    required String email,
    required String telephone,
    required String imgProfile,
    required int stateId,
    required this.password,
  }) : super(
          name: name,
          surname: surname,
          email: email,
          telephone: telephone,
          imgProfile: imgProfile,
          stateId: stateId,
        );

  String password;

  @override
  toJson() => json.encode({
        "name": name,
        "surname": surname,
        "email": email,
        "img_profile": imgProfile,
        "state_id": stateId,
        "telephone": telephone,
        "password": password,
      });
      
  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}

TouristRegister toTouristRegister(Map<String, dynamic> response) {
  return TouristRegister(
    name: response['name'],
    surname: response['surname'],
    email: response['email'],
    telephone: response['telephone'],
    imgProfile: response['img_profile'],
    stateId: response['state_id'],
    password: response['password'],
  );
}
