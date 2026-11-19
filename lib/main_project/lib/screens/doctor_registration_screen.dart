import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../data/auth_cubit.dart';
import 'package:file_picker/file_picker.dart';

// 3 خطوات: 1) Account  2) Profile  3) Verification
class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key, required int startStep});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  int step = 1;

  // Step 1
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  bool agreed = false;

  // Step 2
  String? specialty;
  final licenseController = TextEditingController();

  // Step 3
  bool uploaded = false; // TODO: بدّليها بـ file_picker واحفظي اسم الملف

  String? error;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    licenseController.dispose();
    super.dispose();
  }

  void goBack() {
    if (step > 1) {
      setState(() {
        step--;
        error = null;
      });
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> next() async {
    String? msg;

    if (step == 1) {
      final email = emailController.text.trim();
      final pass = passwordController.text;
      final digits = phoneController.text.replaceAll(RegExp(r'\D'), '');

      if (nameController.text.trim().isEmpty) {
        msg = 'Please enter your full name.';
      } else if (!email.contains('@') || !email.contains('.')) {
        msg = 'Please enter a valid work email.';
      } else if (digits.length < 11 || digits.length > 13) {
        msg = 'Please enter a valid mobile number.';
      } else if (pass.length < 8 ||
          !RegExp(r'\d').hasMatch(pass) ||
          !RegExp(r'[A-Z]').hasMatch(pass)) {
        msg = 'Password needs 8+ characters, a number and an uppercase letter.';
      } else if (pass != confirmController.text) {
        msg = 'Passwords do not match.';
      } else if (!agreed) {
        msg = 'Please agree to the Terms & Privacy Policy.';
      }
    } else if (step == 2) {
      if (specialty == null) {
        msg = 'Please select your specialty.';
      } else if (licenseController.text.trim().isEmpty) {
        msg = 'Please enter your medical license number.';
      }
    } else {
      if (!uploaded) msg = 'Please upload your license & ID.';
    }

    setState(() => error = msg);
    if (msg != null) return;

    if (step < 3) {
      setState(() => step++);
    } else {
      final failure = await context.read<AuthCubit>().register(
          email: emailController.text.trim(),
          password: passwordController.text,
          name: nameController.text.trim(),
          role: 'doctor',
          specialty: specialty,
          license: licenseController.text.trim());
      if (!mounted) return;
      if (failure != null) {
        setState(() => error = failure);
        return;
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/doctor/home', (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const grey = Color(0xFF8A8A99);
    const stepNames = ['Account', 'Profile', 'Verification'];

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Top bar
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: goBack,
                        customBorder: const CircleBorder(),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back, size: 16),
                        ),
                      ),
                    ),
                    const Text(
                      'Doctor registration',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Progress
                Row(
                  children: List.generate(
                    3,
                    (i) => Expanded(
                      child: Container(
                        height: 3,
                        margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
                        decoration: BoxDecoration(
                          color: step >= i + 1
                              ? const Color(0xFF07070F)
                              : Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Step $step of 3 · ${stepNames[step - 1]}',
                  style: const TextStyle(fontSize: 10, color: grey),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (step > 1) ...[
                          const Text(
                            'Apply as a Doctor',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0B0B14),
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],

                        // ---------- Step 1: Account ----------
                        if (step == 1) ...[
                          const Text('Full name',
                              style: TextStyle(fontSize: 10, color: grey)),
                          const SizedBox(height: 6),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: nameController,
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Dr. Sara Hassan',
                                hintStyle: TextStyle(fontSize: 12, color: grey),
                                prefixIcon: Icon(Icons.person_outline,
                                    size: 16, color: Color(0xFF55556A)),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 13),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text('Work email',
                              style: TextStyle(fontSize: 10, color: grey)),
                          const SizedBox(height: 6),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'dr.sara@clinic.com',
                                hintStyle: TextStyle(fontSize: 12, color: grey),
                                prefixIcon: Icon(Icons.mail_outline,
                                    size: 16, color: Color(0xFF55556A)),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 13),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text('Mobile number',
                              style: TextStyle(fontSize: 10, color: grey)),
                          const SizedBox(height: 6),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '+20 100 000 0000',
                                hintStyle: TextStyle(fontSize: 12, color: grey),
                                prefixIcon: Icon(Icons.phone_outlined,
                                    size: 16, color: Color(0xFF55556A)),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 13),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text('Password',
                              style: TextStyle(fontSize: 10, color: grey)),
                          const SizedBox(height: 6),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'At least 8 characters',
                                hintStyle: TextStyle(fontSize: 12, color: grey),
                                prefixIcon: Icon(Icons.lock_outline,
                                    size: 16, color: Color(0xFF55556A)),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 13),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text('Confirm password',
                              style: TextStyle(fontSize: 10, color: grey)),
                          const SizedBox(height: 6),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: confirmController,
                              obscureText: true,
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Repeat password',
                                hintStyle: TextStyle(fontSize: 12, color: grey),
                                prefixIcon: Icon(Icons.lock_outline,
                                    size: 16, color: Color(0xFF55556A)),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 13),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Terms
                          GestureDetector(
                            onTap: () => setState(() => agreed = !agreed),
                            child: Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    color: agreed
                                        ? const Color(0xFF07070F)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: agreed
                                          ? const Color(0xFF07070F)
                                          : const Color(0xFFB5B5C3),
                                    ),
                                  ),
                                  child: agreed
                                      ? const Icon(Icons.check,
                                          size: 12, color: Colors.white)
                                      : null,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'I agree to the Terms & Privacy Policy',
                                  style: TextStyle(
                                      fontSize: 10, color: Color(0xFF55556A)),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // ---------- Step 2: Profile ----------
                        if (step == 2) ...[
                          const Text('Specialty',
                              style: TextStyle(fontSize: 10, color: grey)),
                          const SizedBox(height: 6),
                          Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: specialty,
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down,
                                    size: 18),
                                style: const TextStyle(
                                    fontSize: 12, color: Color(0xFF0B0B14)),
                                hint: const Row(
                                  children: [
                                    Icon(Icons.medical_services_outlined,
                                        size: 16, color: Color(0xFF55556A)),
                                    SizedBox(width: 10),
                                    Text('Select specialty',
                                        style: TextStyle(
                                            fontSize: 12, color: grey)),
                                  ],
                                ),
                                items: const [
                                  'Allergy & Immunology',
                                  'Cardiology',
                                  'Dermatology',
                                  'Internal Medicine',
                                  'Neurology',
                                  'Pediatrics',
                                ]
                                    .map((s) => DropdownMenuItem(
                                        value: s, child: Text(s)))
                                    .toList(),
                                onChanged: (v) => setState(() => specialty = v),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text('Medical license number',
                              style: TextStyle(fontSize: 10, color: grey)),
                          const SizedBox(height: 6),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: licenseController,
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'EG-000000',
                                hintStyle: TextStyle(fontSize: 12, color: grey),
                                prefixIcon: Icon(Icons.badge_outlined,
                                    size: 16, color: Color(0xFF55556A)),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 13),
                              ),
                            ),
                          ),
                        ],
                        if (step == 3) ...[
                          const Text.rich(
                            TextSpan(
                              style: TextStyle(fontSize: 10, color: grey),
                              children: [
                                TextSpan(text: 'License & ID  '),
                                TextSpan(
                                  text: '* Required',
                                  style: TextStyle(
                                      color: Color(0xFFD62839),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          InkWell(
                            onTap: () async {
                              final file = await FilePicker.pickFile(
                                type: FileType.custom,
                                allowedExtensions: [
                                  'pdf',
                                  'jpg',
                                  'jpeg',
                                  'png'
                                ],
                              );

                              if (file == null) return;

                              final fileName = file.name;
                              if (file != null && mounted)
                                setState(() => uploaded = true);
                            },
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F3FF),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: error != null && !uploaded
                                      ? const Color(0xFFD62839)
                                      : const Color(0xFFCDBDF5),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: uploaded
                                          ? const Color(0xFFD9F2E6)
                                          : const Color(0xFFEDE5FB),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      uploaded
                                          ? Icons.check
                                          : Icons.upload_outlined,
                                      size: 18,
                                      color: uploaded
                                          ? const Color(0xFF16A34A)
                                          : const Color(0xFF7C3AED),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          uploaded
                                              ? 'license_and_id.pdf'
                                              : 'Upload license & ID',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 11),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          uploaded
                                              ? 'Tap to remove'
                                              : 'PDF or JPG, up to 10 MB',
                                          style: const TextStyle(
                                              fontSize: 9, color: grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),

                if (error != null) ...[
                  Text(
                    error!,
                    style:
                        const TextStyle(fontSize: 10, color: Color(0xFFD62839)),
                  ),
                  const SizedBox(height: 8),
                ],

                // Continue / Submit button
                InkWell(
                  onTap: next,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.only(left: 22, right: 8),
                    decoration: BoxDecoration(
                      color: step == 3
                          ? const Color(0xFF1B2554)
                          : const Color(0xFF07070F),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            step == 3 ? 'Submit for verification' : 'Continue',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward,
                              size: 15, color: Color(0xFF0B0B14)),
                        ),
                      ],
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
