String? validateUid(String value) {
  if (value.isEmpty) {
    return '아이디를 입력하세요';
  } else {
    String pattern = r'^[a-z]+[a-z0-9]{5,19}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return '아이디는 영문으로 시작하는 영문(소문자) 또는 영문+숫자 6~20자로 작성';
    } else {
      return null; //null을 반환하면 정상
    }
  }
}

String? validateEmail(String value) {
  if (value.isEmpty) {
    return '이메일을 입력하세요';
  } else {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return '잘못된 이메일 형식입니다.';
    } else {
      return null; //null을 반환하면 정상
    }
  }
}

String? validatePassword(String value) {
  String pattern =
      r'^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,15}$';
  RegExp regExp = RegExp(pattern);

  if (value.isEmpty) {
    return '비밀번호를 입력하세요';
  } else if (value.length < 8) {
    return '특수문자, 문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
  } else if (!regExp.hasMatch(value)) {
    return '특수문자, 문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
  } else {
    return null; //null을 반환하면 정상
  }
}

String? validatePasswordConfirm(String password, String passwordConfirm) {
  if (passwordConfirm.isEmpty) {
    return '비밀번호 확인칸을 입력하세요';
  } else if (password != passwordConfirm) {
    return '입력한 비밀번호가 서로 다릅니다.';
  } else {
    return null; //null을 반환하면 정상
  }
}

String? validateNickName(String value) {
  String pattern = r'^([a-zA-Z0-9ㄱ-ㅎ|ㅏ-ㅣ|가-힣]).{1,10}$';
  RegExp regExp = RegExp(pattern);

  if (value.isEmpty) {
    return '닉네임을 입력하세요';
  } else if (!regExp.hasMatch(value)) {
    return '닉네임은 한글, 영문, 숫자로 이루어진 2-10자리만 가능합니다.';
  } else {
    return null;
  }
}
