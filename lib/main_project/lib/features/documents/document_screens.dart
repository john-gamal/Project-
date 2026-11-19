import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:pdfx/pdfx.dart';
import '../../core/ui.dart';
import '../../data/medical_store.dart';

String _viewRoute(MedicalDocument d){final ext=path.extension(d.path??'').toLowerCase();return ['.jpg','.jpeg','.png','.webp'].contains(ext)?'/documents/image':'/documents/pdf';}
class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});
  @override State<DocumentsScreen> createState()=>_DocumentsScreenState();
}
class _DocumentsScreenState extends State<DocumentsScreen> {
  String query='', filter='All';
  @override Widget build(BuildContext context)=>AppShell(title:'Documents',
    actions:[IconButton(icon:const Icon(Icons.upload_file),onPressed:()=>go(context,'/documents/upload'))],
    bottom:const PatientTabs(selected:1),child:BlocBuilder<MedicalStore, MedicalState>(
      builder:(c,_) { final files=MedicalStore.instance.documents.where((d)=>
        d.title.toLowerCase().contains(query.toLowerCase()) && (filter=='All'||d.category==filter)).toList();
        return Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
          TextField(onChanged:(value)=>setState(()=>query=value),decoration:InputDecoration(
            prefixIcon:const Icon(Icons.search),hintText:'Search documents',filled:true,fillColor:Colors.white,
            border:OutlineInputBorder(borderSide:BorderSide.none,borderRadius:BorderRadius.circular(15)))),
          const SizedBox(height:11),SingleChildScrollView(scrollDirection:Axis.horizontal,child:Row(children:[
            for(final f in ['All','Lab report','Prescription','Imaging','Document']) Padding(
              padding:const EdgeInsets.only(right:6),child:ChoiceChip(label:Text(f),selected:filter==f,
              onSelected:(_)=>setState(()=>filter=f)))])),
          const SectionTitle('Recent documents'),
          for(final d in files) TileCard(title:d.title,subtitle:'${d.category} · ${d.date}',
            icon:d.category=='Imaging'?Icons.image_outlined:Icons.description_outlined,
            trailing:PopupMenuButton<String>(onSelected:(value){
              if(value=='view'){go(context,_viewRoute(d),arguments:d);}
              if(value=='share'){go(context,'/documents/share',arguments:d);}
              if(value=='delete'){MedicalStore.instance.removeDocument(d);}
            },itemBuilder:(context)=>[for(final item in ['view','share','delete']) PopupMenuItem(value:item,child:Text(item))]),
            onTap:()=>go(context,_viewRoute(d),arguments:d)),
          if(files.isEmpty) const Padding(padding:EdgeInsets.all(30),child:Center(child:Text('No matching documents'))),
          const SizedBox(height:18),ActionPill('Upload document',icon:Icons.add,
            onTap:()=>go(context,'/documents/upload')),
          const SizedBox(height:10),ActionPill('Shared access',secondary:true,
            onTap:()=>go(context,'/documents/access'))]);}));
}

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});
  @override State<UploadDocumentScreen> createState()=>_UploadDocumentScreenState();
}
class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  final title=TextEditingController();
  String kind='Lab report';
  String? fileName;
  bool picking=false;
  PlatformFile? selectedFile;

  Future<void> selectFile() async {
    setState(() => picking = true);
    try {
      final file = await FilePicker.pickFile(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'webp'],
      );
      if (!mounted || file == null) return;
      setState(() {
        selectedFile = file;
        fileName = file.name;
        if (title.text.trim().isEmpty) {
          title.text = path.basenameWithoutExtension(file.name);
        }
      });
    } catch (e) {
      if (mounted) message(context, 'Cannot choose file: $e');
    } finally {
      if (mounted) setState(() => picking = false);
    }
  }
  @override void dispose(){title.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>AppShell(title:'Upload document',child:Column(children:[
    GestureDetector(onTap:selectFile,child:Container(height:190,width:double.infinity,decoration:BoxDecoration(color:Colors.white,
      border:Border.all(color:const Color(0xFFC4BCF6)),borderRadius:BorderRadius.circular(18)),
      child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
        const Icon(Icons.cloud_upload_outlined,color:blue,size:45),const SizedBox(height:10),
        Text(fileName??'Tap to choose a medical file',style:const TextStyle(fontWeight:FontWeight.bold)),
        const SizedBox(height:7),const Text('PDF, JPG, PNG, WEBP',style:TextStyle(color:muted,fontSize:12))]))),
    const SizedBox(height:19),InputField('Document name',controller:title,hint:'e.g. Blood test results'),
    Align(alignment:Alignment.centerLeft,child:Text('File type',style:Theme.of(context).textTheme.titleSmall)),
    const SizedBox(height:8),Wrap(spacing:7,children:[for(final f in ['Lab report','Prescription','Imaging','Document'])
      ChoiceChip(label:Text(f),selected:kind==f,onSelected:(_)=>setState(()=>kind=f))]),
    const SizedBox(height:20),ActionPill(picking?'Choosing…':'Save document',onTap:()async{
      if(selectedFile==null){message(context,'Select a real PDF or image first');return;}
      if(title.text.trim().isEmpty){message(context,'Enter a document name');return;}
      try {
        final folder=await getApplicationDocumentsDirectory();
        final ext = path.extension(selectedFile!.name).toLowerCase();
        final dest=path.join(folder.path,'medicore_${DateTime.now().microsecondsSinceEpoch}$ext');
        final bytes = await selectedFile!.readAsBytes();
        await File(dest).writeAsBytes(bytes, flush: true);
        MedicalStore.instance.addDocument(title.text.trim(),category:kind,path:dest);
        if(context.mounted){message(context,'Saved to local app storage');Navigator.pop(context);}
      }catch(e){if(context.mounted)message(context,'File save failed: $e');}
    }),
    const SizedBox(height:12),const Text('Files are copied to local app storage. No cloud upload or encryption is configured.',textAlign:TextAlign.center,style:TextStyle(color:muted,fontSize:11))]));
}

class UploadProgressScreen extends StatefulWidget {
  const UploadProgressScreen({super.key,required this.name,required this.kind});
  final String name,kind;
  @override State<UploadProgressScreen> createState()=>_UploadProgressScreenState();
}
class _UploadProgressScreenState extends State<UploadProgressScreen> {
  bool uploaded=false;
  @override Widget build(BuildContext context)=>AppShell(title:'Upload progress',child:Column(children:[
    const SectionTitle('Uploading'),
    TileCard(title:widget.name,subtitle:widget.kind,icon:Icons.description_outlined,
      trailing:StatusTag(uploaded?'Completed':'Ready')),
    const SizedBox(height:10),LinearProgressIndicator(value:uploaded?1:0.35,minHeight:8,borderRadius:BorderRadius.circular(10)),
    const SizedBox(height:22),ActionPill(uploaded?'View documents':'Finish upload',onTap:(){
      if(uploaded){Navigator.of(context).pushNamedAndRemoveUntil('/documents',(route)=>route.isFirst);return;}
      MedicalStore.instance.addDocument(widget.name,category:widget.kind);
      setState(()=>uploaded=true);
      message(context,'Document added to the local demo list');}),
    if(!uploaded)...[const SizedBox(height:10),ActionPill('Cancel',secondary:true,onTap:()=>Navigator.pop(context))],
    const SizedBox(height:22),const Text('This is a UI demo, not a real network transfer.',style:TextStyle(color:muted,fontSize:12))]));
}

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({super.key,this.document});
  final MedicalDocument? document;
  @override Widget build(BuildContext context)=>Scaffold(backgroundColor:const Color(0xFF101526),appBar:AppBar(backgroundColor:const Color(0xFF101526),foregroundColor:Colors.white,title:Text(document?.title??'Image')),
    body:SafeArea(child:Column(children:[Expanded(child:Center(child:document?.path!=null&&File(document!.path!).existsSync()?InteractiveViewer(child:Image.file(File(document!.path!),fit:BoxFit.contain)):const Text('No real image attached to this record',style:TextStyle(color:Colors.white70)))),
      Row(mainAxisAlignment:MainAxisAlignment.center,children:[IconButton(icon:const Icon(Icons.share,color:Colors.white),onPressed:()=>go(context,'/documents/share',arguments:document)),IconButton(icon:const Icon(Icons.text_snippet,color:Colors.white),onPressed:()=>go(context,'/documents/ocr',arguments:document))])])));
}
class PdfViewerScreen extends StatefulWidget {
  const PdfViewerScreen({super.key,this.document});final MedicalDocument? document;
  @override State<PdfViewerScreen> createState()=>_PdfViewerScreenState();
}
class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PdfControllerPinch? controller;
  @override void initState(){super.initState();final f=widget.document?.path;if(f!=null&&File(f).existsSync())controller=PdfControllerPinch(document:PdfDocument.openFile(f));}
  @override void dispose(){controller?.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>AppShell(title:widget.document?.title??'PDF viewer',child:Column(children:[
    SizedBox(height:MediaQuery.sizeOf(context).height*0.62,child:controller==null?const Center(child:Text('No real PDF is attached to this record')):PdfViewPinch(controller:controller!)),
    const SizedBox(height:12),ActionPill('Share',onTap:()=>go(context,'/documents/share',arguments:widget.document))]));
}

class OcrScreen extends StatelessWidget {
  const OcrScreen({super.key,this.document});
  final MedicalDocument? document;
  @override Widget build(BuildContext context)=>AppShell(title:'Extracted text',child:Column(children:[
    const SizedBox(height:40),const Icon(Icons.text_snippet_outlined,size:60,color:blue),
    const SizedBox(height:16),const Text('OCR is not connected',style:TextStyle(fontWeight:FontWeight.bold,fontSize:19)),
    const SizedBox(height:10),const Text('The original PDF or image can be viewed locally. Text extraction requires a separate OCR integration; no sample lab values will be presented as real results.',textAlign:TextAlign.center),
    const SizedBox(height:22),ActionPill('Back to documents',onTap:()=>go(context,'/documents'))]));
}

class ShareDoctorScreen extends StatefulWidget {
  const ShareDoctorScreen({super.key,this.document});
  final MedicalDocument? document;
  @override State<ShareDoctorScreen> createState()=>_ShareDoctorScreenState();
}
class _ShareDoctorScreenState extends State<ShareDoctorScreen> {
  String doctor='Dr. Carly Walsh'; bool allowDownload=false;
  @override Widget build(BuildContext context)=>AppShell(title:'Share with doctor',child:Column(
    crossAxisAlignment:CrossAxisAlignment.start,children:[
      TileCard(title:widget.document?.title??'Selected medical document',subtitle:'Selected document',icon:Icons.description_outlined),
      const SectionTitle('Select doctor'),
      for(final d in ['Dr. Carly Walsh','Dr. Yara Wahab']) RadioListTile<String>(title:Text(d),
        subtitle:const Text('Demo directory — no real access granted'),value:d,groupValue:doctor,
        onChanged:(v)=>setState(()=>doctor=v!),activeColor:blue),
      const SectionTitle('Access duration'),
      const TileCard(title:'7 days',subtitle:'Temporary sharing permission',icon:Icons.schedule),
      SwitchListTile(title:const Text('Allow download'),subtitle:const Text('Doctor can download the document'),
        value:allowDownload,onChanged:(v)=>setState(()=>allowDownload=v)),
      const SizedBox(height:25),ActionPill('Share securely',icon:Icons.lock_outline,onTap:(){
        if(widget.document!=null) MedicalStore.instance.shareDocument(widget.document!);
        message(context,'Local sharing flag saved only. No file was sent to $doctor');
        go(context,'/documents/access');})]));
}

class SharedAccessScreen extends StatelessWidget {
  const SharedAccessScreen({super.key});
  @override Widget build(BuildContext context)=>AppShell(title:'Shared access',child:BlocBuilder<MedicalStore, MedicalState>(builder:(c,_)=>Column(children:[
      const SectionTitle('Who can access your documents'),
      for(final d in MedicalStore.instance.accessDoctors) TileCard(title:d,subtitle:'Verified doctor · Limited access',
        icon:Icons.person_outline,trailing:TextButton(onPressed:()=>showDialog(context:context,builder:(dialog)=>AlertDialog(
          title:const Text('Revoke access?'),content:Text('Remove access for $d?'),actions:[
          TextButton(onPressed:()=>Navigator.pop(dialog),child:const Text('Cancel')),
          TextButton(onPressed:(){MedicalStore.instance.revokeAccess(d);Navigator.pop(dialog);},child:const Text('Revoke'))])),
          child:const Text('Revoke'))),
      if(MedicalStore.instance.accessDoctors.isEmpty) const TileCard(title:'No shared doctors',subtitle:'Access has been revoked',icon:Icons.lock),
      const SectionTitle('Shared documents'),
      for(final f in MedicalStore.instance.documents.where((d)=>d.shared))
        TileCard(title:f.title,subtitle:'Shared access active',icon:Icons.folder_shared),
      const SizedBox(height:15),ActionPill('Manage documents',onTap:()=>go(context,'/documents'),secondary:true)])));
}

class RestrictedAccessScreen extends StatelessWidget {
  const RestrictedAccessScreen({super.key});
  @override Widget build(BuildContext context)=>AppShell(title:'Document',child:Column(children:[
    const SizedBox(height:85),const CircleAvatar(radius:44,backgroundColor:Color(0xFFFFE0E3),
      child:Icon(Icons.lock_outline,size:43,color:Colors.redAccent)),
    const SizedBox(height:18),const Text('Access restricted',style:TextStyle(fontSize:23,fontWeight:FontWeight.w800)),
    const SizedBox(height:9),const Text('This file is protected. Only approved doctors or the document owner can view it.',
      textAlign:TextAlign.center,style:TextStyle(color:muted)),
    const SizedBox(height:25),const TileCard(title:'Unauthorised request',subtitle:'Access denied for this document',icon:Icons.error_outline),
    const SizedBox(height:15),ActionPill('Back to my documents',onTap:()=>go(context,'/documents')),
    const SizedBox(height:10),ActionPill('Request access',secondary:true,
      onTap:()=>message(context,'Request access requires backend and user authentication'))]));
}
