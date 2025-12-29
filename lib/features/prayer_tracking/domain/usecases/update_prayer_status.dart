import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/daily_prayer.dart';
import '../repositories/prayer_repository.dart';

class UpdatePrayerStatus
    implements UseCase<DailyPrayer, UpdatePrayerStatusParams> {
  final PrayerRepository repository;

  UpdatePrayerStatus(this.repository);

  @override
  Future<Either<Failure, DailyPrayer>> call(UpdatePrayerStatusParams params) {
    return repository.updatePrayerStatus(
      params.date,
      params.prayer,
      params.isAttended,
    );
  }
}

class UpdatePrayerStatusParams extends Equatable {
  final DateTime date;
  final PrayerType prayer;
  final bool isAttended;

  const UpdatePrayerStatusParams({
    required this.date,
    required this.prayer,
    required this.isAttended,
  });

  @override
  List<Object> get props => [date, prayer, isAttended];
}
