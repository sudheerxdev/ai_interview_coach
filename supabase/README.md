# Supabase setup

1. Create a project at https://supabase.com/dashboard.
2. Open the project SQL Editor.
3. Run `migrations/20260918_initial_schema.sql`.
4. From the project Connect/API settings, copy the Project URL and Publishable key.
5. Run the Flutter app with build-time values:

```powershell
flutter run -d emulator-5554 `
  --dart-define=SUPABASE_URL=https://your-project-ref.supabase.co `
  --dart-define=SUPABASE_PUBLISHABLE_KEY=your-publishable-key
```

Never use a `service_role` key or secret key in Flutter. Keep those keys on trusted
server-side infrastructure such as Supabase Edge Functions.

Without these defines, the app intentionally starts in local/offline mode.

## Release APK for a physical Android phone

The same public configuration is compiled into a release APK at build time:

```powershell
flutter clean
flutter pub get
flutter build apk --release `
  --dart-define=SUPABASE_URL=https://your-project-ref.supabase.co `
  --dart-define=SUPABASE_PUBLISHABLE_KEY=your-publishable-key
```

The APK is created at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Install it with a USB-connected, USB-debugging-enabled phone using:

```powershell
adb install -r build/app/outputs/flutter-apk/app-release.apk
```

After installation, the phone only needs internet access. Flutter, VS Code, and
the laptop do not need to keep running. The APK connects directly to Supabase.

Only the project URL and publishable key belong in the APK. Never include a
`service_role` key, secret key, database password, or third-party AI provider
secret. Those must remain on trusted server-side infrastructure.
