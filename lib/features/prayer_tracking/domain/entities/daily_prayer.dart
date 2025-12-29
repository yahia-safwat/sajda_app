import 'package:equatable/equatable.dart';

enum PrayerType { fajr, dhuhr, asr, maghrib, isha }

class DailyPrayer extends Equatable {
  final DateTime date;
  final Map<PrayerType, bool> prayers;

  const DailyPrayer({required this.date, required this.prayers});

  /// Factory to create an empty day (all prayers unattended)
  factory DailyPrayer.empty(DateTime date) {
    return DailyPrayer(
      date: date,
      prayers: {
        PrayerType.fajr: false,
        PrayerType.dhuhr: false,
        PrayerType.asr: false,
        PrayerType.maghrib: false,
        PrayerType.isha: false,
      },
    );
  }

  DailyPrayer copyWith({DateTime? date, Map<PrayerType, bool>? prayers}) {
    return DailyPrayer(
      date: date ?? this.date,
      prayers: prayers ?? this.prayers,
    );
  }

  bool isCompleted(PrayerType type) => prayers[type] ?? false;

  @override
  List<Object?> get props => [date, prayers];
}
