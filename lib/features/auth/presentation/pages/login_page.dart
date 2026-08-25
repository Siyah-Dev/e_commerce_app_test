import 'package:e_commerce_test/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_controller.dart';
import '../controllers/auth_state.dart';
import '../widgets/auth_header.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = await ref
        .read(authControllerProvider.notifier)
        .login(
          userName: _usernameController.text.trim(),
          password: _passwordController.text,
        );

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen<AuthState>(
      authControllerProvider,
      (previous, next) {
        if (next.status == AuthStatus.failure &&
            next.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
            ),
          );
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AuthHeader(
              title: 'Sign In',
              subtitle: 'Welcome Back!',
            ),

            Expanded(
              child: LoginForm(
                formKey: _formKey,
                emailController: _usernameController,
                passwordController: _passwordController,
                obscurePassword: _obscurePassword,
                isLoading: authState.status == AuthStatus.loading,
                onTogglePassword: _togglePasswordVisibility,
                onLogin: _login,
              ),
            ),
          ],
        ),
      ),
    );
  }
}