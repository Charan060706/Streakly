import 'package:flutter/material.dart';
import '/habit_dashboard.dart';
import '/add_habit.dart';
import '/calendar_view.dart';
import '/analyatics.dart';
import '/settings.dart';
import '/mood_tracker.dart';

void main() {
  runApp(MindStreakApp());
}

class MindStreakApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindStreak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HabitDashboardPage(),
        '/add': (context) => AddHabitPage(),
        '/calendar': (context) => CalendarViewPage(),
        '/analytics': (context) => AnalyticsPage(),
        '/settings': (context) => SettingsPage(),
        '/mood': (context) => MoodTrackerPage(),
      },
    );
  }
}
