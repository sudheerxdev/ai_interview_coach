enum SubscriptionPlan { free, premium }

class SubscriptionModel {
	const SubscriptionModel({
		required this.plan,
		required this.status,
		required this.interviewsUsed,
		required this.interviewLimit,
	});

	final SubscriptionPlan plan;
	final String status;
	final int interviewsUsed;
	final int interviewLimit;

	bool get isPremium => plan == SubscriptionPlan.premium;
	int get remainingInterviews =>
			(interviewLimit - interviewsUsed).clamp(0, interviewLimit);
}
