import '../entities/insight_data.dart';

abstract class InsightsRepository {
  Future<InsightData> getInsightData(InsightPeriod period);
}
