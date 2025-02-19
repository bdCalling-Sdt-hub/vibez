class ApiConstants{
  static const String baseUrl = "http://10.0.80.210:8080/api/v1";
  static const String imageBaseUrl = "http://10.0.80.210:8080";


  static const String signUpEndPoint = "/auth/register";
  static const String verifyEmailEndPoint = "/auth/verify-otp";
  static const String signInEndPoint = "/auth/login";
  static const String forgotPasswordPoint = "/auth/forget-password";
  static const String setPasswordEndPoint = "/auth/register";
  static const String resendOtpEndPoint = "/auth/resend-otp";
  static const String changePassword = "/auth/change-password";
  static const String updateProfile = "/auth/profile-update";


  ///user
  static const String eventEndPoint = "/event";
  static  String eventDetailsEndPoint(String id) => "/event/details?id=$id";
}