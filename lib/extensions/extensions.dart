extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension DoubleExtension on double {
  toIntIfPossible() {
    if (this == toInt().toDouble()) {
      return toInt();
    } else {
      return toString();
    }
  }
}
