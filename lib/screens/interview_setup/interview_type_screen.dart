import 'package:flutter/material.dart';

import '../../app/routes.dart';

class InterviewTypeOption {
	const InterviewTypeOption({
		required this.name,
		required this.description,
	});

	final String name;
	final String description;
}

class InterviewTypeScreen extends StatelessWidget {
	const InterviewTypeScreen({super.key, this.selectedRole});

	final String? selectedRole;

	static const Map<String, List<InterviewTypeOption>> roleTypeOptions = {
		'Software Developer': [
			InterviewTypeOption(name: 'Technical', description: 'Programming fundamentals, OOP, APIs, databases and debugging.'),
			InterviewTypeOption(name: 'Coding', description: 'Algorithms, data structures, logical reasoning and coding problems.'),
			InterviewTypeOption(name: 'System Design', description: 'Architecture, APIs, scalability and database design.'),
			InterviewTypeOption(name: 'Behavioral', description: 'Teamwork, ownership, communication and leadership.'),
			InterviewTypeOption(name: 'Situational', description: 'Production issues, deadlines and technical decisions.'),
			InterviewTypeOption(name: 'HR', description: 'Motivation, career goals and company fit.'),
		],
		'Technical Support': [
			InterviewTypeOption(name: 'Technical Troubleshooting', description: 'Hardware, software, network, and root-cause analysis.'),
			InterviewTypeOption(name: 'Customer Handling', description: 'Explaining issues, escalations and ticket management.'),
			InterviewTypeOption(name: 'Situational', description: 'Critical incidents, outages and service disruption handling.'),
			InterviewTypeOption(name: 'Behavioral', description: 'Stress management, teamwork and ownership.'),
			InterviewTypeOption(name: 'HR', description: 'Introduction, motivation and role expectations.'),
		],
		'Customer Support': [
			InterviewTypeOption(name: 'Customer Handling', description: 'Complaint resolution, empathy and service recovery.'),
			InterviewTypeOption(name: 'Communication Roleplay', description: 'Simulated calls with angry, confused and demanding customers.'),
			InterviewTypeOption(name: 'Situational', description: 'Policy conflicts, escalations and difficult customer scenarios.'),
			InterviewTypeOption(name: 'Behavioral', description: 'Patience, communication and ownership under pressure.'),
			InterviewTypeOption(name: 'HR', description: 'Career goals, motivation and team fit.'),
		],
		'Data Analyst': [
			InterviewTypeOption(name: 'SQL & Data', description: 'Joins, aggregations, cleaning, queries and database concepts.'),
			InterviewTypeOption(name: 'Case Study', description: 'KPI and business data analysis with recommendations.'),
			InterviewTypeOption(name: 'Analytical', description: 'Data interpretation, metrics and logical reasoning.'),
			InterviewTypeOption(name: 'Behavioral', description: 'Stakeholder communication and teamwork.'),
			InterviewTypeOption(name: 'HR', description: 'Career goals, motivation and company fit.'),
		],
		'Business Analyst': [
			InterviewTypeOption(name: 'Requirement Analysis', description: 'Requirements, FRDs, acceptance criteria and validation.'),
			InterviewTypeOption(name: 'Case Study', description: 'Business process analysis and recommendations.'),
			InterviewTypeOption(name: 'Situational', description: 'Conflicting stakeholders and changing business needs.'),
			InterviewTypeOption(name: 'Behavioral', description: 'Communication, stakeholder management and ownership.'),
			InterviewTypeOption(name: 'HR', description: 'Introduction, motivation and career expectations.'),
		],
		'Sales': [
			InterviewTypeOption(name: 'Sales Roleplay', description: 'Product pitch, discovery calls and objection handling.'),
			InterviewTypeOption(name: 'Negotiation', description: 'Price objections, value conversations and deal closure.'),
			InterviewTypeOption(name: 'Situational', description: 'Lost deals, difficult prospects and target pressure.'),
			InterviewTypeOption(name: 'Behavioral', description: 'Resilience, communication and ownership.'),
			InterviewTypeOption(name: 'HR', description: 'Career goals, motivation and company fit.'),
		],
		'Banking': [
			InterviewTypeOption(name: 'Banking Knowledge', description: 'Accounts, loans, cards, payments and banking basics.'),
			InterviewTypeOption(name: 'Compliance & Risk', description: 'KYC, AML, fraud indicators and risk identification.'),
			InterviewTypeOption(name: 'Customer Handling', description: 'Banking complaints, payments and customer escalations.'),
			InterviewTypeOption(name: 'Situational', description: 'Suspicious transactions, fraud and compliance decisions.'),
			InterviewTypeOption(name: 'HR', description: 'Career goals, motivation and banking fit.'),
		],
		'Finance': [
			InterviewTypeOption(name: 'Financial Technical', description: 'Statements, ratios, accounting and valuation fundamentals.'),
			InterviewTypeOption(name: 'Case Study', description: 'Company analysis, forecasts and financial recommendations.'),
			InterviewTypeOption(name: 'Analytical', description: 'Financial reasoning, risk and business problem solving.'),
			InterviewTypeOption(name: 'Situational', description: 'Budget pressure, forecasts and trade-off decisions.'),
			InterviewTypeOption(name: 'HR', description: 'Career goals, motivation and company fit.'),
		],
		'QA Tester': [
			InterviewTypeOption(name: 'Testing Technical', description: 'SDLC, STLC, regression, smoke and test planning.'),
			InterviewTypeOption(name: 'Defect Analysis', description: 'Bug severity, reproduction, root cause and reporting.'),
			InterviewTypeOption(name: 'Automation', description: 'Automation strategy, testing frameworks and regressions.'),
			InterviewTypeOption(name: 'Situational', description: 'Production issues, critical defects and release problems.'),
			InterviewTypeOption(name: 'Behavioral', description: 'Quality mindset, teamwork and ownership.'),
		],
		'Project Manager': [
			InterviewTypeOption(name: 'Project Case Study', description: 'Planning, risk, scheduling and delivery trade-offs.'),
			InterviewTypeOption(name: 'Situational', description: 'Project delays, scope changes and stakeholder issues.'),
			InterviewTypeOption(name: 'Leadership & Stakeholder', description: 'Stakeholder management, conflict resolution and leadership.'),
			InterviewTypeOption(name: 'Behavioral', description: 'Leadership, ownership and communication.'),
			InterviewTypeOption(name: 'HR', description: 'Career goals, motivation and project-management fit.'),
		],
	};

	static List<InterviewTypeOption> getTypesForRole(String? selectedRole) {
		if (selectedRole == null || selectedRole.trim().isEmpty) {
			return const [];
		}
		return roleTypeOptions[selectedRole] ?? const [];
	}

	@override
	Widget build(BuildContext context) {
		final types = getTypesForRole(selectedRole);

		return Scaffold(
			appBar: AppBar(title: const Text('Interview setup')),
			body: ListView(
				padding: const EdgeInsets.all(20),
				children: [
					Text(
						'Choose an interview type',
						style: Theme.of(context).textTheme.headlineSmall,
					),
					const SizedBox(height: 8),
					Text(
						selectedRole == null || selectedRole!.trim().isEmpty
								? 'Choose the style you want to practice.'
								: 'Practicing for $selectedRole.',
						style: Theme.of(context).textTheme.bodyLarge,
					),
					const SizedBox(height: 20),
					if (types.isEmpty)
						Padding(
							padding: const EdgeInsets.symmetric(vertical: 16),
							child: Text(
								'No interview types are configured for this role yet.',
								style: Theme.of(context).textTheme.bodyLarge,
							),
						)
					else
						...types.map(
							(type) => Card(
								child: ListTile(
									onTap: () => Navigator.pushNamed(
										context,
										AppRoutes.difficulty,
										arguments: {
											'role': selectedRole,
											'type': type.name,
										},
									),
									leading: const Icon(Icons.forum_outlined),
									title: Text(type.name),
									subtitle: Text(type.description),
									trailing: const Icon(Icons.chevron_right_rounded),
								),
							),
						),
				],
			),
		);
	}
}
