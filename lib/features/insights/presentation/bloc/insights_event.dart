import 'package:equatable/equatable.dart';
import '../../domain/entities/insight_data.dart';

abstract class InsightsEvent extends Equatable {
  const InsightsEvent();

  @override
  List<Object?> get props => [];
}

class LoadInsights extends InsightsEvent {
  final InsightPeriod period;

  const LoadInsights(this.period);

  @override
  List<Object?> get props => [period];
}

class ChangeInsightsPeriod extends InsightsEvent {
  final InsightPeriod period;

  const ChangeInsightsPeriod(this.period);

  @override
  List<Object?> get props => [period];
}