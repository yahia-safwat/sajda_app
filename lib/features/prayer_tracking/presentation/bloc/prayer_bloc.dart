import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_month_prayers.dart';
import '../../domain/usecases/update_prayer_status.dart';
import 'prayer_event.dart';
import 'prayer_state.dart';

class PrayerBloc extends Bloc<PrayerEvent, PrayerState> {
  final GetMonthPrayers getMonthPrayers;
  final UpdatePrayerStatus updatePrayerStatus;

  PrayerBloc({required this.getMonthPrayers, required this.updatePrayerStatus})
    : super(PrayerInitial()) {
    on<LoadMonthPrayers>(_onLoadMonthPrayers);
    on<TogglePrayer>(_onTogglePrayer);
  }

  Future<void> _onLoadMonthPrayers(
    LoadMonthPrayers event,
    Emitter<PrayerState> emit,
  ) async {
    emit(PrayerLoading());
    final result = await getMonthPrayers(
      GetMonthPrayersParams(month: event.month),
    );
    result.fold(
      (failure) => emit(const PrayerError('Failed to load prayers')),
      (prayers) =>
          emit(PrayerLoaded(prayers: prayers, currentMonth: event.month)),
    );
  }

  Future<void> _onTogglePrayer(
    TogglePrayer event,
    Emitter<PrayerState> emit,
  ) async {
    final currentState = state;
    if (currentState is PrayerLoaded) {
      // Optimistic update could go here, but for simplicity we await result
      final result = await updatePrayerStatus(
        UpdatePrayerStatusParams(
          date: event.date,
          prayer: event.prayer,
          isAttended: event.isAttended,
        ),
      );

      result.fold(
        (failure) => emit(const PrayerError('Failed to update prayer')),
        (updatedPrayer) {
          final updatedList = currentState.prayers.map((p) {
            // Match exactly by day, month, year
            if (p.date.year == updatedPrayer.date.year &&
                p.date.month == updatedPrayer.date.month &&
                p.date.day == updatedPrayer.date.day) {
              return updatedPrayer;
            }
            return p;
          }).toList();
          emit(
            PrayerLoaded(
              prayers: updatedList,
              currentMonth: currentState.currentMonth,
            ),
          );
        },
      );
    }
  }
}
