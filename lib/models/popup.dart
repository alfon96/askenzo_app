import 'dart:convert';
import 'package:http/http.dart' as http;

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
