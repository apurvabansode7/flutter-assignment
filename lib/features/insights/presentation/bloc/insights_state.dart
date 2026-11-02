import 'package:equatable/equatable.dart';
import '../../domain/entities/insight_data.dart';

enum InsightsStatus { initial, loading, success, failure }

class InsightsState extends Equatable {
  const InsightsState({
    this.status = InsightsStatus.initial,
    this.selectedPeriod = InsightPeriod.today,
    this.insightData,
    this.errorMessage,
  });

  final InsightsStatus status;
  final InsightPeriod selectedPeriod;
  final InsightData? insightData;
  final String? errorMessage;

  InsightsState copyWith({
    InsightsStatus? status,
    InsightPeriod? selectedPeriod,
    InsightData? insightData,
    String? errorMessage,
  }) {
    return InsightsState(
      status: status ?? this.status,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      insightData: insightData ?? this.insightData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        selectedPeriod,
        insightData,
        errorMessage,
      ];
}
