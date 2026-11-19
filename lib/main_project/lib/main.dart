import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/ui.dart';
import 'data/auth_service.dart';
import 'data/auth_cubit.dart';
import 'data/medical_store.dart';
import 'features/patient/patient_screens.dart';
import 'features/patient/book_doctor_screen.dart';
import 'features/doctor/doctor_home_screen.dart';
import 'features/documents/document_screens.dart';
import 'screens/welcome_screen.dart';
import 'screens/quick_unlock_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthCubit>(create: (_) => AuthCubit(AuthService.instance)),
    BlocProvider<MedicalStore>.value(value: MedicalStore.instance),
  ], child: const MediCoreApp()));
}

class MediCoreApp extends StatelessWidget {
  const MediCoreApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'MediCore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF6F5FC),
          colorScheme: ColorScheme.fromSeed(seedColor: blue)),
      home: const LaunchGate(),
      onGenerateRoute: (settings) {
        final arg = settings.arguments;
        final doc = arg is MedicalDocument ? arg : null;
        final widget = switch (settings.name) {
          '/' => const WelcomeScreen(),
          '/patient/home' => const PatientHomeScreen(),
          '/patient/records' => const RecordHubScreen(),
          '/patient/history' => const MedicalHistoryScreen(),
          '/patient/allergies' => const AllergiesScreen(),
          '/patient/allergies/add' => const AddAllergyScreen(),
          '/patient/medications' => const MedicationsScreen(),
          '/patient/labs' => const LabsScreen(),
          '/patient/visits' => const VisitsScreen(),
          '/patient/visits/book' => const BookDoctorScreen(),
          '/patient/notifications' => const NotificationsScreen(),
          '/patient/profile' => const ProfileScreen(),
          '/patient/profile/edit' => const EditProfileScreen(),
          '/patient/logout' => const LogoutScreen(),
          '/doctor/home' => const DoctorHomeScreen(),
          '/documents' => const DocumentsScreen(),
          '/documents/upload' => const UploadDocumentScreen(),
          '/documents/progress' => UploadProgressScreen(
              name: arg is Map
                  ? (arg['name']?.toString() ?? 'Document')
                  : 'Document',
              kind: arg is Map
                  ? (arg['kind']?.toString() ?? 'Document')
                  : 'Document'),
          '/documents/image' => ImageViewerScreen(document: doc),
          '/documents/pdf' => PdfViewerScreen(document: doc),
          '/documents/ocr' => OcrScreen(document: doc),
          '/documents/share' => ShareDoctorScreen(document: doc),
          '/documents/access' => const SharedAccessScreen(),
          '/documents/restricted' => const RestrictedAccessScreen(),
          _ => const WelcomeScreen(),
        };
        return MaterialPageRoute(builder: (_) => widget, settings: settings);
      });
}

class LaunchGate extends StatefulWidget {
  const LaunchGate({super.key});
  @override
  State<LaunchGate> createState() => _LaunchGateState();
}

class _LaunchGateState extends State<LaunchGate> {
  late final Future<bool> restored = context.read<AuthCubit>().restore();
  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
      future: restored,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        if (snapshot.data != true) return const WelcomeScreen();
        return FutureBuilder<bool>(
            future: context.read<AuthCubit>().biometricEnabled,
            builder: (context, b) {
              if (!b.hasData)
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              if (b.data == true) return const QuickUnlockScreen();
              return context.read<AuthCubit>().role == 'doctor'
                  ? const DoctorHomeScreen()
                  : const PatientHomeScreen();
            });
      });
}
