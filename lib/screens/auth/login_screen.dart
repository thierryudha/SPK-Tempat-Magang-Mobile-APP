import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../main_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController adalah objek yang "mengontrol" isi dari TextField.
  // Kita butuh ini supaya bisa ambil nilai yang diketik user nanti.
  final _nimController = TextEditingController();
  final _passwordController = TextEditingController();

  // _formKey digunakan untuk validasi form sebelum submit
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    // WAJIB: selalu dispose controller saat widget dihancurkan
    // supaya tidak ada memory leak
    _nimController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // Validasi dulu — kalau ada field kosong, form akan menampilkan error
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // TODO: Ganti blok ini dengan pemanggilan API login nanti
    // Untuk sekarang, setelah 1.5 detik langsung masuk ke MainScreen (simulasi)
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // === HEADER SECTION ===
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(28, 48, 28, 36),
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon / logo area
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.work_outline_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Masuk ke akun SPK Magang kamu',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.75),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),

              // === FORM SECTION ===
              Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),

                      // --- NIM Field ---
                      TextFormField(
                        controller: _nimController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Nomor Induk Mahasiswa',
                          prefixIcon: Icon(Icons.badge_outlined,
                              color: AppTheme.textSecondary, size: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'NIM tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // --- Password Field ---
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded,
                              color: AppTheme.textSecondary, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppTheme.textSecondary,
                              size: 20,
                            ),
                            onPressed: () => setState(
                                () => _isPasswordVisible = !_isPasswordVisible),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          if (value.length < 6) {
                            return 'Password minimal 6 karakter';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 28),

                      // --- Login Button ---
                      SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Masuk'),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // --- Link ke Register ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Belum punya akun? ',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const RegisterScreen()),
                            ),
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
