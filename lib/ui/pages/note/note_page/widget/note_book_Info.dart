import 'package:flutter/material.dart';

class NoteBookInfo extends StatelessWidget {
  final String? bookImage;
  final String? bookTitle;
  final String? bookAuthor;
  final bool isEditMode;
  final VoidCallback? onAddPressed;
  final VoidCallback? onChangePressed;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onDetailPressed;

  const NoteBookInfo({
    super.key,
    this.bookImage,
    this.bookTitle,
    this.bookAuthor,
    this.isEditMode = false,
    this.onAddPressed,
    this.onChangePressed,
    this.onDeletePressed,
    this.onDetailPressed,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 책이 없고 글쓰기 모드일 때: "책 추가" 버튼 표시
    if (bookTitle == null && isEditMode) {
      return _buildAddBookSection(context);
    }

    // 2. 책이 없고 글보기 모드일 때: 아무것도 표시 안 함
    if (bookTitle == null) return const SizedBox.shrink();

    // 3. 책이 있을 때: 정보 표시
    return _buildBookInfoSection(context);
  }

// 책 추가 섹션 (글쓰기 모드에서 책 없을 때)
  Widget _buildAddBookSection(BuildContext context) {
    return Row(
      children: [
        _bookImagePlaceholder(), // 이미지 부분 따로 함수로 분리
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('책을 추가해주세요',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              IconButton(
                onPressed: onAddPressed,
                icon: Icon(Icons.add_box,
                    size: 28, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }

// 책 이미지 없을 때 플레이스홀더
  Widget _bookImagePlaceholder() {
    return Container(
      width: 50,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.book, color: Colors.white),
    );
  }

// 책 정보 섹션 (책 있을 때)
  Widget _buildBookInfoSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBookImage(), // 이미지 함수 분리
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bookTitle ?? '',
                  style: Theme.of(context).textTheme.titleMedium),
              Text(bookAuthor ?? '',
                  style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ),
        _buildActionButtons(context), // 액션 버튼 함수 분리
      ],
    );
  }

// 책 이미지 표시
  Widget _buildBookImage() {
    return Container(
      width: 50,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: bookImage != null
            ? DecorationImage(
                image: NetworkImage(bookImage!), fit: BoxFit.cover)
            : null,
        color: bookImage == null ? Colors.grey[300] : null,
      ),
    );
  }

// 액션 버튼 (글쓰기 모드: 변경/삭제, 글보기 모드: 상세보기)
  Widget _buildActionButtons(BuildContext context) {
    return isEditMode
        ? Row(
            children: [
              IconButton(
                  icon: Icon(Icons.refresh, size: 20, color: Colors.grey),
                  onPressed: onChangePressed),
              IconButton(
                  icon: Icon(Icons.delete, size: 20, color: Colors.grey),
                  onPressed: onDeletePressed),
            ],
          )
        : IconButton(
            icon: Icon(Icons.text_snippet,
                size: 20, color: Theme.of(context).colorScheme.primary),
            onPressed: onDetailPressed);
  }
}
