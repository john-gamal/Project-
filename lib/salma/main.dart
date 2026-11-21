import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'routes.dart';
import 'theme.dart';

void main() => runApp(const MediCoreApp());

class MediCoreApp extends StatelessWidget {
  const MediCoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediCore',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // English only for now. To preview RTL, uncomment the next line.
      // locale: const Locale('ar'),
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: AppRoutes.index,
      routes: AppRoutes.table,
    );
  }
}
