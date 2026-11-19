import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicalDocument {
  MedicalDocument(this.title,this.category,this.date,{this.status='Ready',this.shared=false,this.path});
  final String title,category,date;
  final String? path;
  String status;
  bool shared;
  Map<String,dynamic> toJson()=>{'title':title,'category':category,'date':date,'status':status,'shared':shared,'path':path};
  factory MedicalDocument.fromJson(Map<String,dynamic> m)=>MedicalDocument(m['title']??'',m['category']??'Document',m['date']??'',status:m['status']??'Ready',shared:m['shared']==true,path:m['path']);
}
class AllergyEntry {
  AllergyEntry(this.name,this.severity,this.reaction);
  final String name,severity,reaction;
  Map<String,dynamic> toJson()=>{'name':name,'severity':severity,'reaction':reaction};
  factory AllergyEntry.fromJson(Map<String,dynamic> m)=>AllergyEntry(m['name']??'',m['severity']??'Mild',m['reaction']??'');
}
class MedicalVisit {
  MedicalVisit(this.doctor,this.specialty,this.date,{this.upcoming=false});
  final String doctor,specialty,date;
  final bool upcoming;
  bool get isPast {
    if(!upcoming)return true;
    final day=DateTime.tryParse(date.length>=10?date.substring(0,10):date);
    if(day==null)return false;
    final today=DateTime.now();return day.isBefore(DateTime(today.year,today.month,today.day));
  }
  Map<String,dynamic> toJson()=>{'doctor':doctor,'specialty':specialty,'date':date,'upcoming':upcoming};
  factory MedicalVisit.fromJson(Map<String,dynamic> m)=>MedicalVisit(m['doctor']??'',m['specialty']??'',m['date']??'',upcoming:m['upcoming']==true);
}
/// An immutable revision is emitted after each mutation; widgets rebuild via
/// BlocBuilder rather than ChangeNotifier / AnimatedBuilder.
/// Snapshot of persisted patient data exposed through the BLoC stream.
class MedicalState {
  final int revision;
  final String? account;
  final String patientName, phone, birthDate;
  final double height, weight;
  final List<MedicalDocument> documents;
  final List<AllergyEntry> allergies;
  final List<String> conditions, pastHistory, medications, accessDoctors;
  final List<MedicalVisit> visits;
  const MedicalState({required this.revision, this.account,
    this.patientName = 'New Patient', this.phone = '', this.birthDate = '',
    this.height = 165, this.weight = 65,
    this.documents = const [], this.allergies = const [],
    this.conditions = const [], this.pastHistory = const [],
    this.medications = const [], this.accessDoctors = const [],
    this.visits = const []});
}

class MedicalStore extends Cubit<MedicalState> {
  MedicalStore._() : super(const MedicalState(revision: 0));
  static final MedicalStore instance=MedicalStore._();
  String patientName='New Patient',phone='',birthDate='';
  double height=165,weight=65;
  String? _account;
  final documents=<MedicalDocument>[];
  final allergies=<AllergyEntry>[];
  final conditions=<String>[];
  final pastHistory=<String>[];
  final medications=<String>[];
  final accessDoctors=<String>[];
  final visits=<MedicalVisit>[];
  Future<void> loadFor(String email,{String? name}) async {
    _account=email.trim().toLowerCase();
    final prefs=await SharedPreferences.getInstance();
    final raw=prefs.getString('medical_${_account!}');
    documents.clear();allergies.clear();conditions.clear();pastHistory.clear();medications.clear();accessDoctors.clear();visits.clear();
    patientName=name??'New Patient';phone='';birthDate='';height=165;weight=65;
    if(raw!=null){
      final m=jsonDecode(raw) as Map<String,dynamic>;
      patientName=m['name']??patientName;phone=m['phone']??'';birthDate=m['birthDate']??'';
      height=(m['height'] as num?)?.toDouble()??165;weight=(m['weight'] as num?)?.toDouble()??65;
      documents.addAll(((m['documents'] as List?)??[]).map((e)=>MedicalDocument.fromJson(Map<String,dynamic>.from(e))));
      allergies.addAll(((m['allergies'] as List?)??[]).map((e)=>AllergyEntry.fromJson(Map<String,dynamic>.from(e))));
      conditions.addAll(List<String>.from(m['conditions']??[]));pastHistory.addAll(List<String>.from(m['pastHistory']??[]));
      medications.addAll(List<String>.from(m['medications']??[]));accessDoctors.addAll(List<String>.from(m['accessDoctors']??[]));
      visits.addAll(((m['visits'] as List?)??[]).map((e)=>MedicalVisit.fromJson(Map<String,dynamic>.from(e))));
    }else{pastHistory.addAll(['Appendectomy · Surgery · 2019','Tonsillitis · Resolved · 2020']);await _persist();}
    emit(_snapshot());
  }
  MedicalState _snapshot() => MedicalState(
    revision: state.revision + 1, account: _account,
    patientName: patientName, phone: phone, birthDate: birthDate,
    height: height, weight: weight,
    documents: List.unmodifiable(documents.map((d) => MedicalDocument.fromJson(d.toJson()))),
    allergies: List.unmodifiable(allergies.map((a) => AllergyEntry.fromJson(a.toJson()))),
    conditions: List.unmodifiable(conditions),
    pastHistory: List.unmodifiable(pastHistory),
    medications: List.unmodifiable(medications),
    accessDoctors: List.unmodifiable(accessDoctors),
    visits: List.unmodifiable(visits.map((v) => MedicalVisit.fromJson(v.toJson()))));
  void _changed(){emit(_snapshot());_persist();}
  Future<void> _persist() async {
    if(_account==null)return;
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString('medical_${_account!}',jsonEncode({'name':patientName,'phone':phone,'birthDate':birthDate,'height':height,'weight':weight,'documents':documents.map((e)=>e.toJson()).toList(),'allergies':allergies.map((e)=>e.toJson()).toList(),'conditions':conditions,'pastHistory':pastHistory,'medications':medications,'accessDoctors':accessDoctors,'visits':visits.map((e)=>e.toJson()).toList()}));
  }
  void addDocument(String title,{String category='Document',String? path}){documents.insert(0,MedicalDocument(title,category,DateTime.now().toIso8601String().substring(0,10),path:path));_changed();}
  void removeDocument(MedicalDocument d){documents.remove(d);_changed();
    final file=d.path;if(file!=null&&file.split('/').last.startsWith('medicore_')){
      // Delete only local managed copies, not the user's original picked file.
      _deleteManagedFile(file);
    }
  }
  Future<void> _deleteManagedFile(String path) async {
    // Files are retained if removal fails; no unsafe deletion of source files.
    try {final f=File(path);if(await f.exists())await f.delete();}catch(_){ }
  }
  void shareDocument(MedicalDocument d){d.shared=true;_changed();}
  void addAllergy(String name,String severity,String reaction){allergies.add(AllergyEntry(name,severity,reaction));_changed();}
  void addCondition(String name){conditions.add(name);_changed();}
  void removeCondition(String name){conditions.remove(name);_changed();}
  void addPastHistory(String value){pastHistory.add(value);_changed();}
  void editPastHistory(int index,String value){pastHistory[index]=value;_changed();}
  void removePastHistory(int index){pastHistory.removeAt(index);_changed();}
  void addMedication(String name){medications.add(name);_changed();}
  void removeMedication(String name){medications.remove(name);_changed();}
  void saveProfile(String name,String number,double newHeight,double newWeight,{String? dob}){patientName=name;phone=number;height=newHeight;weight=newWeight;if(dob!=null)birthDate=dob;_changed();}
  void revokeAccess(String doctor){accessDoctors.remove(doctor);_changed();}
  void addVisit(MedicalVisit visit){visits.add(visit);_changed();}
  void removeVisit(MedicalVisit visit){visits.remove(visit);_changed();}
  String get initials {final p=patientName.trim().split(RegExp(r'\s+')).where((s)=>s.isNotEmpty).toList();return p.isEmpty?'?':p.take(2).map((s)=>s[0].toUpperCase()).join();}
}
