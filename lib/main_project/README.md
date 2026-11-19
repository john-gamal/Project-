# MediCore – Flutter UI integration

This ZIP contains the original 13 authentication/onboarding screens from the uploaded archive, 20 additional screens, centralized routes, and an in-memory demo store. Existing screens are under `lib/main_project/screens/` without renaming their classes.

## Running

A Flutter SDK and platform scaffolding are required (the supplied source archive contained no Android/iOS/Windows folders and its `main.dart` was empty). In the extracted project directory:

```bash
flutter create --project-name project --platforms=android,ios,web .
flutter pub get
flutter run
```

If you already have an existing Flutter project, copy the `lib/` directory and merge the `pubspec.yaml` settings; keep the package name `project` or adjust the two old `package:project/...` imports.

## Navigation

`lib/main.dart` is the app entry point and starts on the ORIGINAL Welcome screen (`/`).

- Welcome → Patient Sign in → Home (demo login with any nonempty email + password `correct`)
- Welcome → Create account → Home (valid UI fields; local demo only)
- Home bottom navigation → Records / Visits / Notifications / Profile
- Records → Medical history / Allergies / Medications / Labs / Documents
- Documents → Search/Filter → Upload → Progress → Documents; document → Image/PDF viewer → OCR or Share → Shared access
- Shared access → Revoke; Profile → Edit profile, access management or Log out → Welcome

## Added screens, same image order

Patient Dashboard & Navigation: Home, Record hub, Medical history, Allergies, Add allergy, Medications, Labs & measurements, Visits, Notifications, Profile, Edit profile, Log out.

Medical Documents: Files search & filter, Upload, Upload progress, Image viewer, PDF viewer, OCR extracted text, Share with doctor, Shared access, Access restricted.

## Important boundaries

This is **UI + functional local demo state**, not a live medical service. Medical records and sharing/revoke actions are stored **in memory only**, reset on restart. PDF/image viewer previews and OCR content are explicit placeholders. Real file picking/storage, OCR, downloads, doctor permissions, biometric authentication, real accounts, network upload and secure access controls require API/backend integration. Do NOT ship as a medical product with demo authorization or sample lab results.

The original doctor-auth and password-reset workflows remain essentially unchanged, as they require backend integration. The original patient sign-in was already mock authentication (`correct`), which now navigates to Home.
