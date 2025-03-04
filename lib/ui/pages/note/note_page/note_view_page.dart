import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_input_field.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';
import 'package:shelfy_team_project/providers/book_provider.dart';
import 'package:shelfy_team_project/ui/widgets/common_dialog.dart';
import 'package:shelfy_team_project/ui/widgets/common_snackbar.dart';
import 'package:shelfy_team_project/data/gvm/note_view_model/note_detail_view_model.dart';
import 'package:shelfy_team_project/ui/pages/note/note_page/widget/note_book_Info.dart';

import '../../../../data/gvm/note_view_model/note_list_view_model.dart';
import '../../../../data/gvm/note_view_model/note_view_model.dart';
import '../../../../data/model/book.dart';
import '../../../../data/model/note_model.dart';
import '../../../../providers/session_user_provider.dart';
import '../../main_screen.dart';

final logger = Logger();

class NoteViewPage extends ConsumerStatefulWidget {
  final int noteId;

  const NoteViewPage({super.key, required this.noteId});

  @override
  _NoteViewPageState createState() => _NoteViewPageState();
}

class _NoteViewPageState extends ConsumerState<NoteViewPage> {
  bool isEditMode = false;
  bool isUpdated = false; //  추가됨
  late TextEditingController contentController;
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController();
    titleController = TextEditingController();
  }

  @override
  void dispose() {
    contentController.dispose();
    titleController.dispose();
    super.dispose();
  }

  Future<void> deleteNote(WidgetRef ref, int noteId) async {
    try {
      await ref.read(noteRepositoryProvider).delete(id: noteId);
      ref.invalidate(noteListViewModelProvider);
      Navigator.pop(context); // 삭제 후 현재 화면 닫기
    } catch (e) {
      CommonSnackbar.error(context, "노트 삭제 실패: $e");
    }
  }

  Future<void> updateNoteInView(WidgetRef ref, Note updatedNote) async {
    try {
      await ref
          .read(noteRepositoryProvider)
          .update(updatedNote.noteId!, updatedNote.toJson());

      ref.invalidate(noteDetailViewModelProvider(updatedNote.noteId!));
      ref.invalidate(noteListViewModelProvider);

      final userId = getUserId(ref);
      if (userId > 0) {
        await ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
        ref.invalidate(noteListViewModelProvider); // ✅ 강제 무효화
      }

      setState(() {}); // ✅ UI 즉시 갱신
    } catch (e) {
      CommonSnackbar.error(context, "노트 업데이트 실패: $e");
    }
  }

  void _toggleBookmark() async {
    final currentNote =
        ref.read(noteDetailViewModelProvider(widget.noteId)).value;
    if (currentNote == null) return;

    final updatedPinStatus = !currentNote.notePin;

    try {
      await ref
          .read(noteRepositoryProvider)
          .updateNotePin(currentNote.noteId!, updatedPinStatus);

      setState(() {
        isUpdated = true; //  UI 변경 감지
      });

      ref.invalidate(noteDetailViewModelProvider(widget.noteId));

      //  유저 ID 가져오기
      final userId = getUserId(ref);
      if (userId != 0) {
        logger.d("유저 ID 확인됨: $userId - 리스트 새로고침 실행");
        ref.invalidate(noteListViewModelProvider);
        Future.microtask(() {
          ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
        });
      } else {
        logger.e("유저 정보 없음 리스트 새로고침 건너뜀");
      }
    } catch (e) {
      CommonSnackbar.error(context, '북마크 변경 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookData = ref.watch(bookViewProvider);
    final noteState = ref.watch(noteDetailViewModelProvider(widget.noteId));

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: NoteCustomAppBar(
          context: context,
          title: '글보기',
          actionText: isEditMode ? '저장' : '수정',
          onActionPressed: isEditMode ? _saveChanges : _showEditDialog,
        ),
        body: noteState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text("노트 불러오기 실패: $e")),
          data: (note) {
            if (note == null) {
              return const Center(child: Text("노트가 존재하지 않습니다."));
            }
            if (titleController.text.isEmpty || !isEditMode) {
              titleController.text = note.title; // 기존 제목 반영
            }
            if (contentController.text.isEmpty || !isEditMode) {
              contentController.text = note.content; // 기존 내용 반영
            }

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
                        _buildContentSection(context),
                        const SizedBox(height: 24),
                        if (note.bookId != null && note.bookId! > 0)
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

  Widget _buildContentSection(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isEditMode) _showEditDialog();
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
          isEditMode: isEditMode,
          maxLines: null,
        ),
      ),
    );
  }

  void _showEditDialog() {
    showConfirmationDialog(
      context: context,
      title: '수정 모드로 전환할까요?',
      confirmText: '편집',
      onConfirm: () {
        setState(() => isEditMode = true);
      },
      snackBarMessage: '편집 모드가 활성화되었습니다!',
    );
  }

  Future<void> _saveChanges() async {
    setState(() => isEditMode = false);

    final currentNote =
        ref.read(noteDetailViewModelProvider(widget.noteId)).value;
    if (currentNote == null) {
      CommonSnackbar.error(context, '노트 정보를 불러올 수 없습니다.');
      return;
    }

    final updatedNote = Note(
      noteId: currentNote.noteId,
      userId: currentNote.userId,
      title: titleController.text, // 제목 업데이트
      content: contentController.text, //  내용 업데이트
      bookId: currentNote.bookId,
      notePin: currentNote.notePin,
      createdAt: currentNote.createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );

    try {
      await updateNoteInView(ref, updatedNote); //  updateNote 호출 추가
      CommonSnackbar.success(context, '수정이 완료되었습니다!');

      // 최신 목록을 직접 가져옴
      final userId = getUserId(ref);
      if (userId > 0) {
        await ref.read(noteListViewModelProvider.notifier).fetchNotes(userId);
      }

      // 수정 완료 후, 노트 상세와 목록 Provider를 무효화할 필요가 있다면 invalidate도 실행 (선택 사항)
      ref.invalidate(noteDetailViewModelProvider(widget.noteId));

      //  수정 완료 후 뒤로 가기 (목록 화면으로 이동)
      Navigator.pop(context, true); // true 값을 전달하여 목록 화면 갱신 트리거
    } catch (e) {
      CommonSnackbar.error(context, '수정 실패: $e');
    }
  }

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
              Text(
                _getDisplayedDate(note), // 작성일 또는 수정일 출력
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              isEditMode
                  ? TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: '제목을 입력하세요',
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  : Text(
                      note.title, // ✅ 기존 제목 유지
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(note.notePin ? Icons.bookmark : Icons.bookmark_border),
          color: Colors.grey,
          onPressed: _toggleBookmark, //  북마크 버튼 동작 연결
        ),
      ],
    );
  }

  Widget _buildBookInfoSection(
      BuildContext context, Map<String, String>? bookData) {
    if (bookData == null) return const SizedBox.shrink();

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
          onDetailPressed: () {},
        ),
      ],
    );
  }

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
                snackBarMessage: '노트 삭제 완료!',
                snackBarIcon: Icons.delete_forever,
                snackBarType: 'success',
                onConfirm: () {
                  _deleteNote(ref, widget.noteId); //  ref와 noteId 전달
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _deleteNote(WidgetRef ref, int noteId) async {
    try {
      await deleteNote(ref, noteId); //  올바르게 deleteNote 호출

      //  현재 화면을 닫고, 메인 화면의 "노트 탭(3번 인덱스)"으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen(initialIndex: 3)),
      );
    } catch (e) {
      CommonSnackbar.error(context, '삭제 실패: $e');
    }
  }

  String _formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('yyyy년 MM월 dd일 EEEE', 'ko_KR').format(date);
    } catch (e) {
      return '날짜 정보 없음';
    }
  }

  // 노트에 표시할 날짜 결정 (수정 날짜가 있으면 수정 날짜, 없으면 작성 날짜)
  String _getDisplayedDate(Note note) {
    if (note.updatedAt != null && note.updatedAt!.isNotEmpty) {
      return "${_formatDate(note.updatedAt!)}"; // 수정된 날짜 출력
    }
    return "${_formatDate(note.createdAt)}"; // 작성 날짜 출력
  }
}
