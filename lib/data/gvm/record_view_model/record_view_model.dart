import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/record_model/record_state.dart';

class RecordViewModel extends Notifier<RecordState> {
  @override
  RecordState build() {
    return RecordState(
      stateId: null,
      bookId: null,
      userId: null,
      stateType: null,
      startDate: null,
      endDate: null,
      comment: null,
      progress: null,
      rating: null,
    );
  }
}
