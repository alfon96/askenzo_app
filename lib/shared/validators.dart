/// The function `_validateTitle` checks if a given title is empty or contains numbers and returns an
/// error message if it does.
/// 
/// Args:
///   title (String): The parameter "title" is a string that represents the title to be validated.
/// 
/// Returns:
///   a String value.
String? _validateTitle(String title) {
  if (title.isEmpty || title.contains(RegExp(r'\d'))) {
    return 'Il titolo non può essere vuoto e non deve contenere numeri.';
  }
  return null;
}

/// The function `_validateDescription` checks if a description is empty and returns an error message if
/// it is.
/// 
/// Args:
///   description (String): The parameter "description" is a string that represents the description of
/// something.
/// 
/// Returns:
///   a String value or null.
String? _validateDescription(String description) {
  if (description.isEmpty) {
    return 'La descrizione non può essere vuota.';
  }
  return null;
}

/// The function `_validateImgPreviewPath` checks if the `imgPreviewPath` is empty and returns an error
/// message if it is.
/// 
/// Args:
///   imgPreviewPath (String): The imgPreviewPath parameter is a string that represents the path to an
/// image preview.
/// 
/// Returns:
///   a String value. If the imgPreviewPath is empty, it returns a message indicating that the image
/// preview path cannot be null. Otherwise, it returns null.
String? _validateImgPreviewPath(String imgPreviewPath) {
  if (imgPreviewPath.isEmpty) {
    return 'Il link dell\'immagine di copertina non può essere nullo.';
  }
  return null;
}

/// The function `_validateDate` checks if a selected date is before the current date and returns an
/// error message if it is.
/// 
/// Args:
///   selectedDate (DateTime): The selectedDate parameter is of type DateTime and represents the date
/// that needs to be validated.
/// 
/// Returns:
///   a String value.
String? _validateDate(DateTime selectedDate) {
  if (selectedDate.isBefore(DateTime.now())) {
    return 'E\' necessario scegliere una data';
  } else {
    return null;
  }
}

/// The function `_validateInteger` checks if a given string is a valid integer.
/// 
/// Args:
///   integer (String): The parameter "integer" is a string that represents an integer value.
/// 
/// Returns:
///   a String value. If the input integer is empty or does not contain only numbers, it returns a
/// specific error message. Otherwise, it returns null, indicating that the input integer is valid.
String? _validateInteger(String integer) {
  if (integer.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(integer)) {
    return 'Questo campo non può essere vuoto e deve contenere solo numeri.';
  }
  return null;
}

/// The function `_validateImgPaths` in Dart returns a nullable string.
/// 
/// Args:
///   value (String): The value parameter is a string that represents the image paths.
/// 
/// Returns:
///   The method is returning a nullable String.
String? _validateImgPaths(String value) {
  return null;
}

/// The function `_validatePrice` checks if a given price string contains only numeric characters and
/// returns an error message if it contains any non-numeric characters.
/// 
/// Args:
///   price (String): The parameter "price" is a string that represents the price value.
/// 
/// Returns:
///   a String value. If the price contains any letters or is not empty, it returns the error message
/// "Il prezzo non può contenere lettere.". Otherwise, it returns null.
String? _validatePrice(String price) {
  final validCharacters = RegExp(r'^[0-9]+$');

  if (!validCharacters.hasMatch(price) && price.isNotEmpty) {
    return 'Il prezzo non può contenere lettere.';
  }

  return null;
}

/// The function `_validateDuration` checks if a given duration string is in the format hh:mm:ss.
/// 
/// Args:
///   duration: The parameter "duration" is a string representing the duration of an experience.
/// 
/// Returns:
///   a String value. If the duration does not match the specified format, it returns an error message.
/// Otherwise, it returns null.
String? _validateDuration(duration) {
  if (!RegExp(r'^([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$')
      .hasMatch(duration)) {
    return 'La durata dell\'esperienza deve rispettare il formato hh:mm:ss';
  }
  return null;
}

/// The function `_validateVideoPath` checks if the videoPaths list is empty and the kind is 'VIDEO',
/// and returns an error message if it is.
/// 
/// Args:
///   videoPaths: A list of video paths.
///   kind: The "kind" parameter represents the type of content. In this case, it is expected to be a
/// string value.
/// 
/// Returns:
///   a String value.
String? _validateVideoPath(videoPaths, kind) {
  if (videoPaths.isEmpty && kind == 'VIDEO') {
    return 'Il link del video non può essere nullo per un contenuto di tipo VIDEO.';
  }
  return null;
}

/// The function `_validateLatGps` checks if a latitude value is valid and returns an error message if
/// it is not.
/// 
/// Args:
///   latGps: The parameter `latGps` is a string representing the latitude in GPS coordinates.
/// 
/// Returns:
///   a String value. If the latitude value passed as an argument does not match the specified regular
/// expression pattern, it returns a message indicating that the latitude is not valid. Otherwise, it
/// returns null.
String? _validateLatGps(latGps) {
  if (!RegExp(
          r'^(\+|-)?(?:90(?:(?:\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,6})?))$')
      .hasMatch(latGps)) {
    return 'La latitudine inserita non è valida. Essa deve essere compresa tra -90 e 90°';
  }
  return null;
}

/// The function `_validateLonGps` checks if a given longitude value is valid and returns an error
/// message if it is not.
/// 
/// Args:
///   lonGps: The parameter lonGps represents the longitude value in GPS coordinates.
/// 
/// Returns:
///   a String value. If the longitude input is not valid, it returns a message indicating that the
/// longitude must be between -180 and 180 degrees. If the longitude input is valid, it returns null.
String? _validateLonGps(lonGps) {
  if (!RegExp(
          r'^(\+|-)?(?:180(?:(?:\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,6})?))$')
      .hasMatch(lonGps)) {
    return 'La longitudine inserita non è valida. Essa deve essere compresa tra -180 e 180°';
  }
  return null;
}

/// The function `_validateAddress` takes a `username` as input and returns a nullable `String` value.
/// 
/// Args:
///   username (String): The username parameter is a String that represents the username of a user.
/// 
/// Returns:
///   The method is returning a String object, but the value being returned is null.
String? _validateAddress(String username) {
  return null;
}
/// The function `_validateUsername` checks if the username is empty and returns an error message if it
/// is.
/// 
/// Args:
///   username (String): The parameter "username" is a String that represents the username to be
/// validated.
/// 
/// Returns:
///   The function `_validateUsername` returns a `String?` value. If the `username` is empty, it returns
/// a non-null `String` message indicating that the username cannot be empty. Otherwise, it returns
/// `null`.

String? _validateUsername(String username) {
  if (username.isEmpty) {
    return 'L\'username non può essere vuoto.';
  }
  return null;
}

/// The function `_validatePassword` checks if a given password meets certain criteria and returns an
/// error message if it does not.
/// 
/// Args:
///   password (String): The parameter "password" is a string that represents the password that needs to
/// be validated.
/// 
/// Returns:
///   The function `_validatePassword` returns a `String?` value. It returns `null` if the password is
/// valid, and returns an error message as a `String` if the password is invalid.
String? _validatePassword(String password) {
  if (password.isEmpty) {
    return 'La password non può essere vuota.';
  }
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9].*?[0-9]).{8,}$';
  RegExp regex = RegExp(pattern);

  if (regex.hasMatch(password)) {
    return null;
  } else {
    return 'Inserisci una password valida';
  }
}

/// The function `_validateId` checks if a given ID is valid, returning an error message if it is not.
/// 
/// Args:
///   id (String): The parameter "id" is a string that represents an ID.
/// 
/// Returns:
///   The function `_validateId` returns a `String?` value.
String? _validateId(String id) {
  if (id.isEmpty) {
    return 'L\'id non può essere nullo.';
  }
  final validCharacters = RegExp(r'^[0-9]+$');
  if (!validCharacters.hasMatch(id)) {
    return 'Il prezzo non può contenere lettere.';
  }
  return null;
}

/// The function `_validateEmail` checks if an email is valid and returns an error message if it is not.
/// 
/// Args:
///   email (String): The email parameter is a string that represents an email address.
/// 
/// Returns:
///   The function `_validateEmail` returns a `String?`. If the `email` parameter matches the specified
/// email pattern, it returns `null`. Otherwise, it returns the string `'Inserisci una mail valida'`.
String? _validateEmail(String email) {
  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  RegExp regex = RegExp(pattern);

  if (regex.hasMatch(email)) {
    return null;
  } else {
    return 'Inserisci una mail valida';
  }
}

/// The function `_validatePhone` checks if a given phone number is valid and returns an error message
/// if it is not.
/// 
/// Args:
///   phone (String): The parameter "phone" is a string that represents a phone number.
/// 
/// Returns:
///   The function `_validatePhone` returns a `String?`.
String? _validatePhone(String phone) {
  RegExp regex = RegExp(r'^\d{9,}$');

  if (regex.hasMatch(phone)) {
    return null;
  } else {
    return 'Inserisci un numero di telefono valido';
  }
}

/// The function `_validatePopupText` takes a string parameter `id` and returns a nullable string.
/// 
/// Args:
///   id (String): The parameter "id" is a String that represents the identifier of a popup.
/// 
/// Returns:
///   null
String? _validatePopupText(String id) {
  return null;
}

/// The function `_validateConfirmationPassword` checks if the checking password matches the original
/// password and returns an error message if they don't match.
/// 
/// Args:
///   password (String): The password that the user entered.
///   checkingPassword (String): The password that the user is confirming.
/// 
/// Returns:
///   a String value. It returns a message indicating the validation error if there is one, or it
/// returns null if the confirmation password is valid.
String? _validateConfirmationPassword(
    String password, String checkingPassword) {
  if (checkingPassword.isEmpty) {
    return 'La password non può essere vuota.';
  }
  if (checkingPassword != password) {
    return 'Le password non coincidono.';
  }
  return null;
}

/// The code block is defining constants that are assigned to different validation functions. These
/// constants are used to validate different types of input fields in various scenarios. For example,
/// `validateEmail` is assigned the `_validateEmail` function, which is used to validate email
/// addresses. Similarly, `validatePassword` is assigned the `_validatePassword` function, which is used
/// to validate passwords. These constants can be used throughout the codebase to easily access and
/// reuse the validation functions.
//PRENOTAZIONE
const Function validateInteger = _validateInteger;
const Function validateDate = _validateDate;

// REGISTER
const Function validateEmail = _validateEmail;
const Function validatePhone = _validatePhone;

// LOGIN
const Function validateUsername = _validateUsername;
const Function validatePassword = _validatePassword;

// EDIT PROFILE
const Function validateConfirmationPassword = _validateConfirmationPassword;

//ID
const Function validateId = _validateId;

// COMMON
const Function validateTitle = _validateTitle;
const Function validateDescription = _validateDescription;
const Function validateImgPreviewPath = _validateImgPreviewPath;
const Function validateImgPaths = _validateImgPaths;

// EXPERIENCE
const Function validatePrice = _validatePrice;
const Function validateDuration = _validateDuration;
// DISCOVERY
const Function validateVideoPath = _validateVideoPath;
const Function validateLatGps = _validateLatGps;
const Function validateLonGps = _validateLonGps;
const Function validateAddress = _validateAddress;
// POPUP
const Function validatePopupText = _validatePopupText;
