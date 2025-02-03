import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/user_view_model/session_view_model.dart';
import 'package:shelfy_team_project/data/model/user_model/session_user.dart';
import 'package:shelfy_team_project/ui/pages/auth/widgets/custom_textFormField.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';

import '../join_page/widgets/custom_modal_bottom_sheet.dart';

class LoginPage extends ConsumerWidget {
  // GlobalKey 를 통해 Form 의 상태에 접근
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SessionVM sessionVM = ref.read(sessionProvider.notifier);
    SessionUser sessionUser = ref.watch(sessionProvider);
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(context, '로그인'),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    child: Image.asset(
                      'assets/images/shelfy_kitty_logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      color: !isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextformfield(
                          title: '아이디',
                          iconData: Icons.person,
                          obscureText: false,
                          controller: usernameController,
                          isDarkMode: isDarkMode,
                          buildContext: context,
                        ),
                        const SizedBox(height: 10),
                        CustomTextformfield(
                          title: '비밀번호',
                          iconData: Icons.lock,
                          obscureText: true,
                          controller: passwordController,
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
                            String username = usernameController.text.trim();
                            // 비밀번호 controller 로 추출
                            String password = usernameController.text.trim();
                            // view-model 의 로그인 기능 호출
                            sessionVM.login(
                              username: username,
                              password: password,
                            );
                          },
                          child: Text(
                            '로그인',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        // 비밀번호 찾기 기능 ( textButton )
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            child: Text(
                              '비밀번호를 잊으셨나요?',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.grey,
                                  ),
                            ),
                            onPressed: () {
                              // todo - 비밀번호 찾기 페이지 및 기능 구현
                            },
                          ),
                        ),

                        // 소셜 로그인 버튼 여러 개
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('구글로 로그인하기'),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.green)),
                          onPressed: () {},
                          child: Text('네이버로 로그인하기'),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.yellow)),
                          onPressed: () {},
                          child: Text('카카오 로그인하기'),
                        ),
                        // 회원가입 버튼
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '계정이 없으신가요?',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                // 약관 동의 모달 띄우기
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      CustomModalBottomSheet(),
                                );
                              },
                              child: Text(
                                '회원가입',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.grey,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
