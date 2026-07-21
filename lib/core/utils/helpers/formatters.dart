class Formatters {
  Formatters._();

  static const _ones = [
    '',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen',
  ];

  static const _tens = [
    '',
    '',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety',
  ];

  static String amountToWords(int amount) {
    if (amount == 0) return 'Zero dollar';
    final words = _numberToWords(amount).trim();
    return '${words[0].toUpperCase()}${words.substring(1)} dollar';
  }

  static String _numberToWords(int number) {
    if (number < 20) return _ones[number];
    if (number < 100) {
      final ten = number ~/ 10;
      final one = number % 10;
      return '${_tens[ten]}${one == 0 ? '' : '-${_ones[one]}'}';
    }
    if (number < 1000) {
      final hundred = number ~/ 100;
      final rest = number % 100;
      return '${_ones[hundred]} hundred${rest == 0 ? '' : ' ${_numberToWords(rest)}'}';
    }
    if (number < 1000000) {
      final thousand = number ~/ 1000;
      final rest = number % 1000;
      return '${_numberToWords(thousand)} thousand${rest == 0 ? '' : ' ${_numberToWords(rest)}'}';
    }
    final million = number ~/ 1000000;
    final rest = number % 1000000;
    return '${_numberToWords(million)} million${rest == 0 ? '' : ' ${_numberToWords(rest)}'}';
  }
}
