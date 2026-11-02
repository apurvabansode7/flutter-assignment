import '../entities/journal_entry.dart';

abstract class JournalRepository {
  Future<List<JournalEntry>> getEntries();
}
