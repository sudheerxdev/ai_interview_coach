import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract final class SupabaseConfig {
  static const url = String.fromEnvironment('SUPABASE_URL');
  static const publishableKey = String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');

  static bool get isConfigured => url.isNotEmpty && publishableKey.isNotEmpty;

  static Future<bool> initializeIfConfigured() async {
    if (!isConfigured) {
      debugPrint(
        'Supabase is not configured. Running with local data. '
        'Pass SUPABASE_URL and SUPABASE_PUBLISHABLE_KEY with --dart-define.',
      );
      return false;
    }

    await Supabase.initialize(
      url: url,
      publishableKey: publishableKey,
    );
    return true;
  }

  static SupabaseClient get client => Supabase.instance.client;
}