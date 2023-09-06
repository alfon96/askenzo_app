import 'dart:convert';

/// The `Host` class represents a host with properties such as id, email, imgProfile, name, and stateId,
/// and provides methods to convert the object to JSON format.
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

/// The function `Host toHost` takes a response map and returns a `Host` object with the corresponding
/// properties.
/// 
/// Args:
///   response (Map<String, dynamic>): A map containing the response data from an API call. The keys in
/// the map correspond to the field names in the response, and the values are the corresponding values
/// for each field.
/// 
/// Returns:
///   an instance of the `Host` class.
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

/// The `HostRegister` class is a subclass of `Host` that represents a host with additional properties
/// for registration, including a password.
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

/// The function `toHostRegister` takes a response map and returns a `HostRegister` object with the
/// values extracted from the map.
/// 
/// Args:
///   response (Map<String, dynamic>): A map containing the response data from the host registration
/// API. The keys in the map correspond to the field names in the response.
/// 
/// Returns:
///   an instance of the HostRegister class.
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
