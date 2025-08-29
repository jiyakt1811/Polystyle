import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? photoURL;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.photoURL,
  });
}

class AuthService {
  User? _currentUser;
  User? get currentUser => _currentUser;

  // Simulated user database
  static final Map<String, Map<String, String>> _users = {
    'test@example.com': {
      'password': 'password123',
      'name': 'Test User',
      'id': '1',
    },
  };

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final userData = _users[email];
    if (userData != null && userData['password'] == password) {
      _currentUser = User(
        id: userData['id']!,
        name: userData['name']!,
        email: email,
      );
      debugPrint('User signed in: ${_currentUser!.name}');
      return _currentUser;
    } else {
      throw 'Invalid email or password';
    }
  }

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(String email, String password, String name) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_users.containsKey(email)) {
      throw 'An account already exists with this email address.';
    }
    
    final userId = DateTime.now().millisecondsSinceEpoch.toString();
    _users[email] = {
      'password': password,
      'name': name,
      'id': userId,
    };
    
    _currentUser = User(
      id: userId,
      name: name,
      email: email,
    );
    
    debugPrint('User signed up: ${_currentUser!.name}');
    return _currentUser;
  }

  // Sign in with Google (simulated)
  Future<User?> signInWithGoogle() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Simulate Google sign-in
    _currentUser = User(
      id: 'google_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Google User',
      email: 'google@example.com',
      photoURL: 'https://via.placeholder.com/150',
    );
    
    debugPrint('User signed in with Google: ${_currentUser!.name}');
    return _currentUser;
  }

  // Sign out
  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    _currentUser = null;
    debugPrint('User signed out');
  }

  // Check if user is authenticated
  bool get isAuthenticated => _currentUser != null;
} 