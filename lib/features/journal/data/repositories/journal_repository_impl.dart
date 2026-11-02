import '../../domain/entities/journal_entry.dart';
import '../../domain/repositories/journal_repository.dart';
import '../datasources/journal_mock_data_source.dart';

class JournalRepositoryImpl implements JournalRepository {
  JournalRepositoryImpl({JournalDataSource? dataSource})
      : _dataSource = dataSource ?? JournalMockDataSource();

  final JournalDataSource _dataSource;

  @override
  Future<List<JournalEntry>> getEntries() async {
    return _dataSource.fetchEntries();
  }
}
