import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/darkmode_model.dart';
import 'package:shelfy_team_project/data/gvm/user_view_model/session_view_model.dart';
import 'package:shelfy_team_project/ui/pages/auth/join_page/widgets/validate_join_form.dart';
import 'package:shelfy_team_project/ui/pages/auth/widgets/custom_textFormField.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';

class JoinPage extends ConsumerStatefulWidget {
  const JoinPage({super.key});

  @override
  ConsumerState<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends ConsumerState<JoinPage> {
  // Form 의 상태에 접근할 수 있는 _formKey 생성
  final _formKey = GlobalKey<FormState>();

  // 각각의 TextFormField 의 입력값을 개별적으로 접근할 필요가 있기 때문에 controller 설정
  // FocusNode 를 통해 해당 TextFormField 의 validation 이 끝난 후 중복 검사를 실행
  // --> Validator 를 통해서는 dio.post 요청의 반환값인 Future 타입을 반환받을 수 없기 때문에 따로 FocusNode 를 통해 동작하도록 만듬

  // 각 입력 필드의 Controller
  TextEditingController _userUidController = TextEditingController();
  TextEditingController _userNickController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // 각 입력 필드에 대한 FocusNode
  FocusNode _userUidFocusNode = FocusNode();
  FocusNode _userNickFocusNode = FocusNode();
  FocusNode _userEmailFocusNode = FocusNode();

  // 비동기로 수행된 중복 검사 결과의 에러 메시지를 보관할 변수
  String? _uidDuplicateError;
  String? _nickDuplicateError;
  String? _emailDuplicateError;

  // 이메일 인증 완료 여부
  bool _isEmailVerified = false;

  @override
  void initState() {
    super.initState();

    // 아이디 입력란 : unfocus 시 중복 검사 실행
    _userUidFocusNode.addListener(
      () {
        if (!_userUidFocusNode.hasFocus) {
          final userUid = _userUidController.text.trim();
          if (validateUid(userUid) == null) {
            // 중복 검사 api 호출
            final bool isDuplicate =
                SessionVM().checkDuplicateUserUid(userUid) as bool;
            setState(() {
              _uidDuplicateError = isDuplicate ? '이미 존재하는 아이디입니다' : null;
            });
          }
        }
      },
    );
    // 아이디 입력란 : unfocus 시 중복 검사 실행
    _userNickFocusNode.addListener(
      () {
        if (!_userNickFocusNode.hasFocus) {
          final userNick = _userNickController.text.trim();
          if (validateUid(userNick) == null) {
            // 중복 검사 api 호출
            final bool isDuplicate =
                SessionVM().checkDuplicateUserNick(userNick) as bool;
            setState(() {
              _nickDuplicateError = isDuplicate ? '이미 존재하는 닉네임입니다' : null;
            });
          }
        }
      },
    );
    // 아이디 입력란 : unfocus 시 중복 검사 실행
    _userEmailFocusNode.addListener(
      () {
        if (!_userEmailFocusNode.hasFocus) {
          final userEmail = _userEmailController.text.trim();
          if (validateUid(userEmail) == null) {
            // 중복 검사 api 호출
            final bool isDuplicate =
                SessionVM().checkDuplicateUserEmail(userEmail) as bool;
            setState(() {
              _emailDuplicateError = isDuplicate ? '이미 존재하는 이메일입니다' : null;
            });
          }
        }
      },
    );
  }

  // 각 입력값을 저장해놓을 변수 선언
  String? _userUid;
  String? _userEmail;
  String? _userNick;
  String? _userPwd;

  @override
  void dispose() {
    // 컨트롤러 해제
    _userUidController.dispose();
    _userNickController.dispose();
    _userEmailController.dispose();
    _passwordController.dispose();
    _userUidFocusNode.dispose();
    _userNickFocusNode.dispose();
    _userEmailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 다크 모드 상태 구독
    bool isDarkMode = ref.watch(darkModeNotiProvider);
    // sessionUser 를 관리하는 창고 호출
    SessionVM sessionVM = ref.read(sessionProvider.notifier);

    return SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(context, '회원가입'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          // 시스템 키보드 팝업 시 overflow 되는 현상 해결을 위한 SingleChildScrollView 위젯 감싸기
          child: SingleChildScrollView(
            // todo - 회원가입 입력 필드마다 중복 검사 로직 추가 ( validator 에 넣든지 unfocus 에 넣든지 )
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/Shelfy_textLogo_white.png',
                    color: !isDarkMode ? Colors.black : Colors.white,
                    width: 200,
                  ),
                  const SizedBox(height: 10),
                  CustomTextformfield(
                    title: '아이디',
                    iconData: Icons.person,
                    obscureText: false,
                    isDarkMode: isDarkMode,
                    buildContext: context,
                    validator: (value) {
                      return validateUid(value);
                    },
                    onSaved: (newValue) {
                      _userUid = newValue;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextformfield(
                    title: '닉네임',
                    iconData: Icons.drive_file_rename_outline,
                    obscureText: false,
                    isDarkMode: isDarkMode,
                    buildContext: context,
                    validator: (value) {
                      return validateNickName(value);
                    },
                    onSaved: (newValue) {
                      _userNick = newValue;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextformfield(
                    title: '이메일',
                    iconData: Icons.mail,
                    obscureText: false,
                    isDarkMode: isDarkMode,
                    keyboardType: TextInputType.emailAddress,
                    buildContext: context,
                    validator: (value) {
                      return validateEmail(value);
                    },
                    onSaved: (newValue) {
                      _userEmail = newValue;
                    },
                    onPressed: () {
                      final email = _userEmailController.text.trim();
                      if (validateEmail(email) == null) {
                        final bool isDuplicate =
                            sessionVM.checkDuplicateUserEmail(email) as bool;
                        if (isDuplicate) {
                          setState(() {
                            _emailDuplicateError = '이미 사용 중인 이메일입니다';
                          });
                          return;
                        } else {
                          final bool isSent =
                              sessionVM.sendVerificationEmail(email) as bool;
                          setState(() {
                            _isEmailVerified = true;
                            _emailDuplicateError = null;
                          });
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextformfield(
                    title: '비밀번호',
                    iconData: Icons.lock,
                    obscureText: true,
                    isDarkMode: isDarkMode,
                    buildContext: context,
                    controller: _passwordController,
                    validator: (value) {
                      return validatePassword(value);
                    },
                    onSaved: (newValue) {
                      _userPwd = newValue;
                    },
                    onChanged: (value) {
                      setState(() {
                        _userPwd = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextformfield(
                    title: '비밀번호 확인',
                    iconData: Icons.lock,
                    obscureText: true,
                    isDarkMode: isDarkMode,
                    buildContext: context,
                    enabled: _userPwd != null && _userPwd!.isNotEmpty,
                    validator: (value) {
                      return validatePasswordConfirm(_userPwd!, value);
                    },
                    onSaved: (newValue) {},
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      minimumSize: WidgetStatePropertyAll(
                        Size(double.infinity, 50),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        const Color(0xFF4D77B2),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // 모든 입력값이 유효한 경우, onSaved 콜백 호출로 값 저장
                        _formKey.currentState!.save();
                        sessionVM.join(
                          userUid: _userUid!,
                          userNick: _userNick!,
                          userEmail: _userEmail!,
                          userPwd: _userPwd!,
                        );
                      }
                    },
                    child: Text(
                      '회원가입',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
