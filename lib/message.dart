import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mynotification/main.dart';
import 'package:mynotification/screen.dart';

class Messaging extends StatefulWidget {
  const Messaging({Key? key}) : super(key: key);
  static late BuildContext openContext;

  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final List<Message> messages = [];
  int _counter = 0;

  void selectNotification(String? payload) async {
    debugPrint('notification payload: $payload');

    await Navigator.push(
      context,
      MaterialPageRoute<void>(
          builder: (context) => Screen(text: payload.toString())),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher'),
            iOS: const IOSNotificationDetails(
                presentSound: true, presentAlert: true, presentBadge: true)),
        payload: 'Open from Local Notification');
    setState(() {
      messages.add(
        Message(
          title: "Testing $_counter",
          body: "How you doin ?",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Messaging.openContext = context;
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: messages.map(buildMessage).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showNotification,
        tooltip: 'Local Notification',
        child: const Text(
          '@',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildMessage(Message message) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade400,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      message.body,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class Message {
  final String title;
  final String body;

  const Message({
    required this.title,
    required this.body,
  });
}
