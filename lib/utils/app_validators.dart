// ignore_for_file: unused_local_variable

class AppValidators {
  static var email = (String? value) {
    if (value!.isEmpty) {
      return "Email cannot be empty";
    } else if (!value.contains("@")) {
      return "Invalid Email Address. Please enter a valid email address";
    }
    return null;
  };

  static var password = (String? value) {
    if (value!.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  };
  static var reEnterPassword = (String? value, String old) {
    if (value!.isEmpty) {
      return "Password cannot be empty";
    } else if (value != old) {
      return "Password does not match";
    }
  };

  static var otp = (String? value) {
    if (value!.isEmpty) {
      return "Please provide OTP";
    } else if (value.length != 4) {
      return "Invalid or Incorrect OTP. Try again";
    }
  };

  static var notEmpty = (String? value) {
    if (value!.isEmpty) {
      return "The field cannot be empty";
    }
  };

  static var phone = (String? value) {
    if (value!.isEmpty) {
      return "Phone number cannot be empty";
    }
    // create a regular expression for the phone number
    RegExp regExp = RegExp(r'^[0-9]{10}$');
    // if (!regExp.hasMatch(value)) {
    //   return "Invalid Phone Number. Please enter a valid phone number";
    // }
  };
}
