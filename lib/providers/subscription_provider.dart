import 'package:flutter/foundation.dart';

import '../models/subscription_model.dart';
import '../services/subscription_service.dart';

class SubscriptionProvider extends ChangeNotifier {
	SubscriptionProvider({SubscriptionService? service})
		: _service = service ?? const SubscriptionService();

	final SubscriptionService _service;
	SubscriptionModel? subscription;
	bool isLoading = false;
	String? errorMessage;

	Future<void> load() async {
		isLoading = true;
		errorMessage = null;
		notifyListeners();
		try {
			subscription = await _service.loadSubscription();
		} catch (_) {
			errorMessage = 'Unable to load subscription status.';
		} finally {
			isLoading = false;
			notifyListeners();
		}
	}
}
