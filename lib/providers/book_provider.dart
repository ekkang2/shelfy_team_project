import 'package:flutter_riverpod/flutter_riverpod.dart';

// 글쓰기용 Provider (초기값 없음)
final bookWriteProvider = StateProvider<Map<String, String>?>((ref) => null);

// 글보기용 Provider (초기값으로 임시 데이터)
final bookViewProvider = StateProvider<Map<String, String>?>((ref) {
  return {
    'book_id': '5',
    'book_image':
        'https://image.aladin.co.kr/product/35490/34/coversum/k122035558_1.jpg',
    'book_title': '자연의 비밀을 탐험하다',
    'book_desc':
        '자연의 신비로운 세계를 다룬 이 책은 다양한 생태계와 생물들의 이야기를 통해 환경 보호의 중요성을 일깨웁니다.',
    'book_author': '최지우 지음',
    'book_publisher': '생태출판',
    'book_isbn': 'K402036375',
    'book_page': '300',
    'book_published_at': '2025-03-20',
  };
});
