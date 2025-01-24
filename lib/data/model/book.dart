class Book {
  int book_id;
  String book_image;
  String book_title;
  String book_desc;
  String book_author;
  String book_publisher;
  String book_isbn;
  int book_page;
  String book_published_at;

  Book(
      {required this.book_id,
      required this.book_image,
      required this.book_title,
      required this.book_desc,
      required this.book_author,
      required this.book_publisher,
      required this.book_isbn,
      required this.book_page,
      required this.book_published_at});
}

// 샘플 데이터
List<Book> bookList = [
  Book(
      book_id: 1,
      book_image:
          'https://image.aladin.co.kr/product/35548/1/coversum/k402036379_1.jpg',
      book_title: '내일은 한강 - 본격 소녀 성장만화',
      book_desc:
          '개성만점 주인공들이 글쓰기를 통해 성장하고 꿈을 키워나가는 이야기를 만화로 그려 흥미롭게 읽으면서 동시에 읽고, 쓰고, 생각하는 ‘글쓰기 근력’을 기를 수 있는 책이다.',
      book_author: '별미디어 지음',
      book_publisher: '다른아이',
      book_isbn: 'K402036379',
      book_page: 260,
      book_published_at: '2025-01-09'),
  Book(
      book_id: 2,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35422\/9\/coversum\/894608362x_1.jpg',
      book_title: '모두가 사랑하는 프로그래밍',
      book_desc: '프로그래밍의 기초부터 실전까지! 다양한 예제를 통해 쉽고 재미있게 배워보세요.',
      book_author: '홍길동 지음',
      book_publisher: '프로그래밍 세상',
      book_isbn: 'K402036378',
      book_page: 320,
      book_published_at: '2025-01-05'),
  Book(
      book_id: 3,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35642\/39\/coversum\/8957945792_1.jpg',
      book_title: '우주 탐험의 역사',
      book_desc: '인류의 우주 탐험 여정을 다룬 흥미진진한 이야기와 최신 연구 결과를 담고 있습니다.',
      book_author: '김宇성 지음',
      book_publisher: '우주과학',
      book_isbn: 'K402036377',
      book_page: 280,
      book_published_at: '2025-01-10'),
  Book(
      book_id: 4,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35348\/3\/coversum\/8967998635_1.jpg',
      book_title: '인공지능 시대의 생존 전략',
      book_desc: 'AI 기술의 발전과 그것이 우리의 삶에 미치는 영향을 다룬 책으로, 미래를 대비하는 방법을 제시합니다.',
      book_author: '이상훈 지음',
      book_publisher: '미래인',
      book_isbn: 'K402036376',
      book_page: 240,
      book_published_at: '2025-02-15'),
  Book(
      book_id: 5,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35490\/34\/coversum\/k122035558_1.jpg',
      book_title: '자연의 비밀을 탐험하다',
      book_desc:
          '자연의 신비로운 세계를 다룬 이 책은 다양한 생태계와 생물들의 이야기를 통해 환경 보호의 중요성을 일깨웁니다.',
      book_author: '최지우 지음',
      book_publisher: '생태출판',
      book_isbn: 'K402036375',
      book_page: 300,
      book_published_at: '2025-03-20'),
  Book(
      book_id: 6,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35146\/12\/coversum\/k142934914_3.jpg',
      book_title: '행복한 삶을 위한 심리학',
      book_desc: '행복을 추구하는 현대인들에게 필요한 심리학적 통찰과 실천 방법을 제시합니다.',
      book_author: '이정민 지음',
      book_publisher: '정신세계',
      book_isbn: 'K402036374',
      book_page: 220,
      book_published_at: '2025-04-12'),
  Book(
      book_id: 7,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35474\/30\/coversum\/895794575x_1.jpg',
      book_title: '2025년, 미래의 직업',
      book_desc: '변화하는 시대에 맞는 직업에 대한 통찰과 준비 방법을 다룬 책입니다.',
      book_author: '강성민 지음',
      book_publisher: '직업세계',
      book_isbn: 'K402036373',
      book_page: 250,
      book_published_at: '2025-05-05'),
  Book(
      book_id: 8,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35473\/92\/coversum\/8957945776_1.jpg',
      book_title: '창의성을 키우는 방법',
      book_desc: '창의성을 기르는 다양한 방법과 연습법을 소개하는 실용적인 책입니다.',
      book_author: '박지윤 지음',
      book_publisher: '창의출판',
      book_isbn: 'K402036372',
      book_page: 270,
      book_published_at: '2025-06-25'),
  Book(
      book_id: 9,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35273\/82\/coversum\/8957945741_1.jpg',
      book_title: '모험과 탐험의 세계',
      book_desc: '다양한 모험과 탐험에 관한 이야기를 통해 용기와 도전 정신을 고취합니다.',
      book_author: '손민재 지음',
      book_publisher: '모험출판',
      book_isbn: 'K402036371',
      book_page: 330,
      book_published_at: '2025-07-15'),
  Book(
      book_id: 10,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35144\/68\/coversum\/8932043337_1.jpg',
      book_title: '내일의 세상',
      book_desc: '다가오는 미래에 대한 통찰과 전망을 담은 책입니다.',
      book_author: '윤하 지음',
      book_publisher: '미래출판',
      book_isbn: 'K402036370',
      book_page: 190,
      book_published_at: '2025-08-30'),
  Book(
      book_id: 11,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35289\/81\/coversum\/896554307x_1.jpg',
      book_title: '음악의 힘',
      book_desc: '음악이 인간에게 미치는 영향과 그 역사적 배경을 다룬 책입니다.',
      book_author: '김수연 지음',
      book_publisher: '음악출판',
      book_isbn: 'K402036369',
      book_page: 240,
      book_published_at: '2025-09-20'),
  Book(
      book_id: 12,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35144\/70\/coversum\/8932043345_1.jpg',
      book_title: '디지털 시대의 커뮤니케이션',
      book_desc: '디지털 환경에서 효과적으로 소통하는 방법을 다룬 책입니다.',
      book_author: '장지혜 지음',
      book_publisher: '커뮤니케이션 출판',
      book_isbn: 'K402036368',
      book_page: 210,
      book_published_at: '2025-10-10'),
  Book(
      book_id: 13,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35144\/59\/coversum\/k072934815_1.jpg',
      book_title: '미래 기술과 우리의 삶',
      book_desc: '미래의 기술이 우리의 일상에 미치는 영향을 분석한 책입니다.',
      book_author: '이승훈 지음',
      book_publisher: '기술출판',
      book_isbn: 'K402036367',
      book_page: 280,
      book_published_at: '2025-11-05'),
  Book(
      book_id: 14,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35118\/61\/coversum\/k602934712_1.jpg',
      book_title: '인간의 뇌, 미래를 결정하다',
      book_desc: '인간의 뇌와 인지 과학에 대한 최신 연구 결과를 담고 있습니다.',
      book_author: '백종원 지음',
      book_publisher: '과학출판',
      book_isbn: 'K402036366',
      book_page: 300,
      book_published_at: '2025-12-01'),
  Book(
      book_id: 15,
      book_image:
          'https:\/\/image.aladin.co.kr\/product\/35123\/96\/coversum\/k492934818_3.jpg',
      book_title: '지속 가능한 발전을 위한 길',
      book_desc: '지속 가능한 발전과 관련된 다양한 이론과 사례를 다룬 책입니다.',
      book_author: '이소영 지음',
      book_publisher: '발전출판',
      book_isbn: 'K402036365',
      book_page: 320,
      book_published_at: '2025-12-15'),
];
