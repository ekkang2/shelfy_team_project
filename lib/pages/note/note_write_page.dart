import 'package:flutter/material.dart';
import 'package:shelfy_team_project/components/custom_appbar.dart';

class NoteWritePage extends StatelessWidget {
  const NoteWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: WriteAppBar(context),
        body: Text('data'),
      ),
    );
  }
}
