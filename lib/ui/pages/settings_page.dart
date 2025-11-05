import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../widgets/section_header.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.user});

  static const routeName = '/settings';
  final User user;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _darkModeEnabled = false;
  bool _autoPlayVideos = true;
  String _language = 'Bahasa Indonesia';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Notifikasi',
              subtitle: 'Kelola preferensi notifikasi Anda',
            ),
            const SizedBox(height: 16),
            _buildSettingCard(
              theme,
              child: Column(
                children: [
                  _buildSwitchTile(
                    theme,
                    'Notifikasi Push',
                    'Terima pemberitahuan tentang tugas dan pengumuman',
                    Icons.notifications_active,
                    _notificationsEnabled,
                    (value) => setState(() => _notificationsEnabled = value),
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildSwitchTile(
                    theme,
                    'Email Notifikasi',
                    'Terima update melalui email',
                    Icons.email,
                    _emailNotifications,
                    (value) => setState(() => _emailNotifications = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const SectionHeader(
              title: 'Tampilan',
              subtitle: 'Sesuaikan tampilan aplikasi',
            ),
            const SizedBox(height: 16),
            _buildSettingCard(
              theme,
              child: Column(
                children: [
                  _buildSwitchTile(
                    theme,
                    'Mode Gelap',
                    'Aktifkan tema gelap untuk kenyamanan mata',
                    Icons.dark_mode,
                    _darkModeEnabled,
                    (value) {
                      setState(() => _darkModeEnabled = value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur mode gelap akan segera hadir!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildTile(
                    theme,
                    'Bahasa',
                    _language,
                    Icons.language,
                    () => _showLanguageDialog(theme),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const SectionHeader(
              title: 'Konten',
              subtitle: 'Pengaturan pemutaran konten pembelajaran',
            ),
            const SizedBox(height: 16),
            _buildSettingCard(
              theme,
              child: _buildSwitchTile(
                theme,
                'Putar Video Otomatis',
                'Video akan diputar secara otomatis',
                Icons.play_circle,
                _autoPlayVideos,
                (value) => setState(() => _autoPlayVideos = value),
              ),
            ),
            const SizedBox(height: 32),
            const SectionHeader(
              title: 'Akun',
              subtitle: 'Kelola informasi akun Anda',
            ),
            const SizedBox(height: 16),
            _buildSettingCard(
              theme,
              child: Column(
                children: [
                  _buildTile(
                    theme,
                    'Ganti Password',
                    'Perbarui kata sandi Anda',
                    Icons.lock,
                    () => _showComingSoon('Ganti Password'),
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildTile(
                    theme,
                    'Privasi & Keamanan',
                    'Kelola data dan privasi',
                    Icons.security,
                    () => _showComingSoon('Privasi & Keamanan'),
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildTile(
                    theme,
                    'Bantuan & Dukungan',
                    'Dapatkan bantuan atau kirim feedback',
                    Icons.help,
                    () => _showHelpDialog(theme),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildSettingCard(
              theme,
              child: _buildTile(
                theme,
                'Keluar',
                'Logout dari akun Anda',
                Icons.logout,
                () => _showLogoutDialog(theme),
                isDestructive: true,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    'EduLearn v1.0.0',
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.black38),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '© 2024 EduLearn. All rights reserved.',
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.black38),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(ThemeData theme, {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSwitchTile(
    ThemeData theme,
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: theme.colorScheme.primary),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildTile(
    ThemeData theme,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final color = isDestructive ? Colors.red : theme.colorScheme.primary;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.black38),
      onTap: onTap,
    );
  }

  void _showLanguageDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Bahasa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Bahasa Indonesia'),
              value: 'Bahasa Indonesia',
              groupValue: _language,
              onChanged: (value) {
                setState(() => _language = value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _language,
              onChanged: (value) {
                setState(() => _language = value!);
                Navigator.pop(context);
                _showComingSoon('English language');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bantuan & Dukungan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hubungi kami melalui:'),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.email, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                const Text('support@edulearn.com'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.phone, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                const Text('+62 812-3456-7890'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari Akun'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun EduLearn?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature akan segera hadir!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
