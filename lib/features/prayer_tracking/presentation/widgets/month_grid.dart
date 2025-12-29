import 'package:flutter/material.dart';
import '../../domain/entities/daily_prayer.dart';
import 'day_row.dart';

class MonthGrid extends StatelessWidget {
  final List<DailyPrayer> prayers;
  final Function(DailyPrayer, PrayerType) onToggle;

  const MonthGrid({super.key, required this.prayers, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    if (prayers.isEmpty) {
      return const Center(child: Text("No data for this month"));
    }

    // Sort by date just in case
    final sortedPrayers = List<DailyPrayer>.from(prayers)
      ..sort((a, b) => a.date.compareTo(b.date));

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: sortedPrayers.length,
      itemBuilder: (context, index) {
        final day = sortedPrayers[index];
        return DayRow(day: day, onToggle: (type) => onToggle(day, type));
      },
    );
  }
}
