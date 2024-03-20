import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/common_widgets/custom_text_button.dart';
import 'package:riverpod_todo/common_widgets/primary_button.dart';
import 'package:riverpod_todo/common_widgets/responsive_scrollable_card.dart';
import 'package:riverpod_todo/constants/app_sizes.dart';
import 'package:riverpod_todo/features/auth/presentation/sigin/email_password_formtype.dart';
import 'package:riverpod_todo/features/auth/presentation/sigin/email_password_validator.dart';
import 'package:riverpod_todo/features/auth/presentation/sigin/signin_controller.dart';
import 'package:riverpod_todo/features/auth/presentation/sigin/string_validator.dart';
import 'package:riverpod_todo/localization/string_hardcoded.dart';
import 'package:riverpod_todo/utils/async_value_ui.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({
    super.key,
    this.onSignedIn,
    required this.formType,
  });
  final VoidCallback? onSignedIn;

  /// The default form type to use.
  final EmailPasswordSignInFormType formType;

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen>
    with EmailAndPasswordValidator {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  bool _submitted = false;
  late var _formType = widget.formType;

  String get email => _emailController.text;
  String get password => _passwordController.text;

  Future<void> _submit() async {
    setState(() => _submitted = true);
    // only submit the form if validation passes
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(signInControllerProvider.notifier);
      final success = await controller.submit(
        email: email,
        password: password,
        formType: _formType,
      );
      if (success && _formType == EmailPasswordSignInFormType.signIn) {
        widget.onSignedIn?.call();
      } else {
        _updateFormType();
      }
    }
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  void _updateFormType() {
    // * Toggle between register and sign in form
    setState(() => _formType = _formType.secondaryActionFormType);
    // * Clear the password field when doing so
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(signInControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(signInControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'.hardcoded),
      ),
      body: ResponsiveScrollableCard(
        child: FocusScope(
          node: _node,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  gapH8,
                  // Email field
                  TextFormField(
                    controller: _emailController,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        labelText: 'Email', hintText: 'test@test.com'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        !_submitted ? null : emailErrorText(email ?? ''),
                    onEditingComplete: () => _emailEditingComplete(),
                    inputFormatters: <TextInputFormatter>[
                      ValidatorInputFormatter(
                          editingValidator: EmailEditingRegexValidator()),
                    ],
                  ),
                  gapH8,
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    validator: (password) => !_submitted
                        ? null
                        : passwordErrorText(password ?? '', _formType),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onEditingComplete: () => _passwordEditingComplete(),
                  ),
                  gapH8,
                  PrimaryButton(
                    text: _formType.primaryButtonText,
                    isLoading: state.isLoading,
                    onPressed: state.isLoading ? null : () => _submit(),
                  ),
                  gapH8,
                  CustomTextButton(
                      text: _formType.secondaryButtonText,
                      onPressed:
                          state.isLoading ? null : () => _updateFormType())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
