import 'dart:ui';

class HexColor extends Color {
  HexColor(final String hexColor,) : super(_getColorFromHex(hexColor,),);

  static int _getColorFromHex(String hexColor,) {
    final String hex = hexColor.toUpperCase().replaceAll('#', '',);
    if (hex.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.tryParse(hexColor, radix: 16,) ?? 0xFFFFFFFF;
  }
}