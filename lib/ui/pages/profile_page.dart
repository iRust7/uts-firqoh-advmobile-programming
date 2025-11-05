import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../widgets/section_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  static const routeName = '/profile';

  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final focusAreas = ['Informatika', 'UI/UX', 'Soft Skill', 'Riset Sains'];
    const activities = <_Activity>[
      _Activity(
        title: 'Mengunggah tugas Fisika Terapan',
        timestamp: 'Hari ini • 09.20',
        icon: Icons.cloud_upload_outlined,
      ),
      _Activity(
        title: 'Menyelesaikan modul Matematika Lanjutan',
        timestamp: 'Kemarin • 19.45',
        icon: Icons.check_circle_outline,
      ),
      _Activity(
        title: 'Mengikuti diskusi Soft Skill',
        timestamp: '2 hari lalu • 15.00',
        icon: Icons.groups_2_outlined,
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = constraints.maxWidth > 720 ? 96.0 : 24.0;
          return Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withOpacity(0.1),
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -80,
                right: -60,
                child: Container(
                  height: 220,
                  width: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        theme.colorScheme.secondary.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 24, horizontalPadding, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Hero(
                          tag: 'profile-avatar',
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  theme.colorScheme.primary,
                                  theme.colorScheme.primary.withOpacity(0.65),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withOpacity(0.3),
                                  blurRadius: 28,
                                  offset: const Offset(0, 18),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(6),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/profile_placeholder.png',
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Center(
                                  child: Text(
                                    user.name.substring(0, 1),
                                    style: theme.textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                      fontSize: 56,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Chip(
                          label: const Text('Siswa Aktif'),
                          backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
                          labelStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        user.name,
                        style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${user.className} • ${user.program}',
                        style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                      ),
                      const SizedBox(height: 28),
                      const SectionHeader(
                        title: 'Informasi Utama',
                        subtitle: 'Detail pribadi dan identitas akun EduLearn',
                      ),
                      const SizedBox(height: 18),
                      _buildInfoCard(
                        context: context,
                        title: 'Biodata Singkat',
                        children: [
                          _ProfileTile(label: 'NIS', value: user.nis),
                          _ProfileTile(label: 'Kelas', value: user.className),
                          _ProfileTile(label: 'Email', value: user.email),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const SectionHeader(
                        title: 'Detail Akademik',
                        subtitle: 'Pantau progres studi secara menyeluruh',
                      ),
                      const SizedBox(height: 18),
                      _buildInfoCard(
                        context: context,
                        title: 'Akademik',
                        children: [
                          Row(
                            children: [
                              Expanded(child: _ProfileTile(label: 'Prodi', value: user.program)),
                              const SizedBox(width: 18),
                              Expanded(child: _ProfileTile(label: 'Semester', value: 'Semester ${user.semester}')),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const SectionHeader(
                        title: 'Fokus Saat Ini',
                        subtitle: 'Area pengembangan yang sedang dipelajari',
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: focusAreas
                            .map(
                              (area) => Chip(
                                label: Text(area),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                backgroundColor: theme.colorScheme.primary.withOpacity(0.08),
                                labelStyle: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                      const SectionHeader(
                        title: 'Kontak & Dukungan',
                        subtitle: 'Tetap terhubung dengan mentor dan tim EduLearn',
                      ),
                      const SizedBox(height: 12),
                      _buildContactCard(theme),
                      const SizedBox(height: 24),
                      const SectionHeader(
                        title: 'Aktivitas Terakhir',
                        subtitle: 'Riwayat pembelajaran terbaru',
                      ),
                      const SizedBox(height: 12),
                      _buildActivityTimeline(activities, theme),
                      const SizedBox(height: 36),
                      Center(
                        child: SizedBox(
                          width: 260,
                          child: FilledButton.icon(
                            icon: const Icon(Icons.arrow_back_rounded),
                            label: const Text('Kembali ke Dashboard'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18),
            ...children,
          ],
        ),
      ),
    );
  }
}

Widget _buildContactCard(ThemeData theme) {
  return Card(
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.support_agent_outlined, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mentor Utama', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text('Bu Ratna • 08.00 - 17.00 WIB', style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Icon(Icons.email_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text('ratna@edulearn.com', style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.phone_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text('+62 812-3456-7890', style: theme.textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildActivityTimeline(List<_Activity> activities, ThemeData theme) {
  return Card(
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          for (final activity in activities) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(activity.icon, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(activity.title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(activity.timestamp, style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
            if (activity != activities.last)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Divider(height: 1, color: Colors.black.withOpacity(0.05)),
              ),
          ],
        ],
      ),
    ),
  );
}

class _Activity {
  const _Activity({required this.title, required this.timestamp, required this.icon});

  final String title;
  final String timestamp;
  final IconData icon;
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.black45,
            letterSpacing: 0.4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Text(
            value,
            style: theme.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
