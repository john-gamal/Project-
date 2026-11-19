import 'package:flutter/material.dart';
import '../../core/ui.dart';
import '../../data/medical_store.dart';
class BookDoctorScreen extends StatelessWidget {
  const BookDoctorScreen({super.key});
  @override Widget build(BuildContext context)=>AppShell(title:'Book a doctor',child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    const SectionTitle('Available doctors (demo directory)'),
    for(final d in [('Dr. Carly Walsh','Endocrinology'),('Dr. Yara Wahab','Cardiology'),('Dr. Omar Saad','General medicine')])
      TileCard(title:d.$1,subtitle:d.$2,icon:Icons.medical_services_outlined,trailing:const Icon(Icons.chevron_right),onTap:()=>_book(context,d.$1,d.$2)),
    const Padding(padding:EdgeInsets.only(top:16),child:Text('Booking is saved on this device only. No doctor or clinic is contacted.',style:TextStyle(color:muted,fontSize:12)))]));
  Future<void> _book(BuildContext context,String doctor,String specialty) async {
    final day=await showDatePicker(context:context,initialDate:DateTime.now().add(const Duration(days:1)),firstDate:DateTime.now(),lastDate:DateTime.now().add(const Duration(days:365)));
    if(day==null||!context.mounted)return;
    final time=await showTimePicker(context:context,initialTime:const TimeOfDay(hour:10,minute:0));
    if(time==null||!context.mounted)return;
    final date='${day.year}-${day.month.toString().padLeft(2,'0')}-${day.day.toString().padLeft(2,'0')} ${time.format(context)}';
    MedicalStore.instance.addVisit(MedicalVisit(doctor,specialty,date,upcoming:true));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Demo appointment saved locally — not sent to the doctor')));
    Navigator.pop(context);
  }
}
