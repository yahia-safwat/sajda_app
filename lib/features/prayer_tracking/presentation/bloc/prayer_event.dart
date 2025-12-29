import 'package:equatable/equatable.dart';
import '../../domain/entities/daily_prayer.dart';

abstract class PrayerEvent extends Equatable {
  const PrayerEvent();

  @override
  List<Object> get props => [];
}

class LoadMonthPrayers extends PrayerEvent {
  final DateTime month;

  const LoadMonthPrayers(this.month);

  @override
  List<Object> get props => [month];
}

class TogglePrayer extends PrayerEvent {
  final DateTime date;
  final PrayerType prayer;
  final bool isAttended;

  const TogglePrayer({
    required this.date,
    required this.prayer,
    required this.isAttended,
  });

  @override
  List<Object> get props => [date, prayer, isAttended];
}
