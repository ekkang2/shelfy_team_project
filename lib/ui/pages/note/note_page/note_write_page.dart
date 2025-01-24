import 'package:flutter/material.dart';
import 'package:shelfy_team_project/components/custom_appbar.dart';

class NoteWritePage extends StatelessWidget {
  const NoteWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: WriteAppBar(context), // 사용자 정의 AppBar
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단 프로필 영역
              Row(
                children: [
                  // 동그란 프로필 자리 (비워둠)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 날짜 및 제목 입력
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '2025년 1월 22일 수요일', // 날짜 텍스트
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '제목을 입력하세요.', // 제목 텍스트
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 입력 박스
              Container(
                height: 150,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[100],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '오늘 기록할 조각을 남겨주세요.', // 힌트 텍스트
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none, // 기본 테두리 제거
                  ),
                  maxLines: null, // 여러 줄 입력 가능
                ),
              ),
              const SizedBox(height: 24),
              // 기록과 함께 하는 책
              Center(
                child: Text(
                  '기록과 함께 하는 책',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // 책 썸네일 자리
                  Container(
                    width: 50,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 책 추가 텍스트 및 버튼
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '책을 추가해주세요',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // 책 추가 버튼 동작
                          print("책 추가 버튼 클릭됨");
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(36, 36), // 버튼 크기
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(Icons.add, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              // 하단 기록 추가 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // 기록 추가 버튼 동작
                    print("기록 추가 버튼 클릭됨");
                  },
                  child: const Text('기록 추가', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
