import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';

final frmLoginProvider =
    StateNotifierProvider.autoDispose<FrmLoginNotifier, FrmLoginState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  return FrmLoginNotifier(
    loginUserCallback: loginUserCallback,
  );
});

class FrmLoginNotifier extends StateNotifier<FrmLoginState> {
  final Function(String, String) loginUserCallback;
  FrmLoginNotifier({
    required this.loginUserCallback,
  }) : super(FrmLoginState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail]),
    );
  }

  onPasswordChange(String value) {
    final newPass = Password.dirty(value);
    state = state.copyWith(
      password: newPass,
      isValid: Formz.validate([newPass]),
    );
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    await loginUserCallback(
      state.email.value,
      state.password.value,
    );
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final pass = Password.dirty(state.password.value);

    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: pass,
        isValid: Formz.validate([email, pass]));
  }
}

class FrmLoginState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  FrmLoginState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  FrmLoginState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) =>
      FrmLoginState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  String toString() {
    return '''
  FrmLoginState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: $email
    password: $password
    ''';
  }
}
