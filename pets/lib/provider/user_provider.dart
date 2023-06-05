import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final userProvider = StateProvider<GoogleSignInAccount?>((ref) => null);
final tokenProvider = Provider((ref) => 'AfXaHy0-1h1ELUsRZUafMsOFPBXPb9HF');
