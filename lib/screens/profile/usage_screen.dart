import 'package:flutter/material.dart';

import '../../config/supabase_config.dart';

class UsageScreen extends StatefulWidget {
  const UsageScreen({super.key});

  @override
  State<UsageScreen> createState() => _UsageScreenState();
}

class _UsageScreenState extends State<UsageScreen> {
  late Future<Map<String, dynamic>?> _usageFuture;

  @override
  void initState() {
    super.initState();
    _usageFuture = _loadUsage();
  }

  Future<Map<String, dynamic>?> _loadUsage() async {
    if (!SupabaseConfig.isConfigured) return null;
    final client = SupabaseConfig.client;
    final user = client.auth.currentUser;
    if (user == null) return null;
    final firstOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1).toIso8601String().substring(0, 10);
    return client.from('usage').select('period_start, interview_count').eq('user_id', user.id).eq('period_start', firstOfMonth).maybeSingle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usage')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _usageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('Usage data is not available yet. Usage tracking has not been configured for this account.')));
          }
          final usage = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: [
              Card(child: ListTile(leading: const Icon(Icons.bar_chart_rounded), title: const Text('Interviews this period'), subtitle: Text('${usage['interview_count'] ?? 0}'))),
              const SizedBox(height: 12),
              Text('Period started: ${usage['period_start'] ?? 'Unavailable'}'),
              const SizedBox(height: 8),
              const Text('Limits are enforced by the backend when usage controls are enabled.'),
            ],
          );
        },
      ),
    );
  }
}
