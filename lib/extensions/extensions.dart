/// The code defines an extension called `StringExtension` on the `String` type. It adds a new method
/// called `capitalize()` to the `String` type. The `capitalize()` method capitalizes the first letter
/// of the string and returns the modified string.
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

/// The `extension DoubleExtension on double` defines an extension on the `double` type. It adds a new
/// method called `toIntIfPossible()` to the `double` type.
extension DoubleExtension on double {
  toIntIfPossible() {
    if (this == toInt().toDouble()) {
      return toInt();
    } else {
      return toString();
    }
  }
}
