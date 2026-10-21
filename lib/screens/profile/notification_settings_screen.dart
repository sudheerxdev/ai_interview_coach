import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          const Text('Notification delivery is not connected yet. These preferences will be available after push notification infrastructure is added.'),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: const [
                SwitchListTile(value: false, onChanged: null, title: Text('Interview reminders')),
                SwitchListTile(value: false, onChanged: null, title: Text('Practice reminders')),
                SwitchListTile(value: false, onChanged: null, title: Text('Performance updates')),
                SwitchListTile(value: false, onChanged: null, title: Text('Product updates')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
