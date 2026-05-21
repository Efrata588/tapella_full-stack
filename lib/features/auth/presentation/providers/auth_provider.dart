import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/exceptions/api_exception.dart';
import '../../../../core/models/user_model.dart';
import '../../data/auth_repository.dart';
import '../../../profile/data/profile_repository.dart';

class AuthState {
  final UserModel? user;
  final bool isSubmitting;
  final String? error;
  final bool initialized;

  const AuthState({
    this.user,
    this.isSubmitting = false,
    this.error,
    this.initialized = false,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    UserModel? user,
    bool? isSubmitting,
    String? error,
    bool? initialized,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: clearError ? null : (error ?? this.error),
      initialized: initialized ?? this.initialized,
    );
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    Future.microtask(_restore);
    return const AuthState();
  }

  Future<void> _restore() async {
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .restoreSession()
          .timeout(const Duration(seconds: 8));
      state = AuthState(user: user, initialized: true);
    } catch (_) {
      state = const AuthState(initialized: true);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
    required bool isProvider,
  }) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      final user = await ref.read(authRepositoryProvider).login(
            email: email,
            password: password,
            isProvider: isProvider,
          );
      state = AuthState(user: user, initialized: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        error: _message(e),
        initialized: true,
      );
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String displayName,
    required bool isProvider,
    String? phone,
    String? profession,
  }) async {
    state = state.copyWith(isSubmitting: true, clearError: true);
    try {
      final user = await ref.read(authRepositoryProvider).register(
            email: email,
            password: password,
            displayName: displayName,
            isProvider: isProvider,
            phone: phone,
            profession: profession,
          );
      state = AuthState(user: user, initialized: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        error: _message(e),
        initialized: true,
      );
      return false;
    }
  }

  String _message(Object e) {
    if (e is AppException) return e.message;
    return 'Cannot reach server. Is it running on port 3000?';
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AuthState(initialized: true);
  }

  void setUser(UserModel user) {
    state = AuthState(user: user, initialized: true);
  }

  Future<void> refreshProfile() async {
    try {
      final user = await ref.read(profileRepositoryProvider).fetchProfile();
      state = AuthState(user: user, initialized: true);
    } catch (_) {}
  }

  Future<bool> deleteAccount() async {
    try {
      await ref.read(profileRepositoryProvider).deleteAccount();
      await ref.read(authRepositoryProvider).logout();
      state = const AuthState(initialized: true);
      return true;
    } catch (e) {
      state = state.copyWith(error: _message(e));
      return false;
    }
  }
}
