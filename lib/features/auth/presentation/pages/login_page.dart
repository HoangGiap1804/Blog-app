import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:share_blog/core/routes/app_pages.dart';
import 'package:share_blog/core/themes/app_pallete.dart';
import 'package:share_blog/core/widgets/app_dialog.dart';
import 'package:share_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:share_blog/features/auth/presentation/widgets/auth_field.dart';
import 'package:share_blog/features/auth/presentation/widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "admin@gmail.com");
  final _passwordController = TextEditingController(text: "12345678");
  bool isLoading = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      context.read<AuthBloc>().add(AuthLogin(email: email, password: password));
    }
  }

  @override
  void initState() {
    super.initState();
    // Đảm bảo bỏ focus khi vào lại trang
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoading) {
          setState(() => isLoading = true);
        } else if (state is AuthLoginSuccess) {
          setState(() => isLoading = false);
          AppDialog.showSuccess(
            context,
            title: "SUCCESS",
            desc: "Login successful",
          );
          await Future.delayed(Duration(milliseconds: 1000));
          Get.toNamed(Routes.home);
        } else if (state is AuthLoginFailure) {
          setState(() => isLoading = false);
          AppDialog.showError(context, desc: state.message);
        } else {
          setState(() => isLoading = false);
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      "LOGIN",
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
                      textInputAction: TextInputAction.done,
                      submit: (value) => _submitForm(),
                    ),
                    const SizedBox(height: 100),

                    Align(
                      alignment: Alignment.center,
                      child: AuthGradientButton(
                        content: "Login",
                        isLoading: isLoading,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _submitForm();
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Get.toNamed(Routes.signup);
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: "Sign up",
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
