extension StringUtils on String {
  String get svgAsset => 'assets/icons/$this.svg';

  String get pngAsset => 'assets/images/$this.png';

  bool get isNumeric => double.tryParse(this) != null;

  bool get isEmail => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
}
