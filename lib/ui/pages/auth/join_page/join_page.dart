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

  // 비밀번호 입력 확인 후 비밀번호 확인 입력란을 활성화하기 위해 따로 controller 하나 적용시킴
  TextEditingController _passwordController = TextEditingController();

  // 각 입력값을 저장해놓을 변수 선언
  String? _userUid;
  String? _userEmail;
  String? _userNick;
  String? _userPwd;

  @override
  void dispose() {
    // 컨트롤러 해제
    _passwordController.dispose();
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
