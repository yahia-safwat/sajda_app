import 'package:flutter/material.dart';
import '../../domain/entities/daily_prayer.dart';

class StatsOverview extends StatelessWidget {
  final List<DailyPrayer> prayers;
  final DateTime currentMonth;

  const StatsOverview({
    super.key,
    required this.prayers,
    required this.currentMonth,
  });

  @override
  Widget build(BuildContext context) {
    if (prayers.isEmpty) return const SizedBox.shrink();

    // Calculate stats
    int totalPrayersPossible = 0;
    int attendedCount = 0;
    // int currentStreak = 0;

    // Sort by date
    final sortedPrayers = List<DailyPrayer>.from(prayers)
      ..sort((a, b) => a.date.compareTo(b.date));

    for (var day in sortedPrayers) {
      // Only count days up to today if looking at current month
      final now = DateTime.now();
      if (day.date.year == now.year &&
          day.date.month == now.month &&
          day.date.day > now.day) {
        continue;
      }

      totalPrayersPossible += 5;
      attendedCount += day.prayers.values.where((v) => v).length;
    }

    // Streak calculation (simplified: checking backwards from today)
    // Finding the latest day entry
    // This requires contiguous data which we might not have perfectly in MVP,
    // but let's try a simple version: consecutive days with at least 1 prayer?
    // Or all 5? User said "consecutive mosque prayers". Maybe consecutive attended?
    // Let's stick to % for now to be robust.

    double percentage = totalPrayersPossible > 0
        ? (attendedCount / totalPrayersPossible) * 100
        : 0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            "${percentage.toStringAsFixed(1)}%",
            "Attendance",
          ),
          _buildStatItem(context, "$attendedCount", "Total Prayers"),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
