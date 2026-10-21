class DocumentAnalysisModel {
  const DocumentAnalysisModel({
    required this.title,
    required this.skills,
    required this.responsibilities,
    required this.keywords,
    required this.technologies,
    required this.requirements,
  });

  final String title;
  final List<String> skills;
  final List<String> responsibilities;
  final List<String> keywords;
  final List<String> technologies;
  final List<String> requirements;
}