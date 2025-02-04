import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/darkmode_model.dart';
import 'package:shelfy_team_project/data/gvm/user_view_model/session_view_model.dart';
import 'package:shelfy_team_project/ui/pages/auth/widgets/custom_textFormField.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';

class JoinPage extends ConsumerWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(darkModeNotiProvider);
    SessionVM sessionVM = ref.read(sessionProvider.notifier);
    TextEditingController userUidController = TextEditingController();
    TextEditingController userNickController = TextEditingController();
    TextEditingController userEmailController = TextEditingController();
    TextEditingController userPwd1Controller = TextEditingController();
    TextEditingController userPwd2Controller = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(context, '회원가입'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                  controller: userUidController,
                  isDarkMode: isDarkMode,
                  buildContext: context,
                ),
                const SizedBox(height: 10),
                CustomTextformfield(
                  title: '닉네임',
                  iconData: Icons.drive_file_rename_outline,
                  obscureText: false,
                  controller: userNickController,
                  isDarkMode: isDarkMode,
                  buildContext: context,
                ),
                const SizedBox(height: 10),
                CustomTextformfield(
                  title: '이메일',
                  iconData: Icons.mail,
                  obscureText: false,
                  controller: userEmailController,
                  isDarkMode: isDarkMode,
                  buildContext: context,
                ),
                const SizedBox(height: 10),
                CustomTextformfield(
                  title: '비밀번호',
                  iconData: Icons.lock,
                  obscureText: true,
                  controller: userPwd1Controller,
                  isDarkMode: isDarkMode,
                  buildContext: context,
                ),
                const SizedBox(height: 10),
                CustomTextformfield(
                  title: '비밀번호 확인',
                  iconData: Icons.lock,
                  obscureText: true,
                  controller: userPwd2Controller,
                  isDarkMode: isDarkMode,
                  buildContext: context,
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
                    // 아이디 controller 로 추출
                    String userUid = userUidController.text.trim();
                    // 닉네임 controller 로 추출
                    String userNick = userNickController.text.trim();
                    // 이메일 controller 로 추출
                    String userEmail = userEmailController.text.trim();
                    // 비밀번호1 controller 로 추출
                    String userPwd1 = userPwd1Controller.text.trim();
                    // 비밀번호2 controller 로 추출
                    String userPwd2 = userPwd2Controller.text.trim();

                    // 비밀번호와 비밀번호 확인이 동일한 경우
                    if (userPwd1 == userPwd2) {
                      // view-model 의 회원가입 기능 호출
                      sessionVM.join(
                        userUid: userUid,
                        userNick: userNick,
                        userEmail: userEmail,
                        userPwd: userPwd1,
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
    );
  }
}
