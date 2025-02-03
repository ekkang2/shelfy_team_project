import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_book_Info.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';
import 'package:shelfy_team_project/providers/book_provider.dart';
import 'package:shelfy_team_project/ui/widgets/common_dialog.dart'; // 공통 다이얼로그 import

// 리버팟의 ConsumerWidget을 사용하면 위젯이 상태를 구독할 수 있음
class NoteWritePage extends ConsumerWidget {
  const NoteWritePage({super.key});

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

  // 글쓰기 완료 처리 함수 (AppBar & 기록 추가 버튼에서 공통 호출)
  void _handleNoteCompletion(BuildContext context) {
    showConfirmationDialog(
      context: context,
      title: '노트 작성을 완료하시겠습니까?',
      confirmText: '확인',
      snackBarMessage: '노트가 등록되었습니다.', // 등록 완료 메시지
      snackBarIcon: Icons.check_circle, // 등록 아이콘
      snackBarColor: Theme.of(context).colorScheme.primary, // 테마의 주요 색상 적용
      onConfirm: () {
        print('글쓰기 완료 처리'); // 글쓰기 완료 처리 로직 추가
      },
    );
  }

  // build 함수: 화면에 위젯을 렌더링하는 부분
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
          onActionPressed: () => _handleNoteCompletion(context), // 공통 함수 호출
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
                _buildBookInfoSection(context, ref, book), // 선택한 책 정보 표시
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomButton(context), // 기록 추가 버튼
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
  Widget _buildBottomButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () => _handleNoteCompletion(context), // 글쓰기 완료 공통 함수 호출
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text('기록 추가', style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}
