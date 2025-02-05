import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_write_body.dart';
import '../../../../data/gvm/note_gvm.dart';
import '../../../../data/model/note_model.dart';
import '../../../../providers/book_provider.dart';
import '../../../widgets/custom_appbar.dart';

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
  void _handleNoteCompletion() {
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
    ref.read(noteViewModelProvider.notifier).submitNote(note).then((_) {
      Navigator.pop(context); // 작성 완료 후 노트 목록으로 이동
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('노트 저장 실패: $e')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: NoteCustomAppBar(
        context: context,
        title: '글쓰기',
        actionText: '완료',
        onActionPressed: _handleNoteCompletion, // 다이얼로그 호출
      ),
      body: NoteWriteBody(
        titleController: _titleController,
        contentController: _contentController,
      ),
    );
  }
}
