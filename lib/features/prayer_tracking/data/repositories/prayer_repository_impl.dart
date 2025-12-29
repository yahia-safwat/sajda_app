import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/daily_prayer.dart';
import '../../domain/repositories/prayer_repository.dart';
import '../datasources/prayer_local_data_source.dart';
import '../models/daily_prayer_model.dart';

class PrayerRepositoryImpl implements PrayerRepository {
  final PrayerLocalDataSource localDataSource;

  PrayerRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<DailyPrayer>>> getPrayersForMonth(
    DateTime month,
  ) async {
    try {
      final models = await localDataSource.getPrayersForMonth(month);
      final Map<int, DailyPrayer> storedPrayers = {
        for (var m in models) m.date.day: m.toEntity(),
      };

      final int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
      final List<DailyPrayer> allPrayers = [];

      for (int i = 1; i <= daysInMonth; i++) {
        final date = DateTime(month.year, month.month, i);
        if (storedPrayers.containsKey(i)) {
          allPrayers.add(storedPrayers[i]!);
        } else {
          allPrayers.add(DailyPrayer.empty(date));
        }
      }

      return Right(allPrayers);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, DailyPrayer>> updatePrayerStatus(
    DateTime date,
    PrayerType prayer,
    bool isAttended,
  ) async {
    try {
      // Get existing day or create new
      final monthPrayers = await localDataSource.getPrayersForMonth(date);
      // Find today
      DailyPrayerModel? existingModel;
      try {
        existingModel = monthPrayers.firstWhere(
          (p) =>
              p.date.year == date.year &&
              p.date.month == date.month &&
              p.date.day == date.day,
        );
      } catch (_) {
        existingModel = null;
      }

      DailyPrayer entity = existingModel?.toEntity() ?? DailyPrayer.empty(date);

      // Update entity
      final Map<PrayerType, bool> newPrayers = Map.from(entity.prayers);
      newPrayers[prayer] = isAttended;

      final updatedEntity = entity.copyWith(prayers: newPrayers);
      final model = DailyPrayerModel.fromEntity(updatedEntity);

      await localDataSource.cachePrayer(model);

      return Right(updatedEntity);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
