extension StringExtension on String {
  String toCaptalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1, length)}';
  }
}
