import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Data dummy — akan diganti dengan data user dari API nanti
  static const String _namaUser = 'Thierry Yudha Diantha';
  static const String _nimUser = '2407411045';
  static const String _emailUser = 'thierry.yudha.diantha.tik24@stu.pnj.ac.id';
  static const String _prodiUser = 'D4 Teknik Informatika';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // === HEADER PROFIL ===
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    // Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white.withOpacity(0.4), width: 2),
                      ),
                      child: const Icon(Icons.person_rounded,
                          color: Colors.white, size: 40),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      _namaUser,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _nimUser,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.75),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppTheme.accent.withOpacity(0.4)),
                      ),
                      child: const Text(
                        _prodiUser,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // === DETAIL INFO ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        _buildInfoTile(
                          icon: Icons.person_outline_rounded,
                          label: 'Nama Lengkap',
                          value: _namaUser,
                        ),
                        _buildDivider(),
                        _buildInfoTile(
                          icon: Icons.badge_outlined,
                          label: 'NIM',
                          value: _nimUser,
                        ),
                        _buildDivider(),
                        _buildInfoTile(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: _emailUser,
                        ),
                        _buildDivider(),
                        _buildInfoTile(
                          icon: Icons.school_outlined,
                          label: 'Program Studi',
                          value: _prodiUser,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // === MENU PENGATURAN ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        _buildMenuTile(
                          icon: Icons.edit_outlined,
                          label: 'Edit Profil',
                          onTap: () {
                            // TODO: Navigate ke halaman edit profil
                          },
                        ),
                        _buildDivider(),
                        _buildMenuTile(
                          icon: Icons.lock_outline_rounded,
                          label: 'Ubah Password',
                          onTap: () {
                            // TODO: Navigate ke halaman ubah password
                          },
                        ),
                        _buildDivider(),
                        _buildMenuTile(
                          icon: Icons.info_outline_rounded,
                          label: 'Tentang Aplikasi',
                          onTap: () {
                            showAboutDialog(
                              context: context,
                              applicationName: 'SPK Magang',
                              applicationVersion: '1.0.0',
                              applicationLegalese:
                                  'Tugas Akhir Semester — Sistem Pendukung Keputusan\nMetode MOORA',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // === TOMBOL LOGOUT ===
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () => _confirmLogout(context),
                    icon: const Icon(Icons.logout_rounded,
                        color: AppTheme.error, size: 18),
                    label: const Text(
                      'Keluar',
                      style: TextStyle(
                        color: AppTheme.error,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.error),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppTheme.primary, size: 18),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: AppTheme.textSecondary,
          fontFamily: 'Poppins',
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimary,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppTheme.primary, size: 18),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimary,
          fontFamily: 'Poppins',
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded,
          color: AppTheme.textSecondary, size: 20),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: 60,
      color: Color(0xFFE8ECF4),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Konfirmasi Logout',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Apakah kamu yakin ingin keluar dari aplikasi?',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal',
                style: TextStyle(fontFamily: 'Poppins', color: AppTheme.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              // TODO: Hapus token dari SharedPreferences saat logout
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Keluar',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppTheme.error,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
