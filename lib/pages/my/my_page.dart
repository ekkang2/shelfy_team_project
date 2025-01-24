import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shelfy_team_project/theme.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildProfile(),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '유저 설정',
                      style: textTheme().labelMedium,
                    ),
                  ),
                  buildMyListTile(
                    icon: Icons.person,
                    context: context,
                    text: '프로필 설정',
                    url: '/profile',
                  ),
                  buildMyListTile(
                    icon: Icons.file_download_sharp,
                    context: context,
                    text: '독서기록 내보내기',
                    url: '/profile',
                  ),
                  buildMyListTile(
                    icon: Icons.palette,
                    context: context,
                    text: '컬러·폰트 설정',
                    url: '/profile',
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.dark_mode,
                      color: Colors.grey[600],
                    ),
                    title: Text(
                      '다크모드',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    // trailing: Switch(
                    //   value: _isChecked,
                    //   onChanged: (value) {},
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '지원',
                      style: textTheme().labelMedium,
                    ),
                  ),
                  buildMyListTile(
                    icon: CupertinoIcons.question_circle_fill,
                    context: context,
                    text: '자주 묻는 질문',
                    url: '/faq',
                  ),
                  buildMyListTile(
                    icon: Icons.mail_rounded,
                    context: context,
                    text: '문의하기',
                    url: '/inquiry',
                  ),
                  buildMyListTile(
                    icon: Icons.chat_bubble,
                    context: context,
                    text: '의견 보내기',
                    url: '/sendOpinion',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '앱 정보',
                      style: textTheme().labelMedium,
                    ),
                  ),
                  buildMyListTile(
                    icon: CupertinoIcons.question_circle_fill,
                    context: context,
                    text: '평점 남기기',
                    url: '/rateApp',
                  ),
                  buildMyListTile(
                    icon: CupertinoIcons.person_3_fill,
                    context: context,
                    text: '팀 소개',
                    url: '/introduceTeam',
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      Icons.library_books_sharp,
                      color: Colors.grey[600],
                    ),
                    title: Text(
                      '서비스 이용약관',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: null,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildMyListTile({
    required IconData icon,
    required BuildContext context,
    required String text,
    required String url,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: Colors.grey[600],
      ),
      title: Text(
        text,
        style: TextStyle(color: Colors.grey[600]),
      ),
      onTap: () {
        Navigator.pushNamed(context, url);
      },
    );
  }

  Column buildProfile() {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            'assets/images/profile_default.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            '닉네임',
            style: textTheme().titleLarge,
          ),
        ),
      ],
    );
  }
}
