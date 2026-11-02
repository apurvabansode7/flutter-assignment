import '../models/journal_entry_model.dart';

abstract class JournalDataSource {
  Future<List<JournalEntryModel>> fetchEntries();
}

class JournalMockDataSource implements JournalDataSource {
  static final List<JournalEntryModel> mockEntries = [
    JournalEntryModel(
      id: '1',
      title: 'A Day To Remember',
      content:
          'Today felt like a good day to slow down. I finally made time for something I had delayed for months. Nature always has a calming presence when we need it most.',
      date: DateTime(2026, 8, 12),
      time: '06:30 PM',
      month: 'Aug',
    ),
    JournalEntryModel(
      id: '2',
      title: 'A Thought To Keep',
      content:
          'I\'m learning to trust my own pace and enjoy the journey rather than obsessing over the destination. Clarity comes through patience.',
      date: DateTime(2026, 8, 10),
      time: '06:30 PM',
      month: 'Aug',
    ),
    JournalEntryModel(
      id: '3',
      title: 'Something I Realized',
      content:
          'Small steps can still move me closer to where I want to be. Each mindful choice counts, even if it feels quiet in the moment.',
      date: DateTime(2026, 8, 9),
      time: '06:30 PM',
      month: 'Aug',
    ),
    JournalEntryModel(
      id: '4',
      title: 'Reflections on August',
      content:
          'Autumn brings a shift in priorities. Grounded energy and focused attention on creativity and inner peace.',
      date: DateTime(2026, 8, 8),
      time: '07:15 PM',
      month: 'Aug',
    ),
    JournalEntryModel(
      id: '5',
      title: 'A New Beginning',
      content:
          'Stepping into this week with renewed motivation. Grateful for the lessons and looking forward to the opportunities ahead.',
      date: DateTime(2026, 9, 21),
      time: '08:00 AM',
      month: 'Sep',
    ),
  ];

  @override
  Future<List<JournalEntryModel>> fetchEntries() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(mockEntries);
  }
}
