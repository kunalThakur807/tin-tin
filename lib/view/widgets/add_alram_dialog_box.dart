import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
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
                        toTxt = to!.format(context);
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
                    AndroidAlarmManager.periodic(
                        const Duration(seconds: 60), alarmId, callBack);
                  },
                  child: const Text(AppConstants.submit)),
            ),
          ],
        ));
  }
}

void callBack() async {
  // if (DateTime.now().minute >= to!.formatDateTime.minute) {
  //   AndroidAlarmManager.cancel(alarmId);
  // } else {
  print("Alarm Fired at ${DateTime.now()}");
  MyInAppNotification().showNotification(title: "hi", body: "bye");
  // }
}
