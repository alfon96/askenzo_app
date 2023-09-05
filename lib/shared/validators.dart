String? _validateTitle(String title) {
  if (title.isEmpty || title.contains(RegExp(r'\d'))) {
    return 'Il titolo non può essere vuoto e non deve contenere numeri.';
  }
  return null;
}

String? _validateDescription(String description) {
  if (description.isEmpty) {
    return 'La descrizione non può essere vuota.';
  }
  return null;
}

String? _validateImgPreviewPath(String imgPreviewPath) {
  if (imgPreviewPath.isEmpty) {
    return 'Il link dell\'immagine di copertina non può essere nullo.';
  }
  return null;
}

String? _validateDate(DateTime selectedDate) {
  if (selectedDate.isBefore(DateTime.now())) {
    return 'E\' necessario scegliere una data';
  } else {
    return null;
  }
}

String? _validateInteger(String integer) {
  if (integer.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(integer)) {
    return 'Questo campo non può essere vuoto e deve contenere solo numeri.';
  }
  return null;
}

String? _validateImgPaths(String value) {
  return null;
}

String? _validatePrice(String price) {
  final validCharacters = RegExp(r'^[0-9]+$');

  if (!validCharacters.hasMatch(price) && price.isNotEmpty) {
    return 'Il prezzo non può contenere lettere.';
  }

  return null;
}

String? _validateDuration(duration) {
  if (!RegExp(r'^([0-1][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$')
      .hasMatch(duration)) {
    return 'La durata dell\'esperienza deve rispettare il formato hh:mm:ss';
  }
  return null;
}

String? _validateVideoPath(videoPaths, kind) {
  if (videoPaths.isEmpty && kind == 'VIDEO') {
    return 'Il link del video non può essere nullo per un contenuto di tipo VIDEO.';
  }
  return null;
}

String? _validateLatGps(latGps) {
  if (!RegExp(
          r'^(\+|-)?(?:90(?:(?:\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,6})?))$')
      .hasMatch(latGps)) {
    return 'La latitudine inserita non è valida. Essa deve essere compresa tra -90 e 90°';
  }
  return null;
}

String? _validateLonGps(lonGps) {
  if (!RegExp(
          r'^(\+|-)?(?:180(?:(?:\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,6})?))$')
      .hasMatch(lonGps)) {
    return 'La longitudine inserita non è valida. Essa deve essere compresa tra -180 e 180°';
  }
  return null;
}

String? _validateAddress(String username) {
  return null;
}

String? _validateUsername(String username) {
  if (username.isEmpty) {
    return 'L\'username non può essere vuoto.';
  }
  return null;
}

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

String? _validateEmail(String email) {
  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  RegExp regex = RegExp(pattern);

  if (regex.hasMatch(email)) {
    return null;
  } else {
    return 'Inserisci una mail valida';
  }
}

String? _validatePhone(String phone) {
  RegExp regex = RegExp(r'^\d{9,}$');

  if (regex.hasMatch(phone)) {
    return null;
  } else {
    return 'Inserisci un numero di telefono valido';
  }
}

String? _validatePopupText(String id) {
  return null;
}

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
