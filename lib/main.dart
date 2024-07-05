import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tin_tin/app.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:tin_tin/service/notification_services.dart';
import 'package:tin_tin/service/utils/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.boxName);

  MyInAppNotification().initNotification();
  runApp(const MyApp());
}
