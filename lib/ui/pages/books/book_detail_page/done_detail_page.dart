import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shelfy_team_project/_core/utils/size.dart';
import 'package:shelfy_team_project/data/model/record_model/record_response_model.dart';
import 'package:shelfy_team_project/ui/pages/books/widget/read_period.dart';
import 'package:shelfy_team_project/ui/widgets/custom_appbar.dart';
import 'package:shelfy_team_project/ui/widgets/custom_star_rating.dart';
import 'package:shelfy_team_project/ui/widgets/delete_button.dart';

import '../../../../data/gvm/record_view_model/record_view_model.dart';
import '../../../widgets/custom_record_label.dart';

class DoneDetailPage extends ConsumerStatefulWidget {
  final RecordResponseModel book;

  const DoneDetailPage({required this.book, super.key});

  @override
  ConsumerState<DoneDetailPage> createState() => _DoneDetailPageState();
}

class _DoneDetailPageState extends ConsumerState<DoneDetailPage> {
  late DateTime startDate;
  late DateTime endDate;
  bool isEditingComment = false; // 코멘트 편집 상태 관리
  late TextEditingController _commentController; // 코멘트 입력 필드 컨트롤러
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    startDate = widget.book.startDate ?? DateTime.now();
    endDate = widget.book.endDate ?? DateTime.now();
    _commentController = TextEditingController(text: widget.book.comment ?? '');
  }

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RecordViewModel vm = ref.watch(recordViewModelProvider.notifier);
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      // onTap: () {
      //   FocusScope.of(context).unfocus();
      // },
      child: SafeArea(
        child: Scaffold(
          appBar: BooksDetailAppBar(context, widget.book, 0),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(10),
                  ),
                  child: !widget.book.isMyBook!
                      ? Image.network(
                          height: 180,
                          fit: BoxFit.fill,
                          widget.book.bookImage!,
                        )
                      : Image.asset(
                          'assets/images/${widget.book.bookImage}',
                          fit: BoxFit.fill,
                          height: 180,
                        ),
                ),
              ),
              Container(
                  width: double.infinity,
                  child: customStarRating(widget.book.rating!, 1, 25)),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '${widget.book.bookTitle}',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${widget.book.bookAuthor} · ${widget.book.bookPublisher}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 10),
              customRecordLabel(1, isDarkMode),
              const SizedBox(height: 20),
              Divider(
                color: Colors.grey[300],
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    children: [
                      const SizedBox(height: 30),
                      ReadPeriod(
                        startDate: widget.book.startDate,
                        endDate: widget.book.endDate,
                        recordId: widget.book.recordId,
                        recordType: 1,
                        recordState: 1,
                        onDateChanged: (startDate, endDate) {},
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: widget.book.comment != null &&
                            widget.book.comment!.isNotEmpty,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isEditingComment = true;
                            });
                            Future.delayed(Duration(milliseconds: 100), () {
                              _focusNode.requestFocus();
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 타이틀
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.penClip,
                                    size: 15,
                                    color: !isDarkMode
                                        ? const Color(0xFF4D77B2)
                                        : Colors.grey[500],
                                  ),
                                  const SizedBox(width: 5),
                                  Text('나의 한 줄'),
                                ],
                              ),
                              const SizedBox(height: 6),

                              // 텍스트 박스 (보기 모드 / 편집 모드)
                              Container(
                                width: getScreenWidth(context),
                                padding: EdgeInsets.symmetric(
                                    horizontal: !isEditingComment ? 15 : 15,
                                    vertical: !isEditingComment ? 15 : 3),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: !isDarkMode
                                      ? Colors.grey[100]
                                      : Colors.grey[800],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: isEditingComment
                                    ? TextField(
                                        controller: _commentController,
                                        focusNode: _focusNode,
                                        maxLines: null,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        decoration: InputDecoration(
                                          hintText: '한줄평을 입력하세요...',
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          border: InputBorder.none, // 보더 제거
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      )
                                    : Text('\" ${widget.book.comment} \"',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                              ),

                              // 취소/저장 버튼 (텍스트 박스 아래)
                              if (isEditingComment)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditingComment = false;
                                          _commentController.text =
                                              widget.book.comment ??
                                                  ''; // 기존 값 유지
                                        });
                                      },
                                      child: Text(
                                        '취소',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        vm.updateRecordAttribute(
                                            recordType: 1,
                                            recordId: widget.book.recordId!,
                                            type: 2,
                                            comment: _commentController.text);
                                        setState(() {
                                          widget.book.comment =
                                              _commentController.text;
                                          isEditingComment = false;
                                        });
                                      },
                                      child: Text(
                                        '저장',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: deleteButton(
              context,
              () => vm.deleteRecord(stateId: widget.book.stateId!),
            ),
          ),
        ),
      ),
    );
  }
}
