// NoteViewPage.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_book_Info.dart';
import 'package:shelfy_team_project/providers/book_provider.dart';
import 'package:shelfy_team_project/ui/widgets/common_dialog.dart';
import 'package:shelfy_team_project/data/model/book.dart'; // ✅ Book 모델 import
import 'package:shelfy_team_project/ui/pages/search/search_page/widget/book_detail.dart'; // ✅ BookDetail import

class NoteViewPage extends ConsumerWidget {
  const NoteViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookData = ref.watch(bookViewProvider); // ✅ 책 데이터 Map 형태로 가져오기
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: NoteCustomAppBar(
          context: context,
          title: '글보기',
          actionText: '수정',
          onActionPressed: () {
            showConfirmationDialog(
              context: context,
              title: '노트 내용을 수정하시겠습니까?',
              confirmText: '확인',
              snackBarMessage: '수정되었습니다.',
              snackBarIcon: Icons.edit,
              snackBarColor: Colors.blue,
              onConfirm: () {
                print('노트 수정 시작');
              },
            );
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfoSection(context),
                const SizedBox(height: 16),
                _buildContentSection(context, isDarkMode),
                const SizedBox(height: 24),
                _buildBookInfoSection(
                    context, bookData), // ✅ 책 정보 섹션에 context 전달
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  // ✅ 책 정보 섹션 수정: 상세보기 아이콘 클릭 시 상세 페이지로 이동
  // 책 정보 섹션
  Widget _buildBookInfoSection(
      BuildContext context, Map<String, String>? bookData) {
    if (bookData == null) return const SizedBox.shrink();

    // ✅ book_id 필드 추가
    final book = Book(
      book_id: int.tryParse(bookData['book_id'] ?? '0') ?? 0, // 문자열을 정수로 변환
      book_image: bookData['book_image'] ?? '',
      book_title: bookData['book_title'] ?? '제목 없음',
      book_author: bookData['book_author'] ?? '저자 없음',
      book_publisher: bookData['book_publisher'] ?? '출판사 없음',
      book_desc: bookData['book_desc'] ?? '설명 없음',
      book_isbn: bookData['book_isbn'] ?? 'ISBN 없음',
      book_page: int.tryParse(bookData['book_page'] ?? '0') ?? 0,
      book_published_at:
          bookData['book_published_at'] ?? '출판일 정보 없음', // ✅ 필수 값 추가
    );
    return Column(
      children: [
        Center(child: Text('기록과 함께 하는 책', style: TextStyle(fontSize: 16))),
        const SizedBox(height: 8),
        NoteBookInfo(
          bookImage: book.book_image,
          bookTitle: book.book_title,
          bookAuthor: book.book_author,
          isEditMode: false,
          onDetailPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookDetail(book: book)),
            );
          },
        ),
      ],
    );
  }

  // 하단 삭제 버튼 (기존 유지)
  Widget _buildBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.grey),
            onPressed: () {
              showConfirmationDialog(
                context: context,
                title: '노트를 삭제하시겠습니까?',
                subtitle: '삭제한 기록은 복구할 수 없어요!',
                confirmText: '삭제',
                confirmTextColor: Colors.red,
                snackBarMessage: '삭제 완료!',
                snackBarIcon: Icons.delete_forever,
                snackBarColor: Colors.redAccent,
                onConfirm: () {
                  print('노트 삭제됨');
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // 사용자 정보 섹션 (기존 유지)
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
            const SizedBox(height: 4),
            Text('파과를 읽고', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }

  // 본문 내용 섹션 (기존 유지)
  Widget _buildContentSection(BuildContext context, bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: !isDarkMode ? Border.all(color: Colors.grey[300]!) : null,
        borderRadius: BorderRadius.circular(8),
        color: !isDarkMode ? Colors.grey[100] : Colors.grey[900],
      ),
      child: Text(
        '파과를 읽었다. 구병모 작가님 팬이 되었다.\n' * 10,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
