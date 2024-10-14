extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
 String toTitleCase() {
    if (this.isEmpty) return this; // Return if string is empty

    return this.split(' ').map((word) {
      if (word.isEmpty) return word; // Avoid processing empty words
      if (RegExp(r'^[0-9]').hasMatch(word)) return word; // If word starts with a number, return it as is
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ').replaceFirst(RegExp(r'^[A-Z]\. '), '');;
  }
   String extractNumber() {
    final RegExp regExp = RegExp(r'\d+'); // Matches one or more digits
    final match = regExp.firstMatch(this); // 'this' refers to the string the extension is called on
    return match != null ? match.group(0) ?? '' : '';
  }


}
