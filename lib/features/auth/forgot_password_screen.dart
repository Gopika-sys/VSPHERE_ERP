import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo Placeholder
                Center(
                  child: Container(
                    height: 80, width: 80,
                    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(16)),
                    child: const Icon(Icons.lock_reset_rounded, color: Colors.blue, size: 40),
                  ),
                ),
                const SizedBox(height: 16),
                Center(child: Text("Forgot Password", style: AppTextStyles.heading1)),
                const SizedBox(height: 8),
                Center(child: Text("Enter your email address to receive a reset link", style: AppTextStyles.bodySmall, textAlign: TextAlign.center)),
                const SizedBox(height: 32),

                const Text("EMAIL ADDRESS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                AppTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                  prefixIcon: Iconsax.sms,
                ),
                const SizedBox(height: 24),

                AppButton(
                  text: "Send Reset Link",
                  onPressed: () {
                    // Logic to trigger password reset API
                  },
                ),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Back to Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}