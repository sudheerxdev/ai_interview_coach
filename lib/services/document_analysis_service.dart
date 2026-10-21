import '../models/document_analysis_model.dart';

class DocumentAnalysisService {
  const DocumentAnalysisService();

  DocumentAnalysisModel analyzeResume(String text) {
    final normalized = text.toLowerCase();
    final technologies = _matches(normalized, const {
      'flutter': 'Flutter',
      'dart': 'Dart',
      'javascript': 'JavaScript',
      'typescript': 'TypeScript',
      'python': 'Python',
      'sql': 'SQL',
      'firebase': 'Firebase',
    });
    return DocumentAnalysisModel(
      title: 'Resume insights',
      skills: _matches(normalized, const {
        'communication': 'Communication',
        'leadership': 'Leadership',
        'customer service': 'Customer service',
        'problem solving': 'Problem solving',
        'analysis': 'Analysis',
      }),
      responsibilities: const [
        'Describe your most recent responsibilities clearly.',
        'Connect your experience to the target job role.',
      ],
      keywords: _keywords(text),
      technologies: technologies,
      requirements: const [
        'Use specific achievements when answering interview questions.',
        'Prepare examples that demonstrate your listed skills.',
      ],
    );
  }

  DocumentAnalysisModel analyzeJobDescription(String text) {
    final normalized = text.toLowerCase();
    return DocumentAnalysisModel(
      title: 'Job description insights',
      skills: _matches(normalized, const {
        'communication': 'Communication',
        'leadership': 'Leadership',
        'customer service': 'Customer service',
        'problem solving': 'Problem solving',
        'analysis': 'Analysis',
      }),
      responsibilities: const [
        'Prioritize the responsibilities mentioned in the description.',
        'Prepare a situation, action, and result for each major responsibility.',
      ],
      keywords: _keywords(text),
      technologies: _matches(normalized, const {
        'flutter': 'Flutter',
        'dart': 'Dart',
        'javascript': 'JavaScript',
        'typescript': 'TypeScript',
        'python': 'Python',
        'sql': 'SQL',
        'firebase': 'Firebase',
      }),
      requirements: const [
        'Review the required skills before starting a personalized interview.',
        'Use examples that directly match the employer requirements.',
      ],
    );
  }

  List<String> _matches(String text, Map<String, String> terms) {
    return terms.entries
        .where((entry) => text.contains(entry.key))
        .map((entry) => entry.value)
        .toList();
  }

  List<String> _keywords(String text) {
    final words = text
        .split(RegExp(r'\s+'))
        .map((word) => word.replaceAll(RegExp(r'[^A-Za-z0-9+#.-]'), ''))
        .where((word) => word.length > 5)
        .toSet()
        .take(8)
        .toList();
    return words.isEmpty ? ['Experience', 'Results', 'Communication'] : words;
  }
}