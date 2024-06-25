import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:tin_tin/service/notification_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int alarmId = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarms'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "From",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Choose start time",
                            style: TextStyle(fontSize: 14),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                              },
                              child: const Text(
                                "choose",
                                style: TextStyle(fontSize: 14),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "To",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Choose end time",
                            style: TextStyle(fontSize: 14),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                              },
                              child: const Text(
                                "choose",
                                style: TextStyle(fontSize: 14),
                              ))
                        ],
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              print("clicked");
                              AndroidAlarmManager.periodic(
                                  Duration(seconds: 60), alarmId, callBack);
                            },
                            child: const Text('submit')),
                      ),
                    ],
                  ));
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void callBack() async {
  print("Alarm Fired at ${DateTime.now()}");
  MyInAppNotification().showNotification(title: "hi", body: "bye");
}
