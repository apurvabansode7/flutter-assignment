import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/insight_data.dart';
import '../../domain/repositories/insights_repository.dart';
import 'insights_event.dart';
import 'insights_state.dart';

class InsightsBloc extends Bloc<InsightsEvent, InsightsState> {
  final InsightsRepository repository;

  InsightsBloc({required this.repository})
      : super(const InsightsState()) {
    on<LoadInsights>(_onLoadInsights);
    on<ChangeInsightsPeriod>(_onChangePeriod);
  }

  Future<void> _onLoadInsights(
    LoadInsights event,
    Emitter<InsightsState> emit,
  ) async {
    await _loadData(event.period, emit);
  }

  Future<void> _onChangePeriod(
    ChangeInsightsPeriod event,
    Emitter<InsightsState> emit,
  ) async {
    if (state.selectedPeriod == event.period &&
        state.status == InsightsStatus.success) {
      return;
    }

    await _loadData(event.period, emit);
  }

  Future<void> _loadData(
    InsightPeriod period,
    Emitter<InsightsState> emit,
  ) async {
    emit(state.copyWith(
      status: InsightsStatus.loading,
      selectedPeriod: period,
    ));

    try {
      final data = await repository.getInsightData(period);

      emit(state.copyWith(
        status: InsightsStatus.success,
        insightData: data,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: InsightsStatus.failure,
        errorMessage: 'Unable to load insights.',
      ));
    }
  }
}