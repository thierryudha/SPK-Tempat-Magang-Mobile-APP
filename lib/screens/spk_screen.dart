import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

// =====================================================================
// MODEL DATA
// =====================================================================

// Kriteria yang sudah ditentukan (nama hardcoded, nilai & bobot diinput user)
// TODO: Ganti list ini dengan nama kriteria yang sudah kamu tentukan di kelompok
class Kriteria {
  final String id;
  final String nama;
  final String keterangan; // "benefit" atau "cost" dalam MOORA
  final TextEditingController bobotController;

  Kriteria({
    required this.id,
    required this.nama,
    required this.keterangan,
  }) : bobotController = TextEditingController();

  void dispose() => bobotController.dispose();
}

// Alternatif tempat magang yang diinput user
class Alternatif {
  final String id;
  final TextEditingController namaController;
  // Map dari kriteriaId ke TextEditingController nilai
  final Map<String, TextEditingController> nilaiControllers;

  Alternatif({required this.id, required List<String> kriteriaIds})
      : namaController = TextEditingController(),
        nilaiControllers = {
          for (var kId in kriteriaIds) kId: TextEditingController()
        };

  void dispose() {
    namaController.dispose();
    nilaiControllers.values.forEach((c) => c.dispose());
  }
}

// =====================================================================
// SCREEN
// =====================================================================

class SpkScreen extends StatefulWidget {
  const SpkScreen({super.key});

  @override
  State<SpkScreen> createState() => _SpkScreenState();
}

class _SpkScreenState extends State<SpkScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Daftar kriteria yang sudah ditentukan — ganti dengan milikmu!
  // Format: nama, lalu keterangan (benefit = semakin besar semakin baik | cost = semakin kecil semakin baik)
  late final List<Kriteria> _kriteria;

  // Daftar alternatif yang diinput user — dimulai dengan 2 alternatif default
  late final List<Alternatif> _alternatifList;

  @override
  void initState() {
    super.initState();

    // TODO: Sesuaikan nama kriteria dengan yang sudah disepakati kelompok kamu
    _kriteria = [
      Kriteria(id: 'k1', nama: 'Uang Saku', keterangan: 'benefit'), 
      Kriteria(id: 'k2', nama: 'Jam Kerja', keterangan: 'cost'),
      Kriteria(id: 'k3', nama: 'Jarak dari Kampus', keterangan: 'cost'),
      Kriteria(id: 'k4', nama: 'Risiko Bentrok dengan Jadwal Kuliah', keterangan: 'benefit'),
      Kriteria(id: 'k5', nama: 'Relevansi Techstack', keterangan: 'benefit'),
    ];

    // Buat 2 alternatif awal
    _alternatifList = [
      _createAlternatif('1'),
      _createAlternatif('2'),
    ];
  }

  Alternatif _createAlternatif(String id) {
    return Alternatif(
      id: id,
      kriteriaIds: _kriteria.map((k) => k.id).toList(),
    );
  }

  @override
  void dispose() {
    for (var k in _kriteria) {
      k.dispose();
    }
    for (var a in _alternatifList) {
      a.dispose();
    }
    super.dispose();
  }

  void _tambahAlternatif() {
    setState(() {
      final newId = DateTime.now().millisecondsSinceEpoch.toString();
      _alternatifList.add(_createAlternatif(newId));
    });
  }

  void _hapusAlternatif(int index) {
    if (_alternatifList.length <= 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Minimal 2 alternatif diperlukan'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() {
      _alternatifList[index].dispose();
      _alternatifList.removeAt(index);
    });
  }

  void _handleHitung() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon lengkapi semua field terlebih dahulu'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // TODO: Kirim data ke API Laravel untuk kalkulasi MOORA
    // Data yang dikirim:
    // - List alternatif beserta nama dan nilai tiap kriteria
    // - Bobot tiap kriteria
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showHasilDialog();
    });
  }

  void _showHasilDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.check_circle_rounded,
                color: AppTheme.accent, size: 48),
            const SizedBox(height: 12),
            const Text(
              'Kalkulasi Berhasil!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Hasil ranking sudah tersimpan di Dashboard kamu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Lihat di Dashboard'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // BUILD
  // =====================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              // === HEADER ===
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Analisis SPK',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Masukkan data',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.75),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // === SECTION: BOBOT KRITERIA ===
              SliverToBoxAdapter(
                child: _buildSectionHeader(
                  icon: Icons.tune_rounded,
                  title: 'Bobot Kriteria',
                  subtitle: 'Tentukan bobot (0-1). Bobot digunakan untuk menentukan kepentingan anda terhadap suatu kriteria', 
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: _kriteria.map((k) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        k.nama,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.textPrimary,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: k.keterangan == 'benefit'
                                              ? AppTheme.accentLight
                                              : const Color(0xFFFFF3CD),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          k.keterangan.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w600,
                                            color: k.keterangan == 'benefit'
                                                ? AppTheme.accent
                                                : const Color(0xFF856404),
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: k.bobotController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9.]'))
                                    ],
                                    decoration: const InputDecoration(
                                      hintText: '0.0 – 1.0',
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                    ),
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Wajib';
                                      }
                                      final parsed = double.tryParse(val);
                                      if (parsed == null ||
                                          parsed < 0 ||
                                          parsed > 1) {
                                        return '0–1';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),

              // === SECTION: ALTERNATIF ===
              SliverToBoxAdapter(
                child: _buildSectionHeader(
                  icon: Icons.business_outlined,
                  title: 'Alternatif Tempat Magang',
                  subtitle: 'Masukkan data setiap tempat magang',
                ),
              ),

              // List alternatif
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _buildAlternatifCard(index, _alternatifList[index]),
                  childCount: _alternatifList.length,
                ),
              ),

              // Tombol tambah alternatif
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
                  child: OutlinedButton.icon(
                    onPressed: _tambahAlternatif,
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: const Text(
                      'Tambah Alternatif',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primary,
                      side: const BorderSide(color: AppTheme.primary),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              // === TOMBOL HITUNG ===
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _handleHitung,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : const Icon(Icons.calculate_rounded, size: 20),
                      label: Text(
                          _isLoading ? 'Mencari Pilihan Terbaik...' : 'Hitung'),
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

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppTheme.primary,
            ),
          ),

          const SizedBox(width: 12),

          // INI YANG PENTING
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontFamily: 'Poppins',
                  ),

                  // penting untuk mencegah overflow
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlternatifCard(int index, Alternatif alt) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card alternatif
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Alternatif',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const Spacer(),
                  // Tombol hapus alternatif
                  GestureDetector(
                    onTap: () => _hapusAlternatif(index),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppTheme.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.delete_outline_rounded,
                          color: AppTheme.error, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Input nama tempat magang
              TextFormField(
                controller: alt.namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Tempat Magang',
                  prefixIcon: Icon(Icons.business_outlined,
                      color: AppTheme.textSecondary, size: 18),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Nama tempat magang wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Input nilai untuk setiap kriteria
              ..._kriteria.map((k) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    controller: alt.nilaiControllers[k.id],
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    ],
                    decoration: InputDecoration(
                      labelText: k.nama,
                      prefixIcon: const Icon(Icons.numbers_rounded,
                          color: AppTheme.textSecondary, size: 18),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Nilai ${k.nama} wajib diisi';
                      }
                      if (double.tryParse(val) == null) {
                        return 'Harus berupa angka';
                      }
                      return null;
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
