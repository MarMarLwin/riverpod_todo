import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/features/auth/data/fake_auth_repository.dart';

class AccountController extends StateNotifier<AsyncValue<void>> {
  AccountController({required this.authRepository})
      : super(const AsyncValue.data(null));
  final FakeAuthRepository authRepository;

  Future<void> signOut() async {
    try {
      state = const AsyncValue<void>.loading();
      await authRepository.signOut();
      //if success set state to data
      state = const AsyncValue<void>.data(null);
    } catch (e, st) {
      state = AsyncValue<void>.error(e, st);
    }
  }
}

final accountControllerProvider =
    StateNotifierProvider<AccountController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return AccountController(authRepository: authRepository);
});
