import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_book_Info.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';
import 'package:shelfy_team_project/providers/book_provider.dart';
import 'package:shelfy_team_project/ui/widgets/common_dialog.dart';
import 'package:shelfy_team_project/ui/widgets/common_snackbar.dart';
import 'package:dio/dio.dart';

// 리버팟의 ConsumerWidget을 사용하면 위젯이 상태를 구독할 수 있음
class NoteWritePage extends ConsumerWidget {
  NoteWritePage({super.key});

  final Dio _dio = Dio(); // Dio 인스턴스 생성

  // 제목 & 내용 입력을 위한 컨트롤러 추가
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  // 책을 선택하는 함수 (책 추가/변경 시 호출됨)
  Future<void> selectBook(BuildContext context, WidgetRef ref) async {
    // '/noteAddBook' 페이지로 이동하여 책을 선택한 후 결과를 받아옴
    final selectedBook = await Navigator.pushNamed(context, '/noteAddBook');

    // 선택된 책의 데이터가 있으면 상태 업데이트
    if (selectedBook is Map<String, String>) {
      ref.read(bookWriteProvider.notifier).state = selectedBook;
      // bookProvider.notifier: 상태를 업데이트하는 관리자를 의미
      // .state = selectedBook: 상태를 새로 선택한 책으로 업데이트
    }
  }

  // 선택된 책 삭제 함수
  void deleteBook(WidgetRef ref) {
    ref.read(bookWriteProvider.notifier).state = null;
    // 상태를 null로 초기화 (책 삭제)
  }

  // // 글쓰기 완료 처리 함수 (AppBar & 기록 추가 버튼에서 공통 호출)
  void _handleNoteCompletion(BuildContext context, WidgetRef ref) {
    showConfirmationDialog(
      context: context,
      title: '노트 작성을 완료하시겠습니까?', // 다이얼로그 제목
      confirmText: '확인', // 확인 버튼
      snackBarMessage: '노트가 등록되었습니다.', // 성공 시 표시될 스낵바 메시지
      snackBarIcon: Icons.check_circle, // 성공 아이콘
      snackBarColor: Theme.of(context).primaryColor, // 성공 색상
      onConfirm: () => _submitNote(context, ref), //  ✅ 다이얼로그 확인 시 API 호출
    );
  }

  // ✅ 노트 작성 API 호출 (Dio 사용)
  Future<void> _submitNote(BuildContext context, WidgetRef ref) async {
    final title = _titleController.text;
    final content = _contentController.text;
    final selectedBook = ref.read(bookWriteProvider); // 선택한 책 정보 가져오기

    // 제목 & 내용 필수 체크
    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('제목과 내용을 모두 입력해주세요')),
      );
      return;
    }

    try {
      // 서버로 데이터 전송 (POST 요청)
      final response = await _dio.post(
        // 'http://localhost:8082/api/note', // 노트 작성 API URL
        'http://10.0.2.2:8082/api/note', // 에뮬레이터 환경에서는 localhost 대신 10.0.2.2 사용
        data: {
          "noteUserId": 1, // 유저 ID (임시)
          "noteTitle": title,
          "noteContents": content,
          "noteRStateId": selectedBook?['book_id'], // 선택한 책 ID (없으면 null)
          "notePin": false,
          // "noteCategory": "일상 기록", // 카테고리 나중에 구현
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 200(OK) 또는 201(Created)일 때 성공 처리
        Navigator.pop(context); // 노트 목록으로 이동
      } else {
        // 서버 응답 실패 시
        CommonSnackbar.error(context, '노트 저장 실패: ${response.statusCode}');
      }
    } catch (e) {
      // 에러 발생 시 알림 표시
      CommonSnackbar.error(context, '에러 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookWriteProvider); // 글쓰기용 상태 구독
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: NoteCustomAppBar(
          context: context,
          title: '글쓰기',
          actionText: '완료',
          onActionPressed: () =>
              _handleNoteCompletion(context, ref), // ✅ 다이얼로그 호출
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfoSection(context),
                const SizedBox(height: 16),
                _buildNoteInputSection(context, isDarkMode),
                const SizedBox(height: 24),
                _buildBookInfoSection(context, ref, book), // ✅ 선택한 책 정보 표시
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomButton(context, ref), // ✅ 기록 추가 버튼
      ),
    );
  }

  // 사용자 정보 섹션
  Widget _buildUserInfoSection(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/profile_default.png'),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('2025년 1월 22일 수요일',
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _titleController, // ✅ 제목 입력 필드
                decoration: InputDecoration(
                  hintText: '제목을 입력해주세요',
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 메모 입력 섹션
  Widget _buildNoteInputSection(BuildContext context, bool isDarkMode) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: !isDarkMode ? Border.all(color: Colors.grey[300]!) : null,
        borderRadius: BorderRadius.circular(8),
        color: !isDarkMode ? Colors.grey[100] : Colors.grey[900],
      ),
      child: TextField(
        controller: _contentController, // ✅ 내용 입력 필드
        decoration: InputDecoration(
          hintText: '오늘 기록할 조각을 남겨주세요.',
          hintStyle: Theme.of(context).textTheme.labelMedium,
          border: InputBorder.none,
        ),
        maxLines: null, // 여러 줄 입력 가능
      ),
    );
  }

  // 책 정보 섹션 (선택한 책의 정보 표시 및 추가/변경/삭제 기능)
  Widget _buildBookInfoSection(
      BuildContext context, WidgetRef ref, Map<String, String>? book) {
    return Column(
      children: [
        Center(
            child: Text('기록과 함께 하는 책',
                style: Theme.of(context).textTheme.labelLarge)),
        const SizedBox(height: 8),
        NoteBookInfo(
          bookImage: book?['book_image'],
          bookTitle: book?['book_title'],
          bookAuthor: book?['book_author'],
          isEditMode: true, // 글쓰기 모드에서는 변경/삭제 가능
          onAddPressed: () => selectBook(context, ref), // 책 추가 버튼 클릭 시
          onChangePressed: () => selectBook(context, ref), // 책 변경 버튼 클릭 시
          onDeletePressed: () => deleteBook(ref), // 책 삭제 버튼 클릭 시
        ),
      ],
    );
  }

  // 기록 추가 버튼 (클래스 내부로 옮겨서 공통 함수 호출)
  Widget _buildBottomButton(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () => _handleNoteCompletion(context, ref), // ✅ 다이얼로그 호출
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text('기록 추가', style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}
