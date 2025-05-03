import 'package:shared_preferences/shared_preferences.dart';

/// A utility class to manage app session data like onboarding status and authentication
class SessionManager {
  // Keys for SharedPreferences
  static const String _keyOnboardingCompleted = 'onboarding_completed';
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserName = 'user_name';
  static const String _keyUserRole = 'user_role';
  static const String _keyUserId = 'user_id';

  /// Saves the onboarding completion status
  static Future<bool> setOnboardingCompleted(bool completed) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_keyOnboardingCompleted, completed);
  }

  /// Checks if onboarding has been completed
  static Future<bool> isOnboardingCompleted() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // If the key doesn't exist (first app launch), return false
    return prefs.getBool(_keyOnboardingCompleted) ?? false;
  }

  /// Resets the onboarding status (for testing purposes)
  static Future<bool> resetOnboardingStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_keyOnboardingCompleted);
  }

  /// Saves the user login state and basic information
  static Future<bool> saveUserLoginState({
    required String userId,
    required String email,
    String? name,
    String role = 'doctor',
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save all user data in a transaction
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyUserEmail, email);
    if (name != null) await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserRole, role);

    // Finally, set the logged in flag
    return prefs.setBool(_keyIsLoggedIn, true);
  }

  /// Checks if user is logged in
  static Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Gets the current user's ID
  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  /// Gets the current user's email
  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserEmail);
  }

  /// Gets the current user's name
  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  /// Gets the current user's role
  static Future<String?> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserRole);
  }

  /// Clears user login state (logout)
  static Future<bool> clearUserLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove all user-related data
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserRole);

    // Finally, remove the logged in flag
    return prefs.setBool(_keyIsLoggedIn, false);
  }

  /// Resets all session data (for testing or complete logout)
  static Future<bool> resetAllSessionData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
