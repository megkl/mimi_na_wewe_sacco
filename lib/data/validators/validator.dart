class Validator {
  final List<String?> errors = [];

  static String? valueExists(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Please fill this field';
    } else {
      return null;
    }
  }

  static String? passwordCorrect(dynamic value) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-]).{8,}$';
      var regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return 'Your password must be at least 8 symbols with number, big and small letter and special character (!@#\$%^&*).';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? validateEmail(dynamic value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = RegExp(pattern);
    var emptyResult = valueExists(value);
    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp.hasMatch(value)) {
      return 'Not a valid email address. Should be your@email.com';
    } else {
      return null;
    }
  }

  static String? requiredField(dynamic value) {
    if (value == null) {
      return "Field is required";
    }
  }

  static String? validatePhoneNumber(dynamic value) {
    var pattern = r"^(?:[+0]+)?[0-9]{6,14}$";
    var regExp = RegExp(pattern);
    var emptyResult = valueExists(value);
    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp.hasMatch(value)) {
      return 'Not a valid phone number';
    } else {
      return null;
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      errors.remove(error);
    }
  }

  static String? checkPhoneNumber(dynamic value) {
    var safPattern =
        r"^(?:254|\+254|0)?(7(?:(?:[129][0–9])|(?:0[0–8])|(4[0–1]))[0–9]{6})$";
    var airtelPattern =
        r"(?:254|\+254|0)?(7(?:(?:[3][0-9])|(?:5[0-6])|(8[0-9]))[0-9]{6})$";
    var telkomPattern = r"^(?:254|\+254|0)?(77[0-6][0-9]{6})$";
    var safregExp = RegExp(safPattern);
    var airtelRegExp = RegExp(airtelPattern);
    var telkomregExp = RegExp(telkomPattern);

    if (safregExp.hasMatch(value)) {
      return '266';
    } else if (telkomregExp.hasMatch(value)) {
      return '264';
    } else {
      return '265';
    }
  }
}
