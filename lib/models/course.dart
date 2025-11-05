import 'package:flutter/material.dart';

class Course {
  const Course({
    required this.title,
    required this.category,
    required this.mentor,
    required this.progress,
    required this.sessions,
    required this.accent,
  }) : assert(progress >= 0 && progress <= 100);

  final String title;
  final String category;
  final String mentor;
  final int progress;
  final int sessions;
  final Color accent;
}

const dummyCourses = <Course>[
  Course(
    title: 'Matematika Lanjutan',
    category: 'STEM',
    mentor: 'Bu Ratna',
    progress: 72,
    sessions: 12,
    accent: Color(0xFF8C9EFF),
  ),
  Course(
    title: 'Keterampilan Presentasi',
    category: 'Soft Skill',
    mentor: 'Kak Aulia',
    progress: 45,
    sessions: 8,
    accent: Color(0xFFFFB0C1),
  ),
  Course(
    title: 'Fisika Terapan',
    category: 'Eksperimen',
    mentor: 'Pak Hanif',
    progress: 30,
    sessions: 10,
    accent: Color(0xFF80DEEA),
  ),
];
