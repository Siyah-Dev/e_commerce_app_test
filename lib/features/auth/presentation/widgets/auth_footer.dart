import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.onSignUp,
  });

  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't Have An Account? ",
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: onSignUp,
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF1685C4),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}