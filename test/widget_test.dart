import 'package:flutter_test/flutter_test.dart';

import 'package:ai_interview_coach/app/app.dart';
import 'package:ai_interview_coach/providers/interview_provider.dart';
import 'package:ai_interview_coach/screens/interview_setup/interview_type_screen.dart';

void main() {
  testWidgets('displays the splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const AIInterviewCoachApp());

    expect(find.text('InterviewAI'), findsOneWidget);
    expect(
      find.text('AI-powered practice for your next big interview.'),
      findsOneWidget,
    );
  });

  test('software developer shows role-specific interview types', () {
    final types = InterviewTypeScreen.getTypesForRole('Software Developer');
    final names = types.map((type) => type.name).toList();

    expect(types.length, 6);
    expect(
      names,
      containsAll([
        'Technical',
        'Coding',
        'System Design',
        'Behavioral',
        'Situational',
        'HR',
      ]),
    );
    expect(names, isNot(contains('Technical Interview')));
    expect(names, isNot(contains('Mixed Interview')));
  });

  test('software developer technical easy bank loads ten questions', () {
    final provider = InterviewProvider(
      role: 'Software Developer',
      type: 'Technical',
      difficulty: 'Easy',
    );

    expect(provider.interview.questions.length, 10);
    expect(provider.interview.questions.first.text, 'What is Object-Oriented Programming (OOP)?');
    expect(provider.interview.questions.last.text, 'What is version control and why is Git used?');
  });
}
