import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_input_field.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';
import 'package:shelfy_team_project/providers/book_provider.dart';
import 'package:shelfy_team_project/ui/widgets/common_dialog.dart';
import 'package:shelfy_team_project/data/model/book.dart';
import 'package:shelfy_team_project/data/gvm/note_view_model/note_detail_view_model.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_book_Info.dart';

import '../../../../data/model/note_model.dart';
import '../../../widgets/common_snackbar.dart';
import '../../search/search_page/widget/book_detail.dart';

class NoteViewPage extends ConsumerStatefulWidget {
  final int noteId; // ✅ noteId만 받음

  const NoteViewPage({super.key, required this.noteId});

  @override
  _NoteViewPageState createState() => _NoteViewPageState();
}

class _NoteViewPageState extends ConsumerState<NoteViewPage> {
  bool isEditMode = false; // ✅ 수정 가능 여부 상태 추가
  late TextEditingController contentController; // ✅ 내용 컨트롤러 추가

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController(); // ✅ 컨트롤러 초기화
  }

  @override
  void dispose() {
    contentController.dispose(); // ✅ 메모리 정리
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookData = ref.watch(bookViewProvider);
    final noteState = ref.watch(noteDetailViewModelProvider(widget.noteId));
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: NoteCustomAppBar(
          context: context,
          title: '글보기',
          actionText: isEditMode ? '저장' : '수정',
          onActionPressed:
              isEditMode ? _saveChanges : _showEditDialog, // ✅ 수정 or 저장
        ),
        body: noteState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("노트 불러오기 실패: $e")),
          data: (note) {
            if (note == null)
              return const Center(child: Text("노트가 존재하지 않습니다."));

            contentController.text = note.content; // ✅ 내용 업데이트

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserInfoSection(context, note),
                        const SizedBox(height: 16),
                        _buildContentSection(context), // ✅ 수정 가능
                        const SizedBox(height: 24),
                        if (note.bookId != null && note.bookId!.isNotEmpty)
                          _buildBookInfoSection(context, bookData),
                      ],
                    ),
                  ),
                ),
                _buildBottomBar(context),
              ],
            );
          },
        ),
      ),
    );
  }

  // ✅ 본문 내용 섹션 (터치하면 수정 다이얼로그 표시)
  Widget _buildContentSection(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isEditMode) _showEditDialog(); // ✅ 수정 여부 다이얼로그 표시
      },
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 300),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[100],
        ),
        child: NoteInputField(
          controller: contentController,
          hintText: '내용 없음',
          isEditMode: isEditMode, // ✅ 상태에 따라 편집 가능
          maxLines: null,
        ),
      ),
    );
  }

  // ✅ 수정 여부 다이얼로그
  void _showEditDialog() {
    showConfirmationDialog(
      context: context,
      title: '이 노트를 수정할까요?',
      confirmText: '편집',
      onConfirm: () {
        setState(() => isEditMode = true); // ✅ 수정 가능 모드 활성화
      },
      snackBarMessage: '편집 모드가 활성화되었습니다',
    );
  }

  void _saveChanges() {
    setState(() => isEditMode = false); // ✅ 편집 모드 종료
    CommonSnackbar.success(context, '수정이 완료되었습니다!'); // ✅ 공통 스낵바 사용
    print('✅ 변경된 내용 저장!');
  }

// ✅ 날짜 포맷 변환 함수
  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('yyyy년 MM월 dd일 EEEE', 'ko_KR').format(date);
    } catch (e) {
      return '날짜 정보 없음';
    }
  }

// ✅ 사용자 정보 섹션 (북마크 아이콘 추가)
  Widget _buildUserInfoSection(BuildContext context, Note note) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage('assets/images/profile_default.png'),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_formatDate(note.createdAt), // ✅ 날짜 포맷 적용
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 4),
              Text(note.title, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        IconButton(
          icon: Icon(note.notePin ? Icons.bookmark : Icons.bookmark_border),
          color: Colors.grey,
          onPressed: () {
            print("북마크 토글: ${note.notePin}");
          },
        ),
      ],
    );
  }

// ✅ 책 정보 섹션 (DB에서 note_r_state_id가 null이면 렌더링 안 함)
  Widget _buildBookInfoSection(
      BuildContext context, Map<String, String>? bookData) {
    if (bookData == null) return const SizedBox.shrink(); // ✅ 아무것도 렌더링하지 않음

    final book = Book(
      book_id: int.tryParse(bookData['book_id'] ?? '0') ?? 0,
      book_image: bookData['book_image'] ?? '',
      book_title: bookData['book_title'] ?? '제목 없음',
      book_author: bookData['book_author'] ?? '저자 없음',
      book_publisher: bookData['book_publisher'] ?? '출판사 없음',
      book_desc: bookData['book_desc'] ?? '설명 없음',
      book_isbn: bookData['book_isbn'] ?? 'ISBN 없음',
      book_page: int.tryParse(bookData['book_page'] ?? '0') ?? 0,
      book_published_at: bookData['book_published_at'] ?? '출판일 정보 없음',
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

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _saveChanges(),
      child: const Text('수정 완료'),
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
                snackBarMessage: '삭제 완료!',
                snackBarIcon: Icons.delete_forever,
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
}
