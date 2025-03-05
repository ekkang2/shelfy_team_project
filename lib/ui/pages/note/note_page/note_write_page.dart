import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_write_body.dart';
import 'package:shelfy_team_project/_core/utils/logger.dart' as log;
import '../../../../data/gvm/note_view_model/note_view_model.dart';
import '../../../../data/gvm/user_view_model/session_view_model.dart';
import '../../../../data/model/note_model.dart';
import '../../../../providers/book_provider.dart';
import '../../../widgets/common_snackbar.dart';
import '../../../widgets/custom_appbar.dart';
import '../../main_screen.dart';
import '../../../../providers/session_user_provider.dart'; //  세션 유저 불러오기

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

    // sessionProvider를 사용해 로그인한 유저 ID를 가져옴
    // (만약 sessionProvider가 아닌 sessionUserProvider가 맞다면, 해당 provider 내부에서 올바른 ID가 들어가도록 수정해야 합니다.)
    final userId = ref.read(sessionProvider).id ?? 0;
    log.logger.d("NoteWritePage - userId: $userId"); //  충돌 방지

    // 제목 & 내용 필수 체크
    if (title.isEmpty || content.isEmpty) {
      CommonSnackbar.warning(
          context, '제목과 내용을 모두 입력해주세요'); //  CommonSnackbar 사용
      return;
    }

    final note = Note(
      noteId: null, //  새 노트 작성 시에는 ID 없음
      userId: userId, //  로그인한 유저 ID 사용 (없으면 1)
      title: title,
      content: content,
      bookId: selectedBook?['book_id'] != null
          ? int.tryParse(selectedBook!['book_id']!)
          : null,
      createdAt: '',
    );

    try {
      await ref.read(noteViewModelProvider.notifier).submitNote(note);

      //  키보드 완전히 닫기
      FocusScope.of(context).unfocus();
      SystemChannels.textInput.invokeMethod('TextInput.hide');

      //  현재 화면을 닫고, 메인 화면의 "노트 탭"으로 이동
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 3)),
        (route) => false, // 이전 스택 삭제 (뒤로 가기 시 작성 페이지로 안 돌아오게)
      );
    } catch (e) {
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
        onActionPressed: () => _handleNoteCompletion(context), //  다이얼로그 동일하게 적용
      ),
      body: NoteWriteBody(
        titleController: _titleController,
        contentController: _contentController,
      ),
    );
  }
}
