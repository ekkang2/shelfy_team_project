import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfy_team_project/data/gvm/record_view_model/record_view_model.dart';
import 'package:shelfy_team_project/ui/widgets/custom_elevated_button.dart';

import '../../../data/model/book_model/book.dart';
import '../custom_interactive_star_rating.dart';

class WishRecordStateTab extends ConsumerStatefulWidget {
  String bookId;
  String bookTitle;
  int bookPage;

  WishRecordStateTab({
    required this.bookId,
    required this.bookTitle,
    required this.bookPage,
    super.key,
  });

  @override
  _WishRecordStateTabState createState() => _WishRecordStateTabState();
}

class _WishRecordStateTabState extends ConsumerState<WishRecordStateTab> {
  double _rating = 0.0; // ⭐ 기대지수 (별점)
  final TextEditingController _commentController =
      TextEditingController(); // 📝 기대평

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final vm = ref.read(recordViewModelProvider.notifier);

    return Column(
      children: [
        // 스크롤 가능한 콘텐츠
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 25),
              Center(
                child: Text(
                  '이 책이 궁금하군요!',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'JUA',
                    color: !isDarkMode
                        ? const Color(0xFF4D77B2)
                        : Colors.grey[350],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '기대지수와 기대평을 남겨볼까요?',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),

              // ⭐ 기대지수 (별점)
              InteractiveStarRating(
                type: 2,
                size: 25,
                onRatingChanged: (newRating) {
                  setState(() {
                    _rating = newRating;
                  });
                },
              ),
              const SizedBox(height: 30),

              // 기대평 타이틀
              Text(
                '기대평',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),

              // 기대평 입력창
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: !isDarkMode ? Colors.grey[100] : Colors.grey[900],
                ),
                child: TextField(
                  controller: _commentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: '이 책에 대한 기대감을 적어보세요!',
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(' 이 책을 다 읽으면'),
                  Text(
                    ' ${(widget.bookPage * 0.01).toStringAsFixed(1)} cm',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Text(' 높아져요!'),
                ],
              ),
            ],
          ),
        ),

        // 하단 고정 저장 버튼
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
          child: SizedBox(
            width: double.infinity,
            child: customElevatedButton(
              isDarkMode: isDarkMode,
              text: '저장',
              onPressed: () {
                vm.createRecord(
                  bookId: widget.bookId,
                  stateType: 3,
                  startDate: DateTime.now(),
                  comment: _commentController.text,
                  rating: _rating,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
