import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:share_blog/core/themes/app_pallete.dart';
import 'package:share_blog/core/widgets/app_dialog.dart';
import 'package:share_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:share_blog/features/auth/presentation/widgets/auth_field.dart';
import 'package:share_blog/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      context.read<AuthBloc>().add(
        AuthSignUp(email: email, role: "user", password: password),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() => isLoading = true);
        } else if (state is AuthSignUpSuccess) {
          setState(() => isLoading = false);
          AppDialog.showSuccess(
            context,
            title: "SUCCESS",
            desc: "Create account successful",
          );
        } else if (state is AuthSignUpFailure) {
          setState(() => isLoading = false);
          AppDialog.showError(context, desc: state.message);
          print("Failure");
        } else {
          setState(() => isLoading = false);
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 80),
                    Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AuthField(
                      hintText: "Email",
                      textController: _emailController,
                      isObscureText: false,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    AuthField(
                      hintText: "Password",
                      textController: _passwordController,
                      isObscureText: true,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    AuthField(
                      hintText: "Confirm password",
                      textController: _confirmPasswordController,
                      isObscureText: true,
                      textInputAction: TextInputAction.done,
                      submit: (value) => _submitForm(context),
                    ),
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.center,
                      child: AuthGradientButton(
                        content: "Sign up",
                        isLoading: isLoading,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _submitForm(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Sign in",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
