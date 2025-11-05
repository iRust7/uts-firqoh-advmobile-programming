import 'package:flutter/material.dart';

import '../../models/user.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSubmitting = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isSubmitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    Navigator.of(context).pushReplacementNamed(
      DashboardPage.routeName,
      arguments: dummyUser,
    );
  }

  void _showForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fitur pemulihan akun akan hadir segera.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSupportBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Butuh bantuan?',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                'Hubungi tim EduLearn kapan saja. Kami siap membantu proses pembelajaranmu.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Icon(Icons.email_outlined, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Text('support@edulearn.com', style: theme.textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.chat_bubble_outline, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Text('Live chat pukul 08.00 - 21.00', style: theme.textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Mengerti'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth > 720 ? 96.0 : 24.0;
            return Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary.withOpacity(0.12),
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -120,
                  right: -60,
                  child: Container(
                    height: 260,
                    width: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          theme.colorScheme.secondary.withOpacity(0.35),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -80,
                  left: -40,
                  child: Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          theme.colorScheme.primary.withOpacity(0.28),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 32),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat Datang di EduLearn',
                              style: theme.textTheme.displayMedium?.copyWith(
                                fontSize: constraints.maxWidth > 720 ? 36 : 30,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Aplikasi pembelajaran mandiri untuk mendukung proses belajar siswa secara digital.',
                              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
                            ),
                            const SizedBox(height: 28),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                color: Colors.white.withOpacity(0.82),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 32,
                                    offset: const Offset(0, 18),
                                  ),
                                ],
                                border: Border.all(color: const Color(0xFFE4E7FB)),
                              ),
                              padding: const EdgeInsets.fromLTRB(36, 40, 36, 36),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Hero(
                                    tag: 'profile-avatar',
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            theme.colorScheme.primary,
                                            theme.colorScheme.primary.withOpacity(0.8),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: theme.colorScheme.primary.withOpacity(0.35),
                                            blurRadius: 32,
                                            offset: const Offset(0, 18),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipOval(
                                        child: Image.asset(
                                          'assets/images/edulearn_logo.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => CircleAvatar(
                                            backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
                                            child: Icon(Icons.school, color: theme.colorScheme.primary, size: 42),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 28),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Masuk untuk melanjutkan perjalanan belajarmu',
                                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _usernameController,
                                          textInputAction: TextInputAction.next,
                                          decoration: const InputDecoration(
                                            labelText: 'Username atau Email',
                                            prefixIcon: Icon(Icons.person_outline),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return 'Mohon isi username atau email.';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 18),
                                        TextFormField(
                                          controller: _passwordController,
                                          obscureText: _obscurePassword,
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                            prefixIcon: const Icon(Icons.lock_outline),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obscurePassword
                                                    ? Icons.visibility_outlined
                                                    : Icons.visibility_off_outlined,
                                              ),
                                              onPressed: () {
                                                setState(() => _obscurePassword = !_obscurePassword);
                                              },
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.trim().isEmpty) {
                                              return 'Password tidak boleh kosong.';
                                            }
                                            if (value.trim().length < 4) {
                                              return 'Gunakan minimal 4 karakter untuk simulasi.';
                                            }
                                            return null;
                                          },
                                          onFieldSubmitted: (_) => _handleLogin(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Checkbox(
                                          value: _rememberMe,
                                          onChanged: (value) => setState(() => _rememberMe = value ?? false),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Ingat saya di perangkat ini',
                                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: _showForgotPassword,
                                        child: const Text('Lupa password?'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: _isSubmitting ? null : _handleLogin,
                                      child: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 250),
                                        child: _isSubmitting
                                            ? const SizedBox(
                                                key: ValueKey('progress'),
                                                height: 22,
                                                width: 22,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2.4,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const Text(
                                                'Masuk Sekarang',
                                                key: ValueKey('label'),
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                              ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  OutlinedButton.icon(
                                    onPressed: _showSupportBottomSheet,
                                    icon: const Icon(Icons.headset_mic_outlined),
                                    label: const Text('Butuh bantuan? Hubungi kami'),
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(54),
                                      foregroundColor: theme.colorScheme.primary,
                                      side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.3)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text.rich(
                              TextSpan(
                                text: 'Dengan masuk, kamu menyetujui ',
                                style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54),
                                children: [
                                  TextSpan(
                                    text: 'Ketentuan Layanan ',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(text: 'dan '),
                                  TextSpan(
                                    text: 'Kebijakan Privasi EduLearn.',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
