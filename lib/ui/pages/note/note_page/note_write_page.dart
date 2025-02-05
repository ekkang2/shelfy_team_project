import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_write_body.dart';
import '../../../../data/gvm/note_gvm.dart';
import '../../../../data/model/note_model.dart';
import '../../../../providers/book_provider.dart';
import '../../../widgets/custom_appbar.dart';
import '../../main_screen.dart';

// 리버팟의 ConsumerWidget을 사용하면 위젯이 상태를 구독할 수 있음
class NoteWritePage extends ConsumerStatefulWidget {
  const NoteWritePage({super.key});

  @override
  _NoteWritePageState createState() => _NoteWritePageState();
}

class _NoteWritePageState extends ConsumerState<NoteWritePage> {
  final TextEditingController _titleController =
      TextEditingController(); // 제목 입력 컨트롤러
  final TextEditingController _contentController =
      TextEditingController(); // 내용 입력 컨트롤러

  // 글쓰기 완료 처리 함수 (AppBar & 기록 추가 버튼에서 공통 호출)
  Future<void> _handleNoteCompletion(BuildContext context) async {
    final title = _titleController.text;
    final content = _contentController.text;
    final selectedBook = ref.read(bookWriteProvider); // 선택한 책 정보 가져오기

    // 제목 & 내용 필수 체크
    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목과 내용을 모두 입력해주세요')),
      );
      return;
    }

    final note = Note(
      userId: 1, // 유저 ID (임시)
      title: title,
      content: content,
      bookId: selectedBook?['book_id'], // 선택한 책 ID (없으면 null)
    );
// TODO - initState로 새로고침 (뒤로 갈 때마다 새로고침)
    try {
      await ref.read(noteViewModelProvider.notifier).submitNote(note);
      print('✅ 노트 저장 성공! 메인으로 이동');

      // ✅ 키보드 완전히 닫기
      FocusScope.of(context).unfocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      // ✅ 현재 화면을 닫고, 메인 화면의 "노트 탭"으로 이동
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 3)),
        (route) => false, // 🔥 이전 스택 삭제 (뒤로 가기 시 작성 페이지로 안 돌아오게)
      );
    } catch (e) {
      print('❌ 노트 저장 실패: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('노트 저장 실패: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: NoteCustomAppBar(
        context: context,
        title: '글쓰기',
        actionText: '완료',
        onActionPressed: () =>
            _handleNoteCompletion(context), // ✅ 다이얼로그 동일하게 적용
      ),
      body: NoteWriteBody(
        titleController: _titleController,
        contentController: _contentController,
      ),
    );
  }
}
