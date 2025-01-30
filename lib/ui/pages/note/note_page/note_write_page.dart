import 'package:flutter/material.dart';
import 'package:shelfy_team_project/components/custom_appbar.dart';

class NoteWritePage extends StatelessWidget {
  const NoteWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController =
        ScrollController(); // 스크롤 컨트롤러 추가

    return SafeArea(
      child: Scaffold(
        // 키보드 올라와도 UI 깨지지 않도록 설정
        resizeToAvoidBottomInset: false, // 키보드가 떠도 레이아웃이 유지되면서 입력창이 밀리지 않음
        appBar: WriteAppBar(context),
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
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '제목을 입력해주세요',
                            hintStyle: Theme.of(context).textTheme.labelMedium,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300, // 높이 조정
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                  child: Scrollbar(
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '오늘 기록할 조각을 남겨주세요.',
                          hintStyle: Theme.of(context).textTheme.labelMedium,
                          border: InputBorder.none,
                        ),
                        maxLines: null, // 여러 줄 입력 가능
                      ),
                    ),
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
                          '책을 추가해주세요',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/noteAddBook');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(36, 36),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Icon(Icons.add, size: 18),
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
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                print("기록 추가 버튼 클릭됨");
              },
              child: const Text('기록 추가', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ),
    );
  }
}
