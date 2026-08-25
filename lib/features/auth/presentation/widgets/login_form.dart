import 'package:e_commerce_test/core/utils/validators.dart';
import 'package:e_commerce_test/core/widgets/app_primary_button.dart';
import 'package:e_commerce_test/core/widgets/app_social_button.dart';
import 'package:e_commerce_test/core/widgets/app_text_field.dart';
import 'package:e_commerce_test/features/auth/presentation/widgets/auth_footer.dart';
import 'package:e_commerce_test/features/auth/presentation/widgets/forgot_password_button.dart';
import 'package:e_commerce_test/features/auth/presentation/widgets/or_divider.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, 
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onLogin,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: emailController,
              label: 'Email Address',
              hint: 'Enter Your Email Address',
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
            ),

            const SizedBox(height: 18),

            AppTextField(
              controller: passwordController,
              label: 'Password',
              hint: 'Enter Your Password',
              obscureText: obscurePassword,
              validator: Validators.password,
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                ),
                onPressed: onTogglePassword,
              ),
            ),

            const Align(
              alignment: Alignment.centerRight,
              child: ForgotPasswordButton(),
            ),

            const SizedBox(height: 8),

            AppPrimaryButton(
              text: 'Sign In',
              onPressed: onLogin,
              isLoading: isLoading,
            ),

            const SizedBox(height: 24),

            const OrDivider(),

            const SizedBox(height: 20),

            AppSocialButton(
              icon: Icons.g_mobiledata,
              text: 'Google',
              onPressed: () {},
            ),

            const SizedBox(height: 12),

            AppSocialButton(
              icon: Icons.facebook,
              text: 'Facebook',
              onPressed: () {},
            ),

            const SizedBox(height: 22),

            AuthFooter(
              onSignUp: () {},
            ),
          ],
        ),
      ),
    );
  }
}