import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/di/injection_container.dart';
import '../bloc/prayer_bloc.dart';
import '../bloc/prayer_event.dart';
import '../bloc/prayer_state.dart';
import '../widgets/month_grid.dart';
import '../widgets/stats_overview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PrayerBloc>()..add(LoadMonthPrayers(DateTime.now())),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sajda'),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: BlocBuilder<PrayerBloc, PrayerState>(
        builder: (context, state) {
          if (state is PrayerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrayerLoaded) {
            return Column(
              children: [
                StatsOverview(
                  prayers: state.prayers,
                  currentMonth: state.currentMonth,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          final prevMonth = DateTime(
                            state.currentMonth.year,
                            state.currentMonth.month - 1,
                          );
                          context.read<PrayerBloc>().add(
                            LoadMonthPrayers(prevMonth),
                          );
                        },
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(state.currentMonth),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          final nextMonth = DateTime(
                            state.currentMonth.year,
                            state.currentMonth.month + 1,
                          );
                          context.read<PrayerBloc>().add(
                            LoadMonthPrayers(nextMonth),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: MonthGrid(
                    prayers: state.prayers,
                    onToggle: (day, type) {
                      // Find current status
                      final isAttended = day.prayers[type] ?? false;
                      context.read<PrayerBloc>().add(
                        TogglePrayer(
                          date: day.date,
                          prayer: type,
                          isAttended: !isAttended,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is PrayerError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
