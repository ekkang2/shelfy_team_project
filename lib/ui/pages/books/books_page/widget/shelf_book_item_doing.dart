import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shelfy_team_project/_core/utils/size.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import '../../book_detail_page/doing_detail_page.dart';

class ShelfBookItemDoing extends StatefulWidget {
  final RecordResponseModel doing;

  const ShelfBookItemDoing({required this.doing, Key? key}) : super(key: key);

  @override
  _ShelfBookItemDoingState createState() => _ShelfBookItemDoingState();
}

class _ShelfBookItemDoingState extends State<ShelfBookItemDoing>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: _calculateProgress(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  void _restartAnimation() {
    _animationController.reset();
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: _calculateProgress(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  double _calculateProgress() {
    if (widget.doing.bookPage == null || widget.doing.bookPage == 0) {
      return 0.0;
    }
    return (widget.doing.progress ?? 0) / widget.doing.bookPage!;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () async {
        // 페이지 이동 후 결과 감지
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoingDetailPage(book: widget.doing),
          ),
        );
        // 돌아오면 애니메이션 다시 실행
        _restartAnimation();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 100,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.network(
                  height: 105,
                  widget.doing.bookImage ?? '',
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            const SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: getDrawerWidth(context),
                  child: Text(
                    widget.doing.bookTitle ?? '제목 없음',
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${DateFormat('yyyy년 MM월 dd일').format(widget.doing.startDate ?? DateTime.now())}에 읽기 시작했어요',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 16),
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: !isDarkMode
                                ? Colors.grey[300]
                                : Colors.grey[800],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 5,
                          width: getDrawerWidth(context),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: !isDarkMode
                                ? const Color(0xFF6A9BE0)
                                : Colors.grey[500],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 5,
                          width: _progressAnimation.value *
                              getDrawerWidth(context),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  width: getDrawerWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(_calculateProgress() * 100).toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        '${widget.doing.progress}/${widget.doing.bookPage} page',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
