class Validator {
  static String? phoneNumber(String? value) {
    if (value != null && value.length != 10) {
      return "Please enter correct mobile number";
    }
    return null;
  }

  static String? password(String? value) {
    if (value != null && value.length < 6) {
      return "Password length must be greater than 6";
    } else {
      return null;
    }
  }
}
