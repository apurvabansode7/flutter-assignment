import 'package:equatable/equatable.dart';

class JournalEntry extends Equatable {
  const JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.time,
    required this.month,
  });

  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String time;
  final String month; // e.g. "Aug", "Oct"

  @override
  List<Object?> get props => [id, title, content, date, time, month];
}
