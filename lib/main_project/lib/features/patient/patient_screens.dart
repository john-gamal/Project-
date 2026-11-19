import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/ui.dart';
import '../../data/medical_store.dart';
import '../../data/auth_cubit.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});
  @override Widget build(BuildContext context) => AppShell(title: 'Home', back: false,
    bottom: const PatientTabs(selected: 0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    BlocBuilder<MedicalStore, MedicalState>( builder: (context, _) => Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Good morning, ${MedicalStore.instance.patientName.split(' ').first} 👋',
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 23)),
      const SizedBox(height: 6), const Text('Your health, all in one place.', style: TextStyle(color: muted))])),
    const SectionTitle('Quick actions'),
    GridView.count(crossAxisCount: 2, shrinkWrap: true, mainAxisSpacing: 9,
      crossAxisSpacing: 9, childAspectRatio: 2.05, physics: const NeverScrollableScrollPhysics(), children: [
      _shortcut(context,'Book a visit',Icons.calendar_month,'/patient/visits'),
      _shortcut(context,'Documents',Icons.folder_open,'/documents'),
      _shortcut(context,'Add condition',Icons.favorite_border,'/patient/history'),
      _shortcut(context,'Emergency',Icons.emergency_outlined,'/patient/profile'),
    ]),
    const SectionTitle('Your health at a glance'),
    Row(children: [Expanded(child: _metric('Heart rate','72','bpm',Icons.favorite)),
      const SizedBox(width: 9),Expanded(child: _metric('Blood pressure','120/80','mmHg',Icons.monitor_heart))]),
    const SectionTitle('Your health records'),
    TileCard(title: 'Medical history', subtitle: 'Conditions & past treatments', icon: Icons.medical_information_outlined,
      onTap: () => go(context, '/patient/history')),
    TileCard(title: 'Allergies', subtitle: 'View your recorded allergies', icon: Icons.health_and_safety,
      onTap: () => go(context, '/patient/allergies')),
    TileCard(title: 'Medications', subtitle: 'Current and past prescriptions', icon: Icons.medication_outlined,
      onTap: () => go(context, '/patient/medications')),
    TileCard(title: 'Labs & measurements', subtitle: 'Lab reports and vitals', icon: Icons.science_outlined,
      onTap: () => go(context, '/patient/labs')),
  ]));
  Widget _shortcut(BuildContext c, String name, IconData icon, String route) =>
    InkWell(onTap: () => go(c,route), child: Container(padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(16)),
      child: Row(children: [Icon(icon,color:blue,size:22),const SizedBox(width:9),
        Expanded(child: Text(name,style:const TextStyle(fontSize:12,fontWeight:FontWeight.w700)))])));
  Widget _metric(String title,String value,String unit,IconData icon) =>
    Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(17)),
      child: Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:blue),const SizedBox(height:9),
        Text(title,style:const TextStyle(color:muted,fontSize:11)),Text(value,style:const TextStyle(fontWeight:FontWeight.w800,fontSize:20)),
        Text(unit,style:const TextStyle(color:muted,fontSize:10))]));
}

class RecordHubScreen extends StatelessWidget {
  const RecordHubScreen({super.key});
  @override Widget build(BuildContext context) => AppShell(title:'My record',bottom:const PatientTabs(selected:1),
    child: Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      const SectionTitle('Your medical record'),
      TileCard(title:'Medical history',subtitle:'3 chronic conditions',icon:Icons.favorite_border,color:const Color(0xFFFFEAEA),onTap:()=>go(context,'/patient/history')),
      TileCard(title:'Allergies',subtitle:'Recorded allergies',icon:Icons.warning_amber,color:const Color(0xFFFFF1DF),onTap:()=>go(context,'/patient/allergies')),
      TileCard(title:'Medications',subtitle:'Current medications',icon:Icons.medication_outlined,color:const Color(0xFFEDE9FF),onTap:()=>go(context,'/patient/medications')),
      TileCard(title:'Labs & measurements',subtitle:'Recent lab results',icon:Icons.science_outlined,onTap:()=>go(context,'/patient/labs')),
      TileCard(title:'Visits',subtitle:'Upcoming and past visits',icon:Icons.event_note,onTap:()=>go(context,'/patient/visits')),
      TileCard(title:'Documents',subtitle:'Upload and manage files',icon:Icons.folder_copy_outlined,onTap:()=>go(context,'/documents')),
      const SectionTitle('Important'),
      TileCard(title:'Emergency medical card',subtitle:'Keep your health details up to date',icon:Icons.emergency_outlined,color:const Color(0xFFFFE5E5),onTap:()=>go(context,'/patient/profile')),
    ]));
}

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});
  @override State<MedicalHistoryScreen> createState()=>_MedicalHistoryScreenState();
}
class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  final controller=TextEditingController();
  @override void dispose(){controller.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>AppShell(title:'Medical history',
    actions:[IconButton(onPressed:()=>_add(context),icon:const Icon(Icons.add))],
    child:BlocBuilder<MedicalStore, MedicalState>(builder:(context,_)=>Column(
      crossAxisAlignment:CrossAxisAlignment.start,children:[const SectionTitle('Chronic conditions'),
      for(final c in MedicalStore.instance.conditions) TileCard(title:c,subtitle:'Recorded condition',icon:Icons.favorite_border,
        trailing:IconButton(tooltip:'Delete condition',onPressed:()=>MedicalStore.instance.removeCondition(c),icon:const Icon(Icons.delete_outline))),
      const SectionTitle('Past history'),
      for(var i=0;i<MedicalStore.instance.pastHistory.length;i++) TileCard(title:MedicalStore.instance.pastHistory[i],subtitle:'Tap to edit or delete',icon:Icons.history,onTap:()=>_editPast(i),trailing:IconButton(icon:const Icon(Icons.delete_outline),onPressed:()=>MedicalStore.instance.removePastHistory(i))),
      ActionPill('Add past history',secondary:true,onTap:()=>_editPast(null),icon:Icons.add),
      const SizedBox(height:16),ActionPill('Add condition',onTap:()=>_add(context),icon:Icons.add)])));
  void _editPast(int? index) {
    final controller=TextEditingController(text:index==null?'':MedicalStore.instance.pastHistory[index]);
    showDialog(context:context,builder:(d)=>AlertDialog(title:Text(index==null?'Add past history':'Edit past history'),content:TextField(controller:controller,decoration:const InputDecoration(labelText:'Event / treatment / date')),actions:[
      TextButton(onPressed:()=>Navigator.pop(d),child:const Text('Cancel')),
      TextButton(onPressed:(){if(controller.text.trim().isNotEmpty){if(index==null){MedicalStore.instance.addPastHistory(controller.text.trim());}else{MedicalStore.instance.editPastHistory(index,controller.text.trim());}Navigator.pop(d);}},child:const Text('Save'))])).then((_){controller.dispose();});
  }
  void _add(BuildContext context)=>showDialog(context:context,builder:(c)=>AlertDialog(title:const Text('Add condition'),
    content:TextField(controller:controller,decoration:const InputDecoration(hintText:'Condition name')),
    actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Cancel')),
      TextButton(onPressed:(){if(controller.text.trim().isNotEmpty){MedicalStore.instance.addCondition(controller.text.trim());
        controller.clear();Navigator.pop(c);}},child:const Text('Add'))]));
}

class AllergiesScreen extends StatelessWidget {
  const AllergiesScreen({super.key});
  @override Widget build(BuildContext context)=>AppShell(title:'Allergies',child:BlocBuilder<MedicalStore, MedicalState>(builder:(c,_)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:const Color(0xFFFFE5E5),borderRadius:BorderRadius.circular(15)),
        child:Text('${MedicalStore.instance.allergies.length} recorded allergies',style:const TextStyle(fontWeight:FontWeight.bold))),
      const SectionTitle('Known allergies'),
      for(final allergy in MedicalStore.instance.allergies) TileCard(title:allergy.name,
        subtitle:allergy.reaction,icon:Icons.warning_amber_rounded,color:const Color(0xFFFFF0E8),
        trailing:StatusTag(allergy.severity,color:allergy.severity=='Severe'?Colors.red:Colors.orange)),
      const SizedBox(height:16),ActionPill('Add allergy',icon:Icons.add,
        onTap:()=>go(context,'/patient/allergies/add'))])));
}

class AddAllergyScreen extends StatefulWidget {
  const AddAllergyScreen({super.key});
  @override State<AddAllergyScreen> createState()=>_AddAllergyScreenState();
}
class _AddAllergyScreenState extends State<AddAllergyScreen> {
  final name=TextEditingController(),reaction=TextEditingController();
  String severity='Mild',type='Food';
  @override void dispose(){name.dispose();reaction.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>AppShell(title:'Add allergy',child:Column(
    crossAxisAlignment:CrossAxisAlignment.start,children:[
      const SectionTitle('Allergy information'),InputField('Allergen',controller:name,hint:'e.g. Peanuts, dust, penicillin'),
      const Text('Type',style:TextStyle(fontWeight:FontWeight.bold)),
      Wrap(spacing:7,children:[for(final t in ['Food','Drug','Environmental','Other'])
        ChoiceChip(label:Text(t),selected:type==t,onSelected:(_)=>setState(()=>type=t))]),
      const SectionTitle('Severity'),Wrap(spacing:7,children:[for(final s in ['Mild','Moderate','Severe'])
        ChoiceChip(label:Text(s),selected:severity==s,onSelected:(_)=>setState(()=>severity=s))]),
      InputField('Reaction details',controller:reaction,hint:'Describe the reaction',lines:3),
      const SizedBox(height:20),ActionPill('Save allergy',icon:Icons.check,
        onTap:(){if(name.text.trim().isEmpty){message(context,'Enter an allergen first');return;}
          MedicalStore.instance.addAllergy(name.text.trim(),severity,reaction.text.trim());
          Navigator.pop(context);})]));
}

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});
  @override State<MedicationsScreen> createState()=>_MedicationsScreenState();
}
class _MedicationsScreenState extends State<MedicationsScreen> {
  bool current=true;
  void _addMedicine(){
    final c=TextEditingController();
    showDialog(context:context,builder:(d)=>AlertDialog(title:const Text('Add medication'),content:TextField(controller:c,decoration:const InputDecoration(labelText:'Medicine and dose')),actions:[TextButton(onPressed:()=>Navigator.pop(d),child:const Text('Cancel')),TextButton(onPressed:(){if(c.text.trim().isNotEmpty){MedicalStore.instance.addMedication(c.text.trim());Navigator.pop(d);}},child:const Text('Add'))])).then((_){c.dispose();});
  }
  @override Widget build(BuildContext context)=>AppShell(title:'Medications',actions:[IconButton(onPressed:_addMedicine,icon:const Icon(Icons.add))],child:BlocBuilder<MedicalStore, MedicalState>(builder:(c,_)=>Column(children:[
      Row(children:[Expanded(child:ChoiceChip(label:const Text('Current'),selected:current,onSelected:(_)=>setState(()=>current=true))),
        Expanded(child:ChoiceChip(label:const Text('Prescriptions'),selected:!current,onSelected:(_)=>setState(()=>current=false)))]),
      const SectionTitle('Latest medications'),
      if(current) for(final medicine in MedicalStore.instance.medications)
        TileCard(title:medicine,subtitle:'Follow prescribing doctor instructions',icon:Icons.medication_outlined,
          trailing:IconButton(tooltip:'Delete medication',onPressed:()=>MedicalStore.instance.removeMedication(medicine),icon:const Icon(Icons.delete_outline))),
      if(!current) for(final medicine in MedicalStore.instance.medications)
        TileCard(title:medicine,subtitle:'Prescription record',icon:Icons.description_outlined),
      const SectionTitle('Prescriptions'),
      TileCard(title:'Prescription – Dr. Yara',subtitle:'02 Nov 2026',icon:Icons.receipt_long,
        onTap:()=>go(context,'/documents/pdf')),
      ActionPill('Add medication',onTap:_addMedicine,icon:Icons.add),
      ActionPill('View all documents',onTap:()=>go(context,'/documents'),secondary:true)])));
}

class LabsScreen extends StatelessWidget {
  const LabsScreen({super.key});
  @override Widget build(BuildContext context)=>AppShell(title:'Labs & measurements',child:BlocBuilder<MedicalStore, MedicalState>(builder:(context,_)=>Column(children:[
    const SectionTitle('Latest measurements'),
    Row(children:[_mini('Glucose','96','mg/dL'),const SizedBox(width:9),_mini('Blood pressure','120/80','mmHg')]),
    const SizedBox(height:9),Row(children:[_mini('Weight',MedicalStore.instance.weight.toStringAsFixed(1),'kg'),const SizedBox(width:9),_mini('Heart rate','72','bpm')]),
    const SectionTitle('Lab reports'),
    TileCard(title:'Complete Blood Count',subtitle:'12 Nov 2026 · Normal',icon:Icons.biotech,
      trailing:const StatusTag('Normal'),onTap:()=>go(context,'/documents/pdf')),
    TileCard(title:'Lipid panel',subtitle:'07 Nov 2026 · Reviewed',icon:Icons.science,
      trailing:const StatusTag('Reviewed',color:Colors.orange),onTap:()=>go(context,'/documents/pdf')),
    ActionPill('View all medical documents',onTap:()=>go(context,'/documents'))])));
  Widget _mini(String title,String value,String unit)=>Expanded(child:Container(padding:const EdgeInsets.all(14),
    decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(16)),child:Column(
      crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(color:muted,fontSize:11)),
      const SizedBox(height:8),Text(value,style:const TextStyle(fontWeight:FontWeight.w800,fontSize:20)),
      Text(unit,style:const TextStyle(fontSize:10,color:muted))])));
}

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});
  @override State<VisitsScreen> createState()=>_VisitsScreenState();
}
class _VisitsScreenState extends State<VisitsScreen> {
  bool past=false;
  @override Widget build(BuildContext context)=>AppShell(title:'Visits',bottom:const PatientTabs(selected:2),child:BlocBuilder<MedicalStore, MedicalState>(builder:(c,_) {
    final items=MedicalStore.instance.visits.where((v)=>v.isPast==past).toList();
    return Column(children:[Row(children:[Expanded(child:ChoiceChip(label:const Text('Upcoming'),selected:!past,onSelected:(_)=>setState(()=>past=false))),Expanded(child:ChoiceChip(label:const Text('Past'),selected:past,onSelected:(_)=>setState(()=>past=true)))]),
      SectionTitle(past?'Past visits':'Upcoming visits'),
      for(final v in items) TileCard(title:v.doctor,subtitle:'${v.specialty} · ${v.date}',icon:Icons.person_outline,trailing:IconButton(tooltip:'Remove visit',icon:const Icon(Icons.delete_outline),onPressed:()=>MedicalStore.instance.removeVisit(v))),
      if(items.isEmpty) TileCard(title:past?'No past visits':'No upcoming visits',subtitle:'Appointments saved on this device will appear here',icon:Icons.event_available),
      const SizedBox(height:14),if(!past)ActionPill('Find a doctor & book',icon:Icons.add,onTap:()=>go(context,'/patient/visits/book')),
      const SizedBox(height:10),ActionPill('Your medical documents',onTap:()=>go(context,'/documents'),secondary:true)]);
  }));
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override Widget build(BuildContext context)=>AppShell(title:'Notifications',bottom:const PatientTabs(selected:3),
    child:Column(children:[const SectionTitle('Today'),
      TileCard(title:'Your report is ready',subtitle:'CBC lab result is now available',icon:Icons.description,
        onTap:()=>go(context,'/documents/pdf')),
      TileCard(title:'New prescription added',subtitle:'A prescription has been added to your record',icon:Icons.medication,
        onTap:()=>go(context,'/patient/medications')),
      const SectionTitle('Earlier'),
      TileCard(title:'Lab results ready',subtitle:'Your lipid panel is available',icon:Icons.science,
        onTap:()=>go(context,'/patient/labs')),
      TileCard(title:'Document uploaded',subtitle:'Your recent medical file was saved',icon:Icons.folder_outlined,
        onTap:()=>go(context,'/documents'))]));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override Widget build(BuildContext context)=>AppShell(title:'Profile',back:false,
    bottom:const PatientTabs(selected:4),child:BlocBuilder<MedicalStore, MedicalState>(
      builder:(c,_)=>Column(children:[const SizedBox(height:15),CircleAvatar(radius:34,backgroundColor:const Color(0xFFD9DFFB),child:Text(MedicalStore.instance.initials,style:const TextStyle(fontWeight:FontWeight.w700,fontSize:20))),
      const SizedBox(height:10),Text(MedicalStore.instance.patientName,
        style:const TextStyle(fontWeight:FontWeight.w800,fontSize:20)),
      const Text('Personal account',style:TextStyle(color:muted)),const SizedBox(height:23),
      TileCard(title:'Personal information',subtitle:'Name, birthday, contact',icon:Icons.person_outline,
        onTap:()=>go(context,'/patient/profile/edit')),
      TileCard(title:'Medical ID',subtitle:'Health information and documents',icon:Icons.badge_outlined,
        onTap:()=>go(context,'/patient/records')),
      TileCard(title:'Security & connected doctors',subtitle:'Manage doctor access',icon:Icons.shield_outlined,
        onTap:()=>go(context,'/documents/access')),
      TileCard(title:'Biometric security',subtitle:'Enable or disable device authentication',icon:Icons.fingerprint,onTap:()async{final auth=context.read<AuthCubit>();final enabled=await auth.biometricEnabled;if(!context.mounted)return;if(enabled){await auth.disableBiometrics();if(context.mounted)message(context,'Biometric unlock disabled');}else{final ok=await auth.enableBiometrics();if(context.mounted)message(context,ok?'Biometric unlock enabled':'Biometrics unavailable or cancelled');}}),
      TileCard(title:'Notifications',subtitle:'Updates and reminders',icon:Icons.notifications_none,
        onTap:()=>go(context,'/patient/notifications')),
      TileCard(title:'Log out',icon:Icons.logout,color:const Color(0xFFFFE5E5),
        onTap:()=>go(context,'/patient/logout'))])));
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override State<EditProfileScreen> createState()=>_EditProfileScreenState();
}
class _EditProfileScreenState extends State<EditProfileScreen> {
  late final name=TextEditingController(text:MedicalStore.instance.patientName);
  late final phone=TextEditingController(text:MedicalStore.instance.phone);
  late final height=TextEditingController(text:'${MedicalStore.instance.height.toInt()}');
  late final weight=TextEditingController(text:'${MedicalStore.instance.weight.toInt()}');
  late final dob=TextEditingController(text:MedicalStore.instance.birthDate);
  @override void dispose(){for(final c in [name,phone,height,weight,dob]){c.dispose();}super.dispose();}
  @override Widget build(BuildContext context)=>AppShell(title:'Edit profile',child:Column(children:[
    CircleAvatar(radius:32,backgroundColor:const Color(0xFFDCE1FC),child:Text(MedicalStore.instance.initials)),
    const SizedBox(height:24),InputField('Full name',controller:name),
    InputField('Date of birth',controller:dob,hint:'YYYY-MM-DD'),
    InputField('Phone number',controller:phone,keyboardType:TextInputType.phone),
    InputField('Height (cm)',controller:height,keyboardType:TextInputType.number),
    InputField('Weight (kg)',controller:weight,keyboardType:TextInputType.number),
    const SizedBox(height:24),ActionPill('Save changes',onTap:(){
      if(name.text.trim().isEmpty){message(context,'Please enter your name');return;}
      MedicalStore.instance.saveProfile(name.text.trim(),phone.text.trim(),
        double.tryParse(height.text)??MedicalStore.instance.height,
        double.tryParse(weight.text)??MedicalStore.instance.weight,dob:dob.text.trim());
      Navigator.pop(context);})]));
}

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});
  @override Widget build(BuildContext context)=>AppShell(title:'Log out',child:Column(children:[
    const SizedBox(height:65),CircleAvatar(radius:40,backgroundColor:const Color(0xFFDCE1FC),child:Text(MedicalStore.instance.initials)),
    const SizedBox(height:15),Text(MedicalStore.instance.patientName,
      style:const TextStyle(fontWeight:FontWeight.w800,fontSize:20)),
    const SizedBox(height:22),const Text('Log out of MediCore?',style:TextStyle(fontSize:21,fontWeight:FontWeight.bold)),
    const Padding(padding:EdgeInsets.symmetric(vertical:12),child:Text(
      'You will need to sign in again to access your medical records.',textAlign:TextAlign.center)),
    const SizedBox(height:25),ActionPill('Log out',onTap:()async{await context.read<AuthCubit>().signOut();if(context.mounted)Navigator.of(context).pushNamedAndRemoveUntil('/',(r)=>false);}),
    const SizedBox(height:10),ActionPill('Cancel',secondary:true,onTap:()=>Navigator.pop(context))]));
}
