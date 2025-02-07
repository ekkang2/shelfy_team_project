import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/record_view_model/record_view_model.dart';
import 'package:shelfy_team_project/ui/widgets/custom_elevated_button.dart';

import '../../../data/model/book_model/book.dart';
import '../../pages/books/widget/book_detail_progress_bar.dart';

class DoingRecordStateTab extends ConsumerStatefulWidget {
  final Book book;
  const DoingRecordStateTab({required this.book, super.key});

  @override
  _DoingRecordStateTabState createState() => _DoingRecordStateTabState();
}

class _DoingRecordStateTabState extends ConsumerState<DoingRecordStateTab> {
  int _progress = 0; // ✅ 읽은 페이지 수 저장
  final ScrollController _scrollController = ScrollController(); // 스크롤 컨트롤러

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final vm = ref.read(recordViewModelProvider.notifier);

    return ListView(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text(
                '${widget.book.bookTitle!}을 읽고 있어요',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'JUA',
                  color:
                      !isDarkMode ? const Color(0xFF4D77B2) : Colors.grey[350],
                ),
              ),
              Text(
                '현재 페이지를 기록해 볼까요?',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ✅ AdjustableProgressBar에서 _progress 값 가져오기
        AdjustableProgressBar(
          totalPage: widget.book.bookPage!,
          currentPage: _progress,
          onProgressChanged: (newProgress) {
            setState(() {
              _progress = newProgress;
            });
          },
        ),

        const SizedBox(height: 20),

        // 📌 저장 버튼
        customElevatedButton(
          isDarkMode: isDarkMode,
          text: '저장',
          onPressed: () {
            vm.createRecord(
              bookId: widget.book.bookId!,
              stateType: 2, // ✅ "읽고 있는 책" 상태
              startDate: DateTime.now(),
              progress: _progress, // ✅ 읽은 페이지 수 전송
            );
          },
        ),
      ],
    );
  }
}
