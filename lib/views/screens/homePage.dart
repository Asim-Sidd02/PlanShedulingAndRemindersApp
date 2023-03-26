import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../controlles/reminderController.dart';
import '../../helpers/dbHelper.dart';
import '../../helpers/notificationsHelper.dart';
import '../componets/add_reminted.dart';
import '../componets/edit_reminter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  ReminderController reminderController = Get.put(ReminderController());

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('mipmap/launcher_icon');
    var initializationSettingsIOs = const DarwinInitializationSettings();
    var initSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    NotificationHelper.flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        {
          break;
        }
      case AppLifecycleState.paused:
        {
          break;
        }
      case AppLifecycleState.resumed:
        {
          break;
        }
      case AppLifecycleState.detached:
        {
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Plan Scheduling and reminders"),
          centerTitle: true,
          backgroundColor: const Color(0xFF2FA2B9),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addReminder(context);
          },
          child: const Icon(Icons.add),
          backgroundColor: const Color(0xFF2FA2B9),
        ),
        body: Obx(
        () => SingleChildScrollView(
        child: Column(
            children: reminderController.reminders
                .map(
                    (e) => Container(
                  padding: const EdgeInsets.all(20),
                  margin:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Center(
                  child: Text(
                  e.title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(endIndent: 10, indent: 10),
                const SizedBox(height: 5),
                Text("Desc : ${e.description}"),
                Row(
                    children: [
                Text(
                "Time : ${(e.hour > 12) ? e.hour - 12 : e.hour} : ${e.minute}  ${(e.hour > 12) ? "PM" : "AM"}",
            style: Theme.of(context).textTheme.subtitle1),
        const Spacer(),
        IconButton(
          onPressed: () {
            editReminder(reminder: e, context: context);
          },
          icon: const Icon(Icons.edit),
          color: const Color(0xFF2FA2B9),
        ),
                      IconButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text("Delete Reminder"),
                              content: const Text(
                                "Are you sure want to Delete?",
                              ),
                              actions: [
                                OutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    DBHelper.dbHelper
                                        .deleteReminder(id: e.id);
                                    Get.back();
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                ),
                    ],
                  ),
                    ),
            )
                .toList(),
        ),
        ),
        ),
    );
  }
}

