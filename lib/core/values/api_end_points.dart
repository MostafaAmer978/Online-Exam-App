class AppEndpoints {
  //base url
  static const String baseUrl = 'https://exam.elevateegy.com/api/v1/';
  //Resgister
  static const String register = 'auth/signup';

  //  Login
  static const String login = 'auth/signin';

  static const String forgetPassword = "auth/forgotPassword";
  static const String verifyResetCode = "auth/verifyResetCode";
  static const String resetPassword = "auth/resetPassword";

  static const String getLoggedUserinfo = 'auth/profileData';
  static const String editProfile = 'auth/editProfile';
  static const String logout = 'auth/logout';
  static const String changePassword = 'auth/changePassword';
  static const String subjectUrl = "subjects";
  static const String examsUrl = "exams?";
  static const String profile = "auth/profileData";
}
