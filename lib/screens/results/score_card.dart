import 'package:flutter/material.dart';

import '../../models/evaluation_model.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key, required this.evaluation});

  final EvaluationModel evaluation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Overall Score', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              '${evaluation.overallScore}/100',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 16),
            _MetricRow(label: 'Relevance', value: evaluation.relevance),
            _MetricRow(label: 'Clarity', value: evaluation.clarity),
            _MetricRow(label: 'Grammar', value: evaluation.grammar),
            _MetricRow(label: 'Completeness', value: evaluation.completeness),
          ],
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          SizedBox(
            width: 100,
            child: LinearProgressIndicator(value: value / 100),
          ),
          const SizedBox(width: 12),
          SizedBox(width: 28, child: Text('$value')),
        ],
      ),
    );
  }
}// Score card.
