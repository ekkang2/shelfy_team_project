import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../../data/gvm/note_view_model/note_view_model.dart';
import '../../../../../data/model/note_model.dart';
import '../../../../../providers/book_provider.dart';
import '../../../main_screen.dart';
import 'note_book_Info.dart';
import '../../../../../ui/widgets/common_snackbar.dart';
import '../../../../../ui/widgets/common_dialog.dart';
import 'note_input_field.dart';

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

  Future<void> _handleNoteCompletion(BuildContext context) async {
    showConfirmationDialog(
      context: context,
      title: '노트 작성을 완료하시겠습니까?',
      confirmText: '확인',
      onConfirm: () async {
        if (Navigator.canPop(context)) Navigator.pop(context);

        FocusScope.of(context).unfocus();
        await Future.delayed(const Duration(milliseconds: 100));

        try {
          await _submitNote();
          CommonSnackbar.success(context, '노트가 성공적으로 등록되었습니다!');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => MainScreen(initialIndex: 3)),
                (route) => false,
              );
            }
          });
        } catch (e) {
          CommonSnackbar.error(context, '노트 저장 실패: $e');
        }
      },
      snackBarMessage: '',
    );
  }

  Future<void> _submitNote() async {
    await ref.read(noteViewModelProvider.notifier).submitNote(Note(
          title: widget.titleController.text.trim(),
          content: widget.contentController.text.trim(),
          userId: 1,
          bookId: ref.read(bookWriteProvider)?['book_id'],
          createdAt: '',
        ));
  }

  @override
  Widget build(BuildContext context) {
    final book = ref.watch(bookWriteProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    ref.listen<AsyncValue<void>>(noteViewModelProvider, (_, state) {
      state.when(
        data: (_) => CommonSnackbar.success(context, '노트가 성공적으로 등록되었습니다!'),
        error: (error, _) => CommonSnackbar.error(context, '노트 저장 실패: $error'),
        loading: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        ),
      );
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfoSection(),
          const SizedBox(height: 16),
          _buildNoteInputSection(isDarkMode),
          const SizedBox(height: 24),
          _buildBookInfoSection(book),
          const SizedBox(height: 16),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection() {
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

  Widget _buildNoteInputSection(bool isDarkMode) {
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

  Widget _buildBookInfoSection(Map<String, String>? book) {
    return NoteBookInfo(
      bookImage: book?['book_image'],
      bookTitle: book?['book_title'],
      bookAuthor: book?['book_author'],
      isEditMode: true,
      onAddPressed: () => _selectBook(),
      onChangePressed: () => _selectBook(),
      onDeletePressed: _deleteBook,
    );
  }

  Future<void> _selectBook() async {
    final selectedBook = await Navigator.pushNamed(context, '/noteAddBook');
    if (selectedBook is Map<String, String>) {
      ref.read(bookWriteProvider.notifier).state = selectedBook;
    }
  }

  void _deleteBook() => ref.read(bookWriteProvider.notifier).state = null;

  Widget _buildSubmitButton() {
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
