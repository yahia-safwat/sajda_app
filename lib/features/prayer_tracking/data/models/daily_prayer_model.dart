import 'package:hive/hive.dart';
import '../../domain/entities/daily_prayer.dart';

part 'daily_prayer_model.g.dart';

@HiveType(typeId: 0)
class DailyPrayerModel extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final Map<String, bool> prayersMap;

  DailyPrayerModel({required this.date, required this.prayersMap});

  factory DailyPrayerModel.fromEntity(DailyPrayer entity) {
    return DailyPrayerModel(
      date: entity.date,
      prayersMap: entity.prayers.map((key, value) => MapEntry(key.name, value)),
    );
  }

  DailyPrayer toEntity() {
    final Map<PrayerType, bool> prayers = {};
    prayersMap.forEach((key, value) {
      // Find enum value by name
      final type = PrayerType.values.firstWhere(
        (e) => e.name == key,
        orElse: () => PrayerType.fajr, // Fallback, though shouldn't happen
      );
      prayers[type] = value;
    });

    // Ensure all types are present (fill missing with false)
    for (var type in PrayerType.values) {
      if (!prayers.containsKey(type)) {
        prayers[type] = false;
      }
    }

    return DailyPrayer(date: date, prayers: prayers);
  }
}
