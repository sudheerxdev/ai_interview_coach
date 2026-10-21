import '../config/supabase_config.dart';
import '../models/subscription_model.dart';

class SubscriptionService {
	const SubscriptionService();

	Future<SubscriptionModel> loadSubscription() async {
		if (SupabaseConfig.isConfigured && SupabaseConfig.client.auth.currentUser != null) {
			try {
				final row = await SupabaseConfig.client
						.from('subscriptions')
						.select('plan, status')
						.eq('user_id', SupabaseConfig.client.auth.currentUser!.id)
						.maybeSingle();
				if (row != null) {
					return SubscriptionModel(
						plan: row['plan'] == 'premium'
								? SubscriptionPlan.premium
								: SubscriptionPlan.free,
						status: row['status'] as String? ?? 'active',
						interviewsUsed: 0,
						interviewLimit: row['plan'] == 'premium' ? 50 : 5,
					);
				}
			} catch (_) {
				// Fall back to the safe local plan when the backend is unavailable.
			}
		}

		return const SubscriptionModel(
			plan: SubscriptionPlan.free,
			status: 'active',
			interviewsUsed: 0,
			interviewLimit: 5,
		);
	}
}
