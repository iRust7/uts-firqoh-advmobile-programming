import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../widgets/section_header.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key, required this.user});

  static const routeName = '/data';
  final User user;

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data & Analitik'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: Colors.black54,
          indicatorColor: theme.colorScheme.primary,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Nilai'),
            Tab(text: 'Kehadiran'),
            Tab(text: 'Aktivitas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGradesTab(theme),
          _buildAttendanceTab(theme),
          _buildActivityTab(theme),
        ],
      ),
    );
  }

  Widget _buildGradesTab(ThemeData theme) {
    final grades = [
      _GradeData('Matematika Lanjutan', 92, 'A', Colors.blue),
      _GradeData('Fisika Terapan', 88, 'A-', Colors.purple),
      _GradeData('Keterampilan Presentasi', 95, 'A+', Colors.pink),
      _GradeData('Biologi Molekuler', 85, 'B+', Colors.green),
      _GradeData('Bahasa Inggris', 90, 'A', Colors.orange),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'Rata-rata Nilai',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '90.0',
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.trending_up, color: Colors.green, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '+5% dari semester lalu',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Nilai per Mata Pelajaran',
            subtitle: 'Semester 5 - Tahun Ajaran 2024/2025',
          ),
          const SizedBox(height: 16),
          ...grades.map((grade) => _buildGradeCard(grade, theme)),
        ],
      ),
    );
  }

  Widget _buildGradeCard(_GradeData grade, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: grade.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.subject, color: grade.color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  grade.subject,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: grade.score / 100,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(grade.color),
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${grade.score}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: grade.color,
                ),
              ),
              Text(
                grade.grade,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceTab(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Hadir',
                      '45',
                      Icons.check_circle,
                      Colors.green,
                      theme,
                    ),
                  ),
                  Container(width: 1, height: 60, color: Colors.grey[300]),
                  Expanded(
                    child: _buildStatCard(
                      'Izin',
                      '2',
                      Icons.info,
                      Colors.orange,
                      theme,
                    ),
                  ),
                  Container(width: 1, height: 60, color: Colors.grey[300]),
                  Expanded(
                    child: _buildStatCard(
                      'Alfa',
                      '0',
                      Icons.cancel,
                      Colors.red,
                      theme,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Persentase Kehadiran',
            subtitle: 'Bulan ini',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: 0.96,
                              strokeWidth: 12,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '96%',
                                style: theme.textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              Text(
                                'Kehadiran',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Performa kehadiran yang sangat baik! 🎉',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color, ThemeData theme) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildActivityTab(ThemeData theme) {
    final activities = [
      _ActivityLog('Menyelesaikan Kuis Biologi', '2 jam yang lalu', Icons.quiz, Colors.purple),
      _ActivityLog('Mengupload Tugas Matematika', '5 jam yang lalu', Icons.upload_file, Colors.blue),
      _ActivityLog('Bergabung Diskusi Kelompok', 'Kemarin, 14:30', Icons.group, Colors.green),
      _ActivityLog('Menonton Video Pembelajaran', 'Kemarin, 09:15', Icons.play_circle, Colors.orange),
      _ActivityLog('Mengikuti Ujian Tengah Semester', '2 hari yang lalu', Icons.assignment, Colors.red),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Aktivitas Terkini',
            subtitle: 'Riwayat kegiatan pembelajaran Anda',
          ),
          const SizedBox(height: 16),
          ...activities.map((activity) => _buildActivityCard(activity, theme)),
        ],
      ),
    );
  }

  Widget _buildActivityCard(_ActivityLog activity, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: activity.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(activity.icon, color: activity.color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.time,
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GradeData {
  final String subject;
  final int score;
  final String grade;
  final Color color;
  _GradeData(this.subject, this.score, this.grade, this.color);
}

class _ActivityLog {
  final String title;
  final String time;
  final IconData icon;
  final Color color;
  _ActivityLog(this.title, this.time, this.icon, this.color);
}
