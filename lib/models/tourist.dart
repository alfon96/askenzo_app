import 'dart:convert';

/// The Tourist class represents a tourist with properties such as name, surname, email, telephone,
/// imgProfile, and stateId, and provides methods to convert the object to JSON format.
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

/// The function takes a response object and returns a Tourist object with the corresponding properties.
/// 
/// Args:
///   response (Map<String, dynamic>): A map containing the response data from an API or database. The
/// keys in the map correspond to the field names in the response data, and the values are the
/// corresponding values for each field.
/// 
/// Returns:
///   an instance of the Tourist class, with the properties set based on the values in the response map.
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

/// The TouristRegister class extends the Tourist class and adds a password field, as well as methods to
/// convert the object to JSON.
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

/// The function `toTouristRegister` takes a response map and returns a `TouristRegister` object with
/// the values extracted from the map.
/// 
/// Args:
///   response (Map<String, dynamic>): A map containing the response data from the API call. The keys in
/// the map correspond to the field names in the response.
/// 
/// Returns:
///   an instance of the `TouristRegister` class.
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
