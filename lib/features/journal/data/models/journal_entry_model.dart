import '../../domain/entities/journal_entry.dart';

class JournalEntryModel extends JournalEntry {
  const JournalEntryModel({
    required super.id,
    required super.title,
    required super.content,
    required super.date,
    required super.time,
    required super.month,
  });

  factory JournalEntryModel.fromJson(Map<String, dynamic> json) {
    return JournalEntryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
      time: json['time'] as String,
      month: json['month'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'time': time,
      'month': month,
    };
  }
}
