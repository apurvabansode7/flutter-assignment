import '../../domain/entities/insight_data.dart';
import '../models/insight_data_model.dart';

abstract class InsightsDataSource {
  Future<InsightDataModel> fetchInsightData(InsightPeriod period);
}

class InsightsMockDataSource implements InsightsDataSource {
  @override
  Future<InsightDataModel> fetchInsightData(InsightPeriod period) async {
    await Future.delayed(const Duration(milliseconds: 100));

    switch (period) {
      case InsightPeriod.yesterday:
        return const InsightDataModel(
          userName: 'Gilli Gaurav Singh',
          userBirthDate: 'Sept 22, 2001',
          sunSign: 'Cancer',
          moonSign: 'Leo',
          focusArea: 'Reflection',
          horoscopeText:
              'Yesterday offered valuable clarity on past challenges. Taking things in stride brought balance back into focus.',
          favourableDirection: 'North-East',
          luckyColour: 'Sky Blue',
          funFactText:
              'Cancer is ruled by the Moon, making emotional intuition and empathetic perception especially keen.',
          luckyNumber: 4,
          guidanceText:
              'Reflect on previous achievements and let go of self-doubt.',
          destinyNumber: 5,
          destinyTitle: 'The Reflection',
        );
      case InsightPeriod.today:
        return const InsightDataModel(
          userName: 'Gilli Gaurav Singh',
          userBirthDate: 'You • Sept 22, 2001',
          sunSign: 'Cancer',
          moonSign: 'Leo',
          focusArea: 'Career',
          horoscopeText:
              'Give yourself time to heal and focus on your well-being today. Avoid unhealthy habits and choose nourishing foods. Stay patient—positive career opportunities are on the way, while love brings warmth and connection.',
          favourableDirection: 'North',
          luckyColour: 'Pink',
          funFactText:
              'Leo is ruled by the Sun ☀️, which is why it\'s traditionally associated with confidence, creativity, warmth, and a natural desire to shine.',
          luckyNumber: 5,
          guidanceText:
              'Stay open to unexpected opportunities. Trust your instincts, explore something new, and avoid overthinking your next move.',
          destinyNumber: 7,
          destinyTitle: 'The Seeker',
        );
      case InsightPeriod.tomorrow:
        return const InsightDataModel(
          userName: 'Gilli Gaurav Singh',
          userBirthDate: 'You • Sept 22, 2001',
          sunSign: 'Cancer',
          moonSign: 'Leo',
          focusArea: 'Collaboration',
          horoscopeText:
              'Tomorrow will bring a burst of collaborative energy. Clear communication will be your secret to unlocking harmonious relationships.',
          favourableDirection: 'East',
          luckyColour: 'Golden Yellow',
          funFactText:
              'When the Sun interacts with your fifth house, artistic pursuits and spontaneous conversations shine brightest.',
          luckyNumber: 8,
          guidanceText:
              'Share your perspective with an open heart and listen deeply to peers.',
          destinyNumber: 15,
          destinyTitle: 'The collaboration',
        );
      case InsightPeriod.week:
        return const InsightDataModel(
          userName: 'Gilli Gaurav Singh',
          userBirthDate: 'You • Sept 22, 2001',
          sunSign: 'Cancer',
          moonSign: 'Leo',
          focusArea: 'Growth',
          horoscopeText:
              'A week geared towards long-term goal setting and personal growth. Keep your daily routine grounded in mindful habits.',
          favourableDirection: 'North',
          luckyColour: 'Teal',
          funFactText:
              'Weekly celestial alignments highlight steady perseverance over quick fixes.',
          luckyNumber: 3,
          guidanceText:
              'Consistency is your greatest superpower this week.',
          destinyNumber: 10,
          destinyTitle: 'The superpower',
        );
      case InsightPeriod.month:
        return const InsightDataModel(
          userName: 'Gilli Gaurav Singh',
          userBirthDate: 'You • Sept 22, 2001',
          sunSign: 'Cancer',
          moonSign: 'Leo',
          focusArea: 'Transformation',
          horoscopeText:
              'This month marks an inspiring cycle of transformation and creative courage. Embrace new beginnings with quiet confidence.',
          favourableDirection: 'North-West',
          luckyColour: 'Emerald Green',
          funFactText:
              'Monthly shifts invite introspection and alignment of personal values with life goals.',
          luckyNumber: 9,
          guidanceText:
              'Honor how far you have come and step boldly into your next chapter.',
          destinyNumber: 17,
          destinyTitle: 'The Reflection',
        );
    }
  }
}
