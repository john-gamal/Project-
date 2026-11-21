import 'package:flutter/material.dart';

import 'screens/consultation/audio_call_screen.dart';
import 'screens/consultation/book_visit_screen.dart';
import 'screens/consultation/booking_confirmed_screen.dart';
import 'screens/consultation/choose_doctor_screen.dart';
import 'screens/consultation/connection_lost_screen.dart';
import 'screens/consultation/doctor_profile_screen.dart';
import 'screens/consultation/secure_room_screen.dart';
import 'screens/consultation/video_call_screen.dart';
import 'screens/consultation/visit_details_screen.dart';
import 'screens/consultation/visit_ended_screen.dart';
import 'screens/consultation/visit_report_screen.dart';
import 'screens/consultation/waiting_room_screen.dart';
import 'screens/doctor/doctor_home_screen.dart';
import 'screens/doctor/follow_up_confirmed_screen.dart';
import 'screens/doctor/follow_up_screen.dart';
import 'screens/doctor/new_prescription_screen.dart';
import 'screens/doctor/patient_file_screen.dart';
import 'screens/doctor/review_sign_screen.dart';
import 'screens/doctor/saved_record_screen.dart';
import 'screens/doctor/visit_summary_screen.dart';
import 'screens/flow_index_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const index = '/';

  // Consultation Flow (patient)
  static const chooseDoctor = '/consultation/choose-doctor';
  static const doctorProfile = '/consultation/doctor-profile';
  static const bookVisit = '/consultation/book-visit';
  static const bookingConfirmed = '/consultation/booking-confirmed';
  static const visitDetails = '/consultation/visit-details';
  static const secureRoom = '/consultation/secure-room';
  static const waitingRoom = '/consultation/waiting-room';
  static const videoCall = '/consultation/video-call';
  static const audioCall = '/consultation/audio-call';
  static const connectionLost = '/consultation/connection-lost';
  static const connectionFailed = '/consultation/connection-failed';
  static const visitEnded = '/consultation/visit-ended';
  static const visitReport = '/consultation/visit-report';

  // Doctor Flow
  static const doctorHome = '/doctor/home';
  static const patientFile = '/doctor/patient-file';
  static const videoCallDoctor = '/doctor/video-call';
  static const visitSummary = '/doctor/visit-summary';
  static const newPrescription = '/doctor/new-prescription';
  static const reviewSign = '/doctor/review-sign';
  static const savedRecord = '/doctor/saved-record';
  static const followUp = '/doctor/follow-up';
  static const followUpConfirmed = '/doctor/follow-up-confirmed';

  static final Map<String, WidgetBuilder> table = {
    index: (_) => const FlowIndexScreen(),
    chooseDoctor: (_) => const ChooseDoctorScreen(),
    doctorProfile: (_) => const DoctorProfileScreen(),
    bookVisit: (_) => const BookVisitScreen(),
    bookingConfirmed: (_) => const BookingConfirmedScreen(),
    visitDetails: (_) => const VisitDetailsScreen(),
    secureRoom: (_) => const SecureRoomScreen(),
    waitingRoom: (_) => const WaitingRoomScreen(),
    videoCall: (_) => const VideoCallScreen(),
    audioCall: (_) => const AudioCallScreen(),
    connectionLost: (_) => const ConnectionLostScreen(),
    connectionFailed: (_) => const ConnectionLostScreen(failed: true),
    visitEnded: (_) => const VisitEndedScreen(),
    visitReport: (_) => const VisitReportScreen(),
    doctorHome: (_) => const DoctorHomeScreen(),
    patientFile: (_) => const PatientFileScreen(),
    videoCallDoctor: (_) => const VideoCallScreen(
          remoteName: 'Nadeen Ayman',
          remoteInitials: 'NA',
          localInitials: 'SH',
          isDoctor: true,
        ),
    visitSummary: (_) => const VisitSummaryScreen(),
    newPrescription: (_) => const NewPrescriptionScreen(),
    reviewSign: (_) => const ReviewSignScreen(),
    savedRecord: (_) => const SavedRecordScreen(),
    followUp: (_) => const FollowUpScreen(),
    followUpConfirmed: (_) => const FollowUpConfirmedScreen(),
  };
}
