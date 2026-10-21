import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../../models/interview_history_model.dart';
import '../../services/interview_history_service.dart';

class InterviewHistoryScreen extends StatefulWidget {
  const InterviewHistoryScreen({super.key});

  @override
  State<InterviewHistoryScreen> createState() => _InterviewHistoryScreenState();
}

class _InterviewHistoryScreenState extends State<InterviewHistoryScreen> {
  final _service = const InterviewHistoryService();
  late Future<List<InterviewHistoryModel>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = _service.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interview History')),
      body: FutureBuilder<List<InterviewHistoryModel>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load interview history.'));
          }

          final history = snapshot.data ?? [];
          if (history.isEmpty) {
            return const Center(child: Text('No interviews yet.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() => _historyFuture = _service.loadHistory());
              await _historyFuture;
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: history.length,
              separatorBuilder: (_, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final interview = history[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      child: Text('${interview.score}'),
                    ),
                    title: Text(interview.role),
                    subtitle: Text(
                      '${interview.type}\n${interview.difficulty} · ${_formatDate(interview.createdAt)}',
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.interviewDetail,
                      arguments: interview,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}// Interview history screen.
