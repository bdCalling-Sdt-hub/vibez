class AppConstants{
  static const String bearerToken = "bearerToken";
  static const String email = "email";
  static const String name = "name";
  static const String image = "image";
  static const String role = "role";
  static const String userId = "userId";
  static const String isLogged = "isLogged";


  static RegExp emailValidate = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static bool validatePassword(String value) {
    RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$');
    return regex.hasMatch(value);
  }
}