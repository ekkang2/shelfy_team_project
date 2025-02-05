import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../data/gvm/note_gvm.dart'; // ViewModel
import '../../../../../data/model/note_model.dart';
import '../../../../../providers/book_provider.dart';
import 'note_book_Info.dart';
import '../../../../../ui/widgets/common_snackbar.dart';
import '../../../../../ui/widgets/common_dialog.dart'; // 다이얼로그 컴포넌트
import 'note_input_field.dart'; // 입력 필드 컴포넌트

class NoteWriteBody extends ConsumerStatefulWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;

  const NoteWriteBody({
    super.key,
    required this.titleController,
    required this.contentController,
  });

  @override
  _NoteWriteBodyState createState() => _NoteWriteBodyState();
}

class _NoteWriteBodyState extends ConsumerState<NoteWriteBody> {
  bool isFormValid = false;
  late String currentDate;

  @override
  void initState() {
    super.initState();
    currentDate =
        DateFormat('yyyy년 MM월 dd일 EEEE', 'ko_KR').format(DateTime.now());

    widget.titleController.addListener(_validateForm);
    widget.contentController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      isFormValid = widget.titleController.text.trim().isNotEmpty &&
          widget.contentController.text.trim().isNotEmpty;
    });
  }

  Future<void> selectBook(BuildContext context) async {
    final selectedBook = await Navigator.pushNamed(context, '/noteAddBook');
    if (selectedBook is Map<String, String>) {
      ref.read(bookWriteProvider.notifier).state = selectedBook;
    }
  }

  void deleteBook() => ref.read(bookWriteProvider.notifier).state = null;

  // ✅ 다이얼로그로 글쓰기 완료 처리
  void _handleNoteCompletion(BuildContext context) {
    showConfirmationDialog(
      context: context,
      title: '노트 작성을 완료하시겠습니까?',
      confirmText: '확인',
      onConfirm: _submitNoteViaViewModel, // 다이얼로그 확인 시 ViewModel 호출
      snackBarMessage: '',
    );
  }

  // ✅ ViewModel을 통한 API 요청
  void _submitNoteViaViewModel() {
    final noteViewModel = ref.read(noteViewModelProvider.notifier);
    final note = Note(
      title: widget.titleController.text.trim(),
      content: widget.contentController.text.trim(),
      userId: 1,
      bookId: null, // ㅠㅠ 언제다하지? 아자
    );

    noteViewModel.submitNote(note);
  }

  @override
  Widget build(BuildContext context) {
    final book = ref.watch(bookWriteProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // ✅ ViewModel 상태 구독 및 UI 처리
    // ✅ ViewModel 상태 구독 및 UI 처리
    ref.listen<AsyncValue<void>>(noteViewModelProvider, (prevState, state) {
      state.when(
        data: (_) {
          // ✅ 성공 시 스낵바 1회 표시 후 페이지 이동 (딜레이 추가)
          CommonSnackbar.success(context, '노트가 성공적으로 등록되었습니다!');

          // TODO - initState로 새로고침 (뒤로 갈 때마다 새로고침)
          // Future.delayed(const Duration(seconds: 1), () {
          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => const MainScreen(initialIndex: 3)),
          //         (route) => false,
          //   );
          // });
        },
        loading: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        },
        error: (error, _) {
          Navigator.of(context).pop(); // 로딩 다이얼로그 닫기
          CommonSnackbar.error(context, '노트 저장 실패: $error');
        },
      );
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfoSection(context),
          const SizedBox(height: 16),
          _buildNoteInputSection(context, isDarkMode),
          const SizedBox(height: 24),
          _buildBookInfoSection(context, book),
          const SizedBox(height: 16),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    return Row(
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
              Text(currentDate, style: Theme.of(context).textTheme.bodyMedium),
              NoteInputField(
                controller: widget.titleController,
                hintText: '제목을 입력해주세요',
                isEditMode: true,
                isTitle: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNoteInputSection(BuildContext context, bool isDarkMode) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: !isDarkMode ? Border.all(color: Colors.grey[300]!) : null,
        borderRadius: BorderRadius.circular(8),
        color: !isDarkMode ? Colors.grey[100] : Colors.grey[900],
      ),
      child: NoteInputField(
        controller: widget.contentController,
        hintText: '오늘 기록할 조각을 남겨주세요.',
        isEditMode: true,
        maxLines: null,
      ),
    );
  }

  Widget _buildBookInfoSection(
      BuildContext context, Map<String, String>? book) {
    return NoteBookInfo(
      bookImage: book?['book_image'],
      bookTitle: book?['book_title'],
      bookAuthor: book?['book_author'],
      isEditMode: true,
      onAddPressed: () => selectBook(context),
      onChangePressed: () => selectBook(context),
      onDeletePressed: deleteBook,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: isFormValid ? () => _handleNoteCompletion(context) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isFormValid ? Theme.of(context).colorScheme.primary : Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text('기록 추가', style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}
