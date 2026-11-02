import '../../domain/entities/insight_data.dart';
import '../../domain/repositories/insights_repository.dart';
import '../datasources/insights_mock_data_source.dart';

class InsightsRepositoryImpl implements InsightsRepository {
  InsightsRepositoryImpl({InsightsDataSource? dataSource})
      : _dataSource = dataSource ?? InsightsMockDataSource();

  final InsightsDataSource _dataSource;

  @override
  Future<InsightData> getInsightData(InsightPeriod period) async {
    return _dataSource.fetchInsightData(period);
  }
}
