import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';
import 'spk_screen.dart';
import 'profile_screen.dart';

// MainScreen adalah "shell" / wadah yang menampung 3 halaman utama.
// Dia yang mengatur BottomNavigationBar dan menentukan halaman mana yang tampil.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // _currentIndex menyimpan halaman mana yang sedang aktif
  // 0 = Dashboard, 1 = SPK, 2 = Profil
  int _currentIndex = 0;

  // Daftar halaman yang bisa dipilih. Dibuat sebagai list final supaya
  // tidak di-rebuild ulang setiap kali state berubah (lebih efisien)
  final List<Widget> _pages = const [
    DashboardScreen(),
    SpkScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack: menampilkan satu widget berdasarkan index,
      // tapi semua widget tetap "hidup" di memory sehingga state tidak hilang
      // saat user pindah tab. Ini lebih baik daripada langsung _pages[_currentIndex].
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppTheme.cardShadow,
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              activeIcon: Icon(Icons.assignment_rounded),
              label: 'SPK',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
