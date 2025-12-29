import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/daily_prayer.dart';

abstract class PrayerRepository {
  /// Get all prayer records for a specific month.
  /// Result is a list of [DailyPrayer] for every day in that month.
  Future<Either<Failure, List<DailyPrayer>>> getPrayersForMonth(DateTime month);

  /// Update the status of a specific prayer on a specific date.
  Future<Either<Failure, DailyPrayer>> updatePrayerStatus(
    DateTime date,
    PrayerType prayer,
    bool isAttended,
  );
}
