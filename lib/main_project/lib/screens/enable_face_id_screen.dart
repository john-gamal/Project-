import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../features/patient/patient_screens.dart';
import '../../data/auth_cubit.dart';

// بتظهر بعد أول تسجيل دخول
class EnableFaceIdScreen extends StatelessWidget {
  const EnableFaceIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEEF0F7), Color(0xFFE6DDF8), Color(0xFFDCCFF7)],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDDE6FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.radio_button_checked,
                            size: 30,
                            color: Color(0xFF2563EB),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Enable Face ID?',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0B0B14),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Sign in faster next time. Your credentials stay encrypted on this device. You can change this later in Security.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 11, color: Color(0xFF8A8A99), height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),

                // Enable Face ID
                InkWell(
                  onTap: () async {final ok=await context.read<AuthCubit>().enableBiometrics();if(context.mounted){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(ok?'Biometric unlock enabled':'Biometrics unavailable or cancelled')));Navigator.of(context).pushNamedAndRemoveUntil(context.read<AuthCubit>().role=='doctor'?'/doctor/home':'/patient/home',(_)=>false);}},
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF07070F),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Enable Face ID',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Not now
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(context.read<AuthCubit>().role=='doctor'?'/doctor/home':'/patient/home',(_)=>false);
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Not now',
                      style: TextStyle(
                        color: Color(0xFF0B0B14),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}