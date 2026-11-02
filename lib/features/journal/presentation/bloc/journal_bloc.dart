import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/journal_mock_data_source.dart';
import 'journal_event.dart';
import 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final JournalDataSource dataSource;

  JournalBloc({required this.dataSource}) : super(JournalInitial()) {
    on<LoadJournalEvent>((event, emit) async {
      await _loadEntries(emit);
    });

    on<RefreshJournalEvent>((event, emit) async {
      await _loadEntries(emit);
    });
  }

  Future<void> _loadEntries(Emitter<JournalState> emit) async {
    try {
      emit(JournalLoading());

      final entries = await dataSource.fetchEntries();

      emit(JournalLoaded(entries));
    } catch (e) {
      emit(JournalError('Unable to load journal entries.'));
    }
  }
}