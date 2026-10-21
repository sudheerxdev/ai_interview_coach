import 'package:flutter/material.dart';

import 'app/app.dart';
import 'config/supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initializeIfConfigured();
  runApp(const AIInterviewCoachApp());
}
