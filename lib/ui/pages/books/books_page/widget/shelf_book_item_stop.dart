import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shelfy_team_project/_core/utils/size.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import '../../book_detail_page/stop_detail_page.dart';
import '../../../../widgets/custom_star_rating.dart';

class ShelfBookItemStop extends StatelessWidget {
  final RecordResponseModel stop;

  const ShelfBookItemStop({required this.stop, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StopDetailPage(book: stop)),
        );
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    height: 105,
                    stop.bookImage!,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: getDrawerWidth(context),
                    child: Text(
                      stop.bookTitle!,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  customStarRating(stop.rating!, 1, 18),
                  const SizedBox(height: 10),
                  stop.comment != null
                      ? Container(
                          width: 270,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '${stop.comment}',
                            style: TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      : Container(height: 25),
                  const SizedBox(height: 3),
                  Container(
                    width: 270,
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '${DateFormat('yyyy년 MM월 dd일에 중단했어요.').format(stop.endDate!)}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
