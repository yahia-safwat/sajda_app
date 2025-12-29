import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../../features/prayer_tracking/data/datasources/prayer_local_data_source.dart';
import '../../features/prayer_tracking/data/models/daily_prayer_model.dart';
import '../../features/prayer_tracking/data/repositories/prayer_repository_impl.dart';
import '../../features/prayer_tracking/domain/repositories/prayer_repository.dart';
import '../../features/prayer_tracking/domain/usecases/get_month_prayers.dart';
import '../../features/prayer_tracking/domain/usecases/update_prayer_status.dart';
import '../../features/prayer_tracking/presentation/bloc/prayer_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Prayer Tracking
  // Bloc
  sl.registerFactory(
    () => PrayerBloc(getMonthPrayers: sl(), updatePrayerStatus: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetMonthPrayers(sl()));
  sl.registerLazySingleton(() => UpdatePrayerStatus(sl()));

  // Repository
  sl.registerLazySingleton<PrayerRepository>(
    () => PrayerRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<PrayerLocalDataSource>(
    () => PrayerLocalDataSourceImpl(sl()),
  );

  // External
  final box = await Hive.openBox<DailyPrayerModel>('daily_prayers');
  sl.registerLazySingleton(() => box);
}
