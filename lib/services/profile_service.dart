import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/supabase_config.dart';
import '../models/profile_model.dart';

class ProfileService {
  const ProfileService();

  Future<ProfileModel?> loadProfile() async {
    if (!SupabaseConfig.isConfigured) return null;
    final client = SupabaseConfig.client;
    final user = client.auth.currentUser;
    if (user == null) return null;

    final row = await client
        .from('profiles')
        .select('id, full_name, avatar_url')
        .eq('id', user.id)
        .maybeSingle();
    return ProfileModel(
      id: user.id,
      email: user.email ?? 'Email unavailable',
      fullName: row?['full_name'] as String? ??
          user.userMetadata?['full_name'] as String? ??
          '',
      avatarUrl: row?['avatar_url'] as String?,
    );
  }

  Future<ProfileModel> updateProfile({required String fullName}) async {
    final client = SupabaseConfig.client;
    final user = client.auth.currentUser;
    if (user == null) throw const AuthException('You are not signed in.');

    final row = await client
        .from('profiles')
        .update({'full_name': fullName.trim(), 'updated_at': DateTime.now().toUtc().toIso8601String()})
        .eq('id', user.id)
        .select('id, full_name, avatar_url')
        .single();
    return ProfileModel(
      id: user.id,
      email: user.email ?? 'Email unavailable',
      fullName: row['full_name'] as String? ?? '',
      avatarUrl: row['avatar_url'] as String?,
    );
  }
}
