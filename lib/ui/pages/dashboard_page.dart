import 'package:flutter/material.dart';

import '../../models/course.dart';
import '../../models/user.dart';
import '../widgets/course_card.dart';
import '../widgets/dashboard_menu_card.dart';
import '../widgets/highlight_card.dart';
import '../widgets/section_header.dart';
import 'data_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.user});

  static const routeName = '/dashboard';

  final User user;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Reminder> _reminders;

  static const _highlights = <_HighlightData>[
    _HighlightData(
      title: 'Materi terselesaikan',
      value: '8/12 Modul',
      icon: Icons.star_outline_rounded,
      gradient: [Color(0xFF8C9EFF), Color(0xFF6C63FF)],
    ),
    _HighlightData(
      title: 'Tugas minggu ini',
      value: '2 tugas selesai',
      icon: Icons.check_circle_outline,
      gradient: [Color(0xFFFFB6C1), Color(0xFFFF9A9E)],
    ),
    _HighlightData(
      title: 'Jam belajar',
      value: '5 jam',
      icon: Icons.schedule_outlined,
      gradient: [Color(0xFF80DEEA), Color(0xFF64B5F6)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _reminders = const [
      _Reminder(
        title: 'Evaluasi Biologi',
        time: '08.30 - 09.30',
        category: 'Kuis',
        icon: Icons.bubble_chart_outlined,
      ),
      _Reminder(
        title: 'Diskusi Soft Skill',
        time: '11.00 - 11.45',
        category: 'Kolaborasi',
        icon: Icons.forum_outlined,
      ),
      _Reminder(
        title: 'Review Matematika',
        time: '19.30 - 20.15',
        category: 'Belajar Mandiri',
        icon: Icons.menu_book_outlined,
      ),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature masih dummy untuk saat ini.'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EduLearn'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () => _showComingSoon('Notifikasi'),
            tooltip: 'Notifikasi',
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth > 600 ? 48 : 24,
                vertical: 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${widget.user.name.split(' ').first}',
                    style: theme.textTheme.displayMedium?.copyWith(fontSize: 30),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Selamat datang kembali 👋',
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black54),
                  ),
                  const SizedBox(height: 28),
                  _buildBanner(theme),
                  const SizedBox(height: 28),
                  _buildHighlights(theme),
                  const SizedBox(height: 36),
                  const SectionHeader(
                    title: 'Menu Utama',
                    subtitle: 'Akses cepat ke fitur utama EduLearn',
                  ),
                  const SizedBox(height: 18),
                  _buildMenuGrid(theme, constraints),
                  const SizedBox(height: 36),
                  SectionHeader(
                    title: 'Kelas Aktif',
                    subtitle: 'Pantau progres kelas yang sedang kamu jalani',
                    actionLabel: 'Lihat semua',
                    onActionTap: () => _showComingSoon('Daftar kelas'),
                  ),
                  const SizedBox(height: 18),
                  ...List.generate(dummyCourses.length, (index) {
                    final course = dummyCourses[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _buildAnimatedMenu(
                        index: index + 3,
                        child: CourseCard(
                          course: course,
                          onTap: () => _showComingSoon(course.title),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  SectionHeader(
                    title: 'Agenda Hari Ini',
                    subtitle: 'Jangan lewatkan kegiatan pentingmu',
                    actionLabel: 'Atur pengingat',
                    onActionTap: () => _showComingSoon('Pengingat belajar'),
                  ),
                  const SizedBox(height: 18),
                  ..._reminders.map(
                    (reminder) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildReminderCard(reminder, theme),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHighlights(ThemeData theme) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _highlights.length,
        itemBuilder: (context, index) {
          final item = _highlights[index];
          return _buildAnimatedMenu(
            index: index,
            child: HighlightCard(
              title: item.title,
              value: item.value,
              icon: item.icon,
              gradient: item.gradient,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuGrid(ThemeData theme, BoxConstraints constraints) {
    final isWide = constraints.maxWidth > 900;
    final isTablet = constraints.maxWidth > 600;
    final crossAxisCount = isWide ? 4 : isTablet ? 3 : 2;
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: crossAxisCount >= 3 ? 1.05 : 0.95,
      children: [
        _buildAnimatedMenu(
          index: 1,
          child: DashboardMenuCard(
            icon: Icons.person_outline,
            label: 'Profil',
            caption: 'Lihat biodata dan catatan akademik lengkap.',
            gradient: [theme.colorScheme.primary, theme.colorScheme.primary.withOpacity(0.7)],
            onTap: () {
              Navigator.of(context).pushNamed(
                ProfilePage.routeName,
                arguments: widget.user,
              );
            },
          ),
        ),
        _buildAnimatedMenu(
          index: 2,
          child: DashboardMenuCard(
            icon: Icons.list_alt,
            label: 'Data',
            caption: 'Kumpulan materi & arsip nilai yang siap diunduh.',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DataPage(user: widget.user),
                ),
              );
            },
          ),
        ),
        _buildAnimatedMenu(
          index: 3,
          child: DashboardMenuCard(
            icon: Icons.settings_suggest_outlined,
            label: 'Pengaturan',
            caption: 'Sesuaikan preferensi tampilan dan notifikasi.',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsPage(user: widget.user),
                ),
              );
            },
          ),
        ),
        if (isWide || isTablet)
          _buildAnimatedMenu(
            index: 4,
            child: DashboardMenuCard(
              icon: Icons.calendar_month_outlined,
              label: 'Kalender',
              caption: 'Rencanakan jadwal belajar mingguan kamu.',
              onTap: () => _showComingSoon('Kalender belajar'),
            ),
          ),
      ],
    );
  }

  Widget _buildBanner(ThemeData theme) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.9),
            theme.colorScheme.primary.withOpacity(0.6),
            const Color(0xFFA5F3FC),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.25),
            blurRadius: 26,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belajar Tanpa Batas',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Jelajahi materi terbaru dan kelola tugas harianmu dengan mudah.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Container(
            height: double.infinity,
            width: 110,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                'assets/images/education_icon.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.auto_graph_rounded,
                  color: Colors.white,
                  size: 56,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedMenu({required int index, required Widget child}) {
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0.1 * index, 0.5 + 0.1 * index, curve: Curves.easeOutBack),
    );

    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.85, end: 1).animate(animation),
        child: child,
      ),
    );
  }

  Widget _buildReminderCard(_Reminder reminder, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(reminder.icon, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.title,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  reminder.time,
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
          Chip(
            label: Text(reminder.category),
            backgroundColor: theme.colorScheme.primary.withOpacity(0.08),
            labelStyle: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightData {
  const _HighlightData({
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
  });

  final String title;
  final String value;
  final IconData icon;
  final List<Color> gradient;
}

class _Reminder {
  const _Reminder({
    required this.title,
    required this.time,
    required this.category,
    required this.icon,
  });

  final String title;
  final String time;
  final String category;
  final IconData icon;
}
