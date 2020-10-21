//import 'package:easy_localization/easy_localization.dart';

class Validators {
  static String validateRequired(dynamic value) {
    return value == null || (value is String && value.trim().isEmpty)
        ? 'This filed is required'
        : null;
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)';
    RegExp regex = RegExp(pattern);
    if (value.isNotEmpty && regex.hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return 'This filed is required';
    } else {
      return 'Please enter valid email';
    }
  }

  static String validateMobileNumber(String value,
      {bool allowLandNumber = false, bool optional = false}) {
    Pattern pattern1 = r'^[0]?7[0-9]{8}$';
    Pattern pattern2 = r'^[0-9]{9}$';
    Pattern pattern3 = r'^[+]947[0-9]{8}$';
    RegExp regex1 = RegExp(pattern1);
    RegExp regex2 = RegExp(pattern2);
    RegExp regex3 = RegExp(pattern3);
    if (allowLandNumber) {
      if ((value.isNotEmpty && value.length == 9 && regex2.hasMatch(value)) ||
          (value.isEmpty && optional)) {
        return null;
      } else if (value.isEmpty) {
        return 'This filed is required';
      } else {
        return 'Please enter valid land number';
      }
    } else {
      if ((value.isNotEmpty &&
              (value.length == 9 || value.length == 10 || value.length == 12) &&
              (regex1.hasMatch(value) || regex3.hasMatch(value))) ||
          (value.isEmpty && optional)) {
        return null;
      } else if (value.isEmpty) {
        return 'This filed is required';
      } else {
        return 'Please enter valid mobile number';
      }
    }
  }

  static String validateNIC(String value) {
    Pattern pattern1 = r'^[0-9]{9}[vV]$';
    Pattern pattern2 = r'^[0-9]{12}$';
    RegExp regex1 = RegExp(pattern1);
    RegExp regex2 = RegExp(pattern2);
    if (value.isNotEmpty &&
        (regex1.hasMatch(value) || regex2.hasMatch(value))) {
      return null;
    } else if (value.isEmpty) {
      return 'This filed is required';
    } else {
      return 'Please enter valid NIC number';
    }
  }

  static String validateConfirmPassword(String value, String password) {
    if (value.isNotEmpty && (password.isNotEmpty && value == password)) {
      return null;
    } else if (value.isEmpty) {
      return 'This filed is required';
    } else {
      return 'Passwords are not matching';
    }
  }

  static String validatePinCode(String value) {
    if (value.isNotEmpty && (value.length == 6)) {
      return null;
    } else if (value.isEmpty) {
      return 'This filed is required';
    } else {
      return 'Enter all 6 digits';
    }
  }
}
