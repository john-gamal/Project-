import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../data/auth_cubit.dart';
import '../../core/ui.dart';
class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});
  @override Widget build(BuildContext context)=>AppShell(title:'Doctor dashboard',back:false,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    const SizedBox(height:20),Text('Welcome, Dr. ${context.read<AuthCubit>().name??'Doctor'}',style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold)),
    const SizedBox(height:10),const Text('Doctor workspace — separate from patient medical records.'),
    const SectionTitle('Your workspace'),
    const TileCard(title:'Appointments',subtitle:'Requires a backend to receive patient bookings',icon:Icons.calendar_month),
    const TileCard(title:'Patient records',subtitle:'Requires verified consent and secure backend access',icon:Icons.medical_services_outlined),
    const TileCard(title:'Verification',subtitle:'Local registration does not verify a medical license',icon:Icons.verified_user_outlined),
    const SizedBox(height:24),ActionPill('Enable biometric unlock',secondary:true,onTap:()async{final ok=await context.read<AuthCubit>().enableBiometrics();if(context.mounted)message(context,ok?'Biometric unlock enabled':'Biometrics unavailable or cancelled');}),
    const SizedBox(height:12),ActionPill('Log out',onTap:()async{await context.read<AuthCubit>().signOut();if(context.mounted)Navigator.of(context).pushNamedAndRemoveUntil('/',(_)=>false);})]));
}
