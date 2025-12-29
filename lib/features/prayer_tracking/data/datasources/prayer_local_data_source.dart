import 'package:hive/hive.dart';
import '../models/daily_prayer_model.dart';

abstract class PrayerLocalDataSource {
  Future<List<DailyPrayerModel>> getPrayersForMonth(DateTime month);
  Future<void> cachePrayer(DailyPrayerModel prayer);
}

class PrayerLocalDataSourceImpl implements PrayerLocalDataSource {
  final Box<DailyPrayerModel> box;

  PrayerLocalDataSourceImpl(this.box);

  @override
  Future<List<DailyPrayerModel>> getPrayersForMonth(DateTime month) async {
    // Filter values by month and year
    // Since Hive keys are not necessarily dates, we iterate values.
    // Efficiency note: If data set is small (few years), iteration is fine.
    // For optimization, key could be "yyyy-MM-dd".
    return box.values.where((model) {
      return model.date.year == month.year && model.date.month == month.month;
    }).toList();
  }

  @override
  Future<void> cachePrayer(DailyPrayerModel prayer) async {
    // Use date string as key to ensure uniqueness per day
    final key = "${prayer.date.year}-${prayer.date.month}-${prayer.date.day}";
    await box.put(key, prayer);
  }
}
