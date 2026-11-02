import '../../data/models/journal_entry_model.dart';

abstract class JournalState {}

class JournalInitial extends JournalState {}

class JournalLoading extends JournalState {}

class JournalLoaded extends JournalState {
  final List<JournalEntryModel> entries;

  JournalLoaded(this.entries);
}

class JournalError extends JournalState {
  final String message;

  JournalError(this.message);
}