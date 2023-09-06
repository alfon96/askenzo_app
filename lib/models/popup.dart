import 'dart:convert';
import 'package:http/http.dart' as http;

/// The `PopupModel` class represents a popup with text, a cursor position, and a flag indicating if
/// there is more content available.
class PopupModel {
  PopupModel({
    required this.text,
    required this.cursor,
    required this.hasMore,
  });

  List<String> text;
  bool hasMore;
  int cursor;
}

/// The function converts a HTTP response into a PopupModel object by extracting relevant data from the
/// response body.
/// 
/// Args:
///   response (http): The `response` parameter is an instance of the `http.Response` class, which
/// represents the response received from an HTTP request. It contains information such as the response
/// status code, headers, and body.
/// 
/// Returns:
///   a PopupModel object.
PopupModel toPopupModel(http.Response response) {
  dynamic responseData = jsonDecode(utf8.decode(response.bodyBytes));
  List<String> textPopups = [];

  for (Map<String, dynamic> item in responseData['items']) {
    textPopups.add(item['text']);
  }

  return PopupModel(
    text: textPopups,
    cursor: responseData['cursor'],
    hasMore: responseData['has_more'],
  );
}
