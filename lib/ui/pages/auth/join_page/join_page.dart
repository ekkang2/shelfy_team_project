import 'package:flutter/material.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BasicAppBar(context, '회원가입'),
        body: Column(),
      ),
    );
  }
}
