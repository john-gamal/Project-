import 'package:flutter/material.dart';

const ink = Color(0xFF11121B);
const lavender = Color(0xFFECE5FA);
const blue = Color(0xFF536CF2);
const softBlue = Color(0xFFEDF0FF);
const muted = Color(0xFF85869A);

void go(BuildContext context, String route, {Object? arguments, bool replace = false}) {
  if (replace) {
    Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
  } else {
    Navigator.of(context).pushNamed(route, arguments: arguments);
  }
}

void message(BuildContext context, String text) =>
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.title, required this.child, this.actions,
    this.bottom, this.back = true, this.scroll = true});
  final String title;
  final Widget child;
  final List<Widget>? actions;
  final Widget? bottom;
  final bool back, scroll;
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF6F5FC),
    appBar: AppBar(
      backgroundColor: const Color(0xFFF6F5FC), elevation: 0,
      automaticallyImplyLeading: back,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: ink)),
      actions: actions,
    ),
    body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: LinearGradient(
        colors: [Color(0xFFF7F7FC), Color(0xFFE9E2F8)],
        begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: SafeArea(child: scroll
        ? SingleChildScrollView(padding: const EdgeInsets.fromLTRB(18, 12, 18, 28), child: child)
        : child),
    ), bottomNavigationBar: bottom);
}

class TileCard extends StatelessWidget {
  const TileCard({super.key, required this.title, this.subtitle, required this.icon,
    this.color = softBlue, this.trailing, this.onTap});
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color color;
  final Widget? trailing;
  final VoidCallback? onTap;
  @override Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10), color: Colors.white, elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: color,
        borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: blue, size: 21)),
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
      subtitle: subtitle == null ? null : Text(subtitle!, style: const TextStyle(fontSize: 11, color: muted)),
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 18, color: muted),
      onTap: onTap));
}

class ActionPill extends StatelessWidget {
  const ActionPill(this.label, {super.key, required this.onTap, this.secondary = false,
    this.icon, this.enabled = true});
  final String label;
  final VoidCallback onTap;
  final bool secondary, enabled;
  final IconData? icon;
  @override Widget build(BuildContext context) => SizedBox(width: double.infinity, height: 49,
    child: ElevatedButton.icon(onPressed: enabled ? onTap : null,
      icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
      style: ElevatedButton.styleFrom(elevation: 0,
        backgroundColor: secondary ? Colors.white : ink,
        foregroundColor: secondary ? ink : Colors.white,
        shape: const StadiumBorder())));
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;
  @override Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 14, bottom: 12),
    child: Row(children: [Expanded(child: Text(text,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800))), if(trailing != null) trailing!]));
}

class InputField extends StatelessWidget {
  const InputField(this.label, {super.key, this.controller, this.hint, this.lines = 1,
    this.keyboardType});
  final String label;
  final TextEditingController? controller;
  final String? hint;
  final int lines;
  final TextInputType? keyboardType;
  @override Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
      const SizedBox(height: 7), TextField(controller: controller, maxLines: lines,
        keyboardType: keyboardType,
        decoration: InputDecoration(hintText: hint,
          hintStyle: const TextStyle(color: muted, fontSize: 12),
          filled: true, fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(13))))]));
}

class StatusTag extends StatelessWidget {
  const StatusTag(this.label, {super.key, this.color = const Color(0xFF198B59)});
  final String label;
  final Color color;
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(color: color.withOpacity(.10), borderRadius: BorderRadius.circular(20)),
    child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700)));
}

class PatientTabs extends StatelessWidget {
  const PatientTabs({super.key, required this.selected});
  final int selected;
  @override Widget build(BuildContext context) {
    const tabs = <(IconData, String, String)>[
      (Icons.home_rounded,'Home','/patient/home'),
      (Icons.folder_outlined,'Records','/patient/records'),
      (Icons.calendar_month_outlined,'Visits','/patient/visits'),
      (Icons.notifications_none,'Alerts','/patient/notifications'),
      (Icons.person_outline,'Profile','/patient/profile'),
    ];
    return SafeArea(top: false, child: Container(color: Colors.white,
      child: Row(children: [for (var i = 0; i < tabs.length; i++)
        Expanded(child: InkWell(onTap: () { if (selected != i) go(context, tabs[i].$3, replace: true); },
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 11),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(tabs[i].$1, color: i == selected ? blue : muted, size: 22),
              const SizedBox(height: 3), Text(tabs[i].$2,
                style: TextStyle(fontSize: 10, color: i == selected ? blue : muted))]))))])));
  }
}
