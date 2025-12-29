import 'package:equatable/equatable.dart';
import '../../domain/entities/daily_prayer.dart';

abstract class PrayerState extends Equatable {
  const PrayerState();

  @override
  List<Object> get props => [];
}

class PrayerInitial extends PrayerState {}

class PrayerLoading extends PrayerState {}

class PrayerLoaded extends PrayerState {
  final List<DailyPrayer> prayers;
  final DateTime currentMonth;

  const PrayerLoaded({required this.prayers, required this.currentMonth});

  @override
  List<Object> get props => [prayers, currentMonth];
}

class PrayerError extends PrayerState {
  final String message;

  const PrayerError(this.message);

  @override
  List<Object> get props => [message];
}
