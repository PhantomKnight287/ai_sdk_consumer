extension StringExtension on String {
  String get initials {
    return split(' ').map((e) => e[0]).join();
  }

  String replaceLast(String from, String to) {
    final index = lastIndexOf(from);
    if (index == -1) return this;
    return substring(0, index) + to + substring(index + from.length);
  }
}

extension Capitalize on String {
  String get capitalize {
    return this[0].toUpperCase() + substring(1);
  }
}
