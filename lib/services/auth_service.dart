import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // =========================
  // SIGN UP
  // =========================

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      // Create Firebase Authentication account
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final User? user = userCredential.user;

      if (user == null) {
        return 'Unable to create account.';
      }

      // Update Firebase user's display name
      await user.updateDisplayName(name.trim());

      // Save user information in Firestore
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'name': name.trim(),
        'email': email.trim(),
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthErrorMessage(e.code);
    } catch (e) {
      return 'Something went wrong. Please try again.';
    }
  }

  // =========================
  // LOGIN
  // =========================

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthErrorMessage(e.code);
    } catch (e) {
      return 'Something went wrong. Please try again.';
    }
  }

  // =========================
  // GET USER ROLE
  // =========================

  Future<String?> getUserRole() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        return null;
      }

      final DocumentSnapshot<Map<String, dynamic>>
          document = await _firestore
              .collection('users')
              .doc(user.uid)
              .get();

      if (!document.exists) {
        return null;
      }

      final Map<String, dynamic>? data =
          document.data();

      if (data == null) {
        return null;
      }

      return data['role'] as String?;
    } catch (e) {
      return null;
    }
  }

  // =========================
  // GET CURRENT USER
  // =========================

  User? get currentUser => _auth.currentUser;

  // =========================
  // GET CURRENT USER DATA
  // =========================

  Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        return null;
      }

      final DocumentSnapshot<Map<String, dynamic>>
          document = await _firestore
              .collection('users')
              .doc(user.uid)
              .get();

      if (!document.exists) {
        return null;
      }

      return document.data();
    } catch (e) {
      return null;
    }
  }

  // =========================
  // LOGOUT
  // =========================

  Future<void> logout() async {
    await _auth.signOut();
  }

  // =========================
  // FORGOT PASSWORD
  // =========================

  Future<String?> resetPassword(
    String email,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email.trim(),
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthErrorMessage(e.code);
    } catch (e) {
      return 'Something went wrong. Please try again.';
    }
  }

  // =========================
  // FIREBASE ERROR MESSAGES
  // =========================

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'An account already exists with this email.';

      case 'invalid-email':
        return 'Please enter a valid email address.';

      case 'weak-password':
        return 'Password should be at least 6 characters.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'invalid-verification-code':
        return 'Invalid verification code.';

      case 'invalid-verification-id':
        return 'Invalid verification request.';

      case 'requires-recent-login':
        return 'Please login again and try this action.';

      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
