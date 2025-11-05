# 📚 EduLearn - Aplikasi Pembelajaran Modern

<div align="center">
  <img src="assets/images/edulearn_logo.png" alt="EduLearn Logo" width="120"/>
  
  **Platform pembelajaran mandiri yang elegan dan modern untuk mendukung proses belajar siswa secara digital**
  
  ![Flutter](https://img.shields.io/badge/Flutter-3.3.0+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-3.3.0+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
  ![Material 3](https://img.shields.io/badge/Material_3-Enabled-6200EA?style=for-the-badge)
</div>

---

## ✨ Fitur Utama

### 🔐 Halaman Login
- **Design luxury clean** dengan gradient halus dan elemen modern
- Validasi form dengan feedback visual yang jelas
- Animasi transisi yang smooth ke dashboard
- Hero animation untuk avatar pengguna
- Responsive di berbagai ukuran layar

### 📊 Dashboard Interaktif
- **3 Highlight Cards** menampilkan statistik pembelajaran:
  - Progres materi terselesaikan
  - Status tugas minggu ini
  - Total jam belajar
- **Menu Grid** dengan 3 menu utama:
  - 👤 **Profil** - Lihat biodata dan catatan akademik
  - 📋 **Data** - Akses nilai, kehadiran, dan aktivitas
  - ⚙️ **Pengaturan** - Kelola preferensi aplikasi
- **Kelas Aktif** dengan progress bar animasi
- **Agenda Hari Ini** untuk jadwal kegiatan
- Banner edukatif dengan gradient menarik
- Animasi hover dan ripple effect pada semua interaksi

### 👤 Halaman Profil
- Avatar dengan gradient dan shadow effect
- Informasi lengkap pengguna (Nama, NIS, Kelas, Email, Program, Semester)
- Badge status siswa aktif
- Informasi area fokus pembelajaran
- Riwayat aktivitas terkini
- Layout responsif dengan background gradient

### 📋 Halaman Data (Baru!)
- **Tab Nilai**: Daftar nilai per mata pelajaran dengan progress bar
- **Tab Kehadiran**: Statistik dan persentase kehadiran bulanan
- **Tab Aktivitas**: Log aktivitas pembelajaran terkini
- Visualisasi data yang menarik dengan cards dan icons

### ⚙️ Halaman Pengaturan (Baru!)
- Toggle notifikasi push dan email
- Pengaturan tampilan (mode gelap, bahasa)
- Preferensi pemutaran konten
- Manajemen akun (ganti password, privasi, bantuan)
- Tombol logout dengan konfirmasi dialog

---

## 🎨 Design Philosophy

### Luxury Clean UI/UX
- **Warna lembut** dengan palette ungu, pink, dan biru pastel
- **Tipografi tegas namun elegan** menggunakan Material Design typography
- **Banyak white space** untuk kenyamanan visual
- **Card halus** dengan shadow lembut dan rounded corners
- **Icon konsisten** dari Material Icons
- **Animasi halus** pada setiap interaksi

### Responsiveness
- Mendukung berbagai ukuran layar (mobile, tablet, desktop)
- Layout adaptif dengan MediaQuery dan LayoutBuilder
- Grid yang menyesuaikan jumlah kolom berdasarkan lebar layar
- ScrollView untuk konten panjang

### Interactive Elements
- Hover effects pada desktop
- Ripple effects pada touch
- Scale animations saat interaksi
- Progress bars dengan animasi loading
- Hero transitions antar halaman
- Fade transitions yang smooth

---

## 🏗️ Struktur Project

```
lib/
├── main.dart                           # Entry point aplikasi
├── models/
│   ├── user.dart                       # Model data User
│   └── course.dart                     # Model data Course
└── ui/
    ├── pages/
    │   ├── login_page.dart             # Halaman Login
    │   ├── dashboard_page.dart         # Halaman Dashboard
    │   ├── profile_page.dart           # Halaman Profil
    │   ├── data_page.dart              # Halaman Data & Analitik (Baru!)
    │   └── settings_page.dart          # Halaman Pengaturan (Baru!)
    ├── widgets/
    │   ├── course_card.dart            # Widget Card Kelas
    │   ├── dashboard_menu_card.dart    # Widget Card Menu Dashboard
    │   ├── highlight_card.dart         # Widget Card Highlight Stats
    │   └── section_header.dart         # Widget Header Section
    └── theme/
        └── app_theme.dart              # Konfigurasi tema global
```

---

## 🚀 Cara Menjalankan

### Prerequisites
- Flutter SDK 3.3.0 atau lebih tinggi
- Dart 3.3.0 atau lebih tinggi
- Android Studio / VS Code dengan Flutter extension
- Emulator atau perangkat fisik

### Langkah-langkah

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd edulearn
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run aplikasi**
   ```bash
   flutter run
   ```

4. **Build untuk production**
   ```bash
   # Android
   flutter build apk --release
   
   # iOS
   flutter build ios --release
   
   # Web
   flutter build web --release
   ```

---

## 🎯 Teknologi & Package

### Core
- **Flutter 3.3.0+** - Framework UI
- **Material 3** - Design system
- **Cupertino Icons** - Icon set

### Features
- Hero Animations
- TweenAnimationBuilder
- AnimatedContainer
- MouseRegion untuk hover effects
- TabBar untuk multiple views
- Custom gradients & shadows

---

## 📱 Screenshots

> Aplikasi ini memiliki UI/UX modern dengan nuansa luxury clean yang tidak terlihat basic atau amatiran.

### Halaman Login
- Logo EduLearn dengan gradient container
- TextField dengan icon dan validation
- Tombol login dengan loading state

### Dashboard
- Highlight cards dengan statistik
- Menu grid dengan 3 pilihan utama
- List kelas aktif dengan progress
- Agenda harian dengan reminder cards

### Profil
- Avatar dengan gradient effect
- Informasi lengkap pengguna
- Badge dan chips untuk kategori
- Activity log yang informatif

### Data & Pengaturan
- Tab navigation untuk berbagai view
- Cards informatif dengan visualisasi
- Settings dengan switches dan tiles
- Dialog konfirmasi untuk aksi penting

---

## 👨‍💻 Development Notes

### Dummy Data
Aplikasi menggunakan data dummy yang dihardcode dalam model lokal:
- User dummy: Budi Santoso (NIS: 123456)
- 3 Course dummy dengan progress berbeda
- Statistik dan aktivitas dummy

Struktur kode sudah siap untuk integrasi dengan backend di masa depan.

### Navigation
- Menggunakan named routes via `onGenerateRoute`
- Transisi halaman dengan `PageRouteBuilder` dan `FadeTransition`
- Hero animations untuk continuity visual

### State Management
- Menggunakan StatefulWidget untuk interactive components
- AnimationController untuk animasi kompleks
- setState untuk update state lokal

---

## 🎓 Penggunaan

### Login
1. Buka aplikasi
2. Masukkan username/email dan password (validasi dummy)
3. Klik tombol "Login"
4. Akan diarahkan ke Dashboard

### Navigasi
- Klik menu **Profil** untuk melihat data pengguna
- Klik menu **Data** untuk melihat nilai, kehadiran, dan aktivitas
- Klik menu **Pengaturan** untuk konfigurasi aplikasi
- Klik icon notifikasi di AppBar (dummy)
- Klik card kelas untuk melihat detail (dummy)

### Logout
1. Masuk ke menu **Pengaturan**
2. Scroll ke bawah dan klik "Keluar"
3. Konfirmasi logout di dialog
4. Akan kembali ke halaman Login

---

## 🔮 Future Improvements

- [ ] Integrasi dengan backend API
- [ ] Authentication yang sesungguhnya
- [ ] Dark mode theme
- [ ] Multi-language support
- [ ] Offline mode dengan local database
- [ ] Push notifications
- [ ] File upload untuk tugas
- [ ] Video player untuk materi
- [ ] Chat dengan mentor
- [ ] Calendar integration
- [ ] Export data ke PDF

---

## 📄 License

This project is created for educational purposes.

---

## 👥 Contact & Support

Untuk pertanyaan atau dukungan:
- Email: support@edulearn.com
- Website: -
- GitHub: -

---

<div align="center">
  <p>Dibuat dengan ❤️ menggunakan Flutter</p>
  <p><strong>EduLearn © 2024</strong></p>
</div>
