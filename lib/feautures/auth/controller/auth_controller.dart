import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddit_fullstack/core/utils.dart';
import 'package:reddit_fullstack/feautures/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_fullstack/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);
final authStateChangeProvider = StreamProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.authStateChange;
  },
);

final getUserProvider = StreamProvider.family((ref, String uid)  {
    final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false); //Loading

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInwithGoogle();
    state = false;
    user.fold(
        (l) => showSnackBar(context, l.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel),
            );
  }
   Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
   }
   void logOut()async{
    _authRepository.logOut();
   }
}
