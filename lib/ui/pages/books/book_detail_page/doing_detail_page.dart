import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';
import 'package:shelfy_team_project/ui/widgets/custom_interactive_star_rating.dart';
import 'package:shelfy_team_project/data/model/book_record_doing.dart';
import 'package:shelfy_team_project/ui/pages/books/widget/book_detail_progress_bar.dart';

import '../../../widgets/modal_bottom_sheet/book_record_state.dart';
import '../../../widgets/custom_record_label.dart';
import '../../../widgets/custom_star_rating.dart';
import '../widget/read_period.dart';

class DoingDetailPage extends StatefulWidget {
  final BookRecordDoing book;

  const DoingDetailPage({required this.book, super.key});

  @override
  _DoingDetailPageState createState() => _DoingDetailPageState();
}

class _DoingDetailPageState extends State<DoingDetailPage> {
  late DateTime startDate;

  @override
  void initState() {
    super.initState();
    startDate = widget.book.startDate;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: BooksAppBar(context),
        // body: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 20.0),
        //       child: ClipRRect(
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(3),
        //           topRight: Radius.circular(10),
        //           bottomLeft: Radius.circular(3),
        //           bottomRight: Radius.circular(10),
        //         ),
        //         child: Image.network(
        //           '${widget.book.book.book_image}',
        //           fit: BoxFit.fill,
        //           width: 150,
        //         ),
        //       ),
        //     ),
        //     InteractiveStarRating(
        //         type: 1, size: 25, onRatingChanged: (newRating) {}),
        //     const SizedBox(height: 15),
        //     Text(
        //       '${widget.book.book.book_title}',
        //       style: Theme.of(context).textTheme.headlineLarge,
        //     ),
        //     const SizedBox(height: 10),
        //     Text(
        //       '${widget.book.book.book_author} · ${widget.book.book.book_publisher}',
        //       style: Theme.of(context).textTheme.labelLarge,
        //     ),
        //     const SizedBox(height: 10),
        //     customRecordLabel(2),
        //     const SizedBox(height: 20),
        //
        //     // ListView를 스크롤 가능하도록 수정
        //     Expanded(
        //       child: ListView(
        //         children: [
        //           AdjustableProgressBar(
        //               totalPage: widget.book.book.book_page,
        //               currentPage: widget.book.currentPage),
        //           const SizedBox(height: 20),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //             child: Column(
        //               children: [
        //                 Row(
        //                   children: [
        //                     Icon(
        //                       FontAwesomeIcons.thumbtack,
        //                       color: Color(0xFF4D77B2),
        //                       size: 20,
        //                     ),
        //                     const SizedBox(width: 4),
        //                     Text('${dateCalculation(startDate)}일 동안 읽었어요.'),
        //                   ],
        //                 ),
        //                 ReadPeriod(
        //                   startDate: widget.book.startDate,
        //                   isDarkMode: isDarkMode,
        //                   // onDateChanged: () {},
        //                 ),
        //               ],
        //             ),
        //           ),
        //           const SizedBox(height: 20),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               children: [
        //                 Text('예상 별점'),
        //                 const SizedBox(width: 10),
        //                 customStarRating(3.5, 2, 18),
        //               ],
        //             ),
        //           ),
        //           const SizedBox(height: 30),
        //           Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 25.0),
        //             child: ElevatedButton(
        //               onPressed: () {
        //                 showModalBottomSheet(
        //                   context: context,
        //                   isScrollControlled: true, // 모달 크기 조정 가능하게 설정
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius:
        //                         BorderRadius.vertical(top: Radius.circular(16)),
        //                   ),
        //                   builder: (context) {
        //                     return Container(
        //                       height: MediaQuery.of(context).size.height *
        //                           0.51, // 50% 크기로 설정
        //                       child: BookRecordState(
        //                         book: widget.book.book,
        //                         index: 0,
        //                       ),
        //                     );
        //                   },
        //                 );
        //               },
        //               child: Text(
        //                 '여정이 끝났어요!',
        //                 style: TextStyle(color: Colors.white),
        //               ),
        //               style: ButtonStyle(
        //                 backgroundColor:
        //                     WidgetStatePropertyAll(const Color(0xFF4D77B2)),
        //                 fixedSize: WidgetStatePropertyAll(Size(300, 50)),
        //                 shape: WidgetStatePropertyAll(
        //                   RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(5),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //           const SizedBox(height: 20),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  int dateCalculation(DateTime startDate) {
    int period = DateTime.now().difference(startDate).inDays;
    return period;
  }
}
