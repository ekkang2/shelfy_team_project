import 'package:flutter/material.dart';
import 'package:shelfy_team_project/components/custom_appbar.dart';

class NoteViewPage extends StatefulWidget {
  const NoteViewPage({super.key});

  @override
  State<NoteViewPage> createState() => _NoteViewPageState();
}

class _NoteViewPageState extends State<NoteViewPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool isBookmarked = false; // ✅ 북마크 상태 추가

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '파과를 읽고'); // ✅ 더미 제목
    _contentController = TextEditingController(
      text: '파과를 읽었다. 구병모 작가님 팬이 되었다.\n' * 20, // ✅ 긴 본문
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: ViewAppBar(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '2025년 1월 22일 수요일',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: _titleController, // ✅ 제목 유지
                          style: Theme.of(context).textTheme.titleMedium,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: isBookmarked ? Colors.amber : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isBookmarked = !isBookmarked;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                  child: TextFormField(
                    controller: _contentController, // ✅ 본문 유지
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    maxLines: null, // ✅ 여러 줄 입력 가능
                    expands: true, // ✅ 컨테이너 크기에 맞게 확장
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  '기록과 함께 하는 책',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '책 제목 표시',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: () {
                            print("책 상세 정보 보기");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onPressed: () {
                  print("노트 삭제됨");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
