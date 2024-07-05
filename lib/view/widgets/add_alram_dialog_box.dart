import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tin_tin/model/alarm_model.dart';
import 'package:tin_tin/service/notification_services.dart';
import 'package:tin_tin/service/utils/app_constants.dart';
import 'package:tin_tin/service/utils/extensions.dart';

class AddAlramDialogBox extends StatefulWidget {
  const AddAlramDialogBox({super.key});

  @override
  State<AddAlramDialogBox> createState() => _AddAlramDialogBoxState();
}

class _AddAlramDialogBoxState extends State<AddAlramDialogBox> {
  int alarmId = 7;
  String fromTxt = AppConstants.fromTxt;
  TimeOfDay? from;
  TimeOfDay? to;
  String toTxt = AppConstants.toTxt;
  var box = Hive.box(AppConstants.boxName);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              AppConstants.from,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fromTxt,
                  style: const TextStyle(fontSize: 14),
                ),
                ElevatedButton(
                    onPressed: () async {
                      from = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());

                      setState(() {
                        fromTxt = from?.format(context) ?? '';
                      });
                    },
                    child: const Text(
                      AppConstants.choose,
                      style: TextStyle(fontSize: 14),
                    ))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              AppConstants.to,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  toTxt,
                  style: const TextStyle(fontSize: 14),
                ),
                ElevatedButton(
                    onPressed: () async {
                      to = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      setState(() {
                        toTxt = to?.format(context) ?? '';
                      });
                    },
                    child: const Text(
                      AppConstants.choose,
                      style: TextStyle(fontSize: 14),
                    ))
              ],
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    box.put(
                        AppConstants.schedules,
                        AlarmModel(
                                alarmId: alarmId,
                                from: from!.formatDateTime.toString(),
                                to: to!.formatDateTime.toString())
                            .toJson());
                    AndroidAlarmManager.periodic(
                        const Duration(seconds: 60), alarmId, callBack,
                        startAt: from!.formatDateTime);
                  },
                  child: const Text(AppConstants.submit)),
            ),
          ],
        ));
  }
}

void callBack() async {
  await Hive.initFlutter();
  var box = await Hive.openBox(AppConstants.boxName);
  //  Hive.box(AppConstants.boxName);
  var data = box.get(AppConstants.schedules);
  AlarmModel value = AlarmModel.fromJson(data);
  DateTime to = DateTime.parse(value.to);

  if (DateTime.now().minute >= to.minute) {
    AndroidAlarmManager.cancel(value.alarmId);
  } else {
    MyInAppNotification().showNotification(title: "hi", body: "bye");
  }
}
