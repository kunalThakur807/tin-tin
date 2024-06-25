import 'package:flutter/material.dart';
import 'package:tin_tin/app.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:tin_tin/service/notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();

  MyInAppNotification().initNotification();
  runApp(const MyApp());
}
