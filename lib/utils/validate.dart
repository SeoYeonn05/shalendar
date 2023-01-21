/// 이메일 형식을 검증하는 함수(이메일 정규식)
String? validateEmail(String? value) {
  if (value == null || value!.trim().isEmpty) {
    return "이메일을 입력해야 합니다.";
  } else {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return '잘못된 이메일 형식입니다.';
    } else {
      return null;
    }
  }
}

/// 비밀번호를 검증하는 함수(공백, 8자 이상)
String? validatePassword(String? value) {
  if (value == null || value!.trim().isEmpty) {
    return "비밀번호를 입력해야 합니다.";
  } else {
    String pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return '특수문자, 영문자, 숫자를 포함한 8자 이상';
    } else {
      return null;
    }
  }
}

/// 유저이름을 검증하는 함수(공백, 2자 이상)
String? validateName(String? value) {
  if (value == null || value!.trim().isEmpty) {
    return "이름을 입력해야 합니다.";
  } else if (value.length < 2) {
    return "이름을 2자 이상 입력하세요.";
  }
  return null;
}
