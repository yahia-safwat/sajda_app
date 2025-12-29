import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/daily_prayer.dart';
import '../repositories/prayer_repository.dart';

class GetMonthPrayers
    implements UseCase<List<DailyPrayer>, GetMonthPrayersParams> {
  final PrayerRepository repository;

  GetMonthPrayers(this.repository);

  @override
  Future<Either<Failure, List<DailyPrayer>>> call(
    GetMonthPrayersParams params,
  ) {
    return repository.getPrayersForMonth(params.month);
  }
}

class GetMonthPrayersParams extends Equatable {
  final DateTime month;

  const GetMonthPrayersParams({required this.month});

  @override
  List<Object> get props => [month];
}
