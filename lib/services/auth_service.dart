import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  /// Returns true if a user is currently authenticated with Firebase
  static bool get isLoggedIn {
    try {
      return FirebaseAuth.instance.currentUser != null;
    } catch (e) {
      debugPrint("AuthService.isLoggedIn check: $e");
      return false;
    }
  }

  /// Returns current authenticated Firebase user or null
  static User? get currentUser {
    try {
      return FirebaseAuth.instance.currentUser;
    } catch (e) {
      debugPrint("AuthService.currentUser check: $e");
      return null;
    }
  }

  /// Sign in with email and password
  static Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message ?? "Authentication failed";
    } catch (e) {
      return "An unexpected error occurred: $e";
    }
  }

  /// Create new user account
  static Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (error) {
      return error.message ?? "Account creation failed";
    } catch (e) {
      return "An unexpected error occurred: $e";
    }
  }

  /// Sign out the current user
  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      debugPrint("AuthService.signOut error: $e");
    }
  }
}
