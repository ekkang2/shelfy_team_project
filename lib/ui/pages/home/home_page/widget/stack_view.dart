import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shelfy_team_project/data/model/book.dart';
import 'package:shelfy_team_project/pages/search/components/book_item.dart';

import 'shef_view_list.dart';

class StackView extends StatefulWidget {
  const StackView({super.key});

  @override
  State<StackView> createState() => _StackViewState();
}

class _StackViewState extends State<StackView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 이미지
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Shelfy_appSize3.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 블러 효과
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: Container(
            color: Colors.black.withOpacity(0.1),
          ),
        ),

        // 내용 위젯
      ],
    );
  }
}
