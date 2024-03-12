import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/features/auth/data/fake_auth_repository.dart';
import 'package:riverpod_todo/features/auth/presentation/sigin/email_password_formtype.dart';

class SignInController extends StateNotifier<AsyncValue<void>> {
  SignInController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  final FakeAuthRepository authRepository;
  Future<void> signIn(String email, String password) async {
    try {
      state = const AsyncValue<void>.loading();
      await authRepository.signInWithEmailAndPassword(email, password);
      //if success set state to data
      state = const AsyncValue<void>.data(null);
      debugPrint('singin success');
    } catch (e, st) {
      state = AsyncValue<void>.error(e, st);
    }
  }

  Future<bool> submit(
      {required String email,
      required String password,
      required EmailPasswordSignInFormType formType}) async {
    state = const AsyncValue.loading();
    state =
        await AsyncValue.guard(() => _authenticate(email, password, formType));
    return state.hasError == false;
  }

  Future<void> _authenticate(
      String email, String password, EmailPasswordSignInFormType formType) {
    switch (formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return authRepository.createUserWithEmailAndPassword(email, password);
    }
  }
}

final signInControllerProvider =
    StateNotifierProvider<SignInController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInController(authRepository: authRepository);
});
