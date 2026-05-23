import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// Model sederhana untuk data history ranking — nanti diganti dengan class Model yang proper
// saat sudah connect ke API
class HistoryItem {
  final String id;
  final String tanggal;
  final String tempatTerbaik;
  final double skor;
  final int jumlahAlternatif;

  const HistoryItem({
    required this.id,
    required this.tanggal,
    required this.tempatTerbaik,
    required this.skor,
    required this.jumlahAlternatif,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Dummy data — akan diganti dengan data dari API nanti
  final List<HistoryItem> _historyList = const [
    HistoryItem(
      id: '1',
      tanggal: '18 Mei 2025',
      tempatTerbaik: 'PT. Telkom Indonesia',
      skor: 0.872,
      jumlahAlternatif: 5,
    ),
    HistoryItem(
      id: '2',
      tanggal: '10 Mei 2025',
      tempatTerbaik: 'CV. Kreasi Digital',
      skor: 0.791,
      jumlahAlternatif: 3,
    ),
    HistoryItem(
      id: '3',
      tanggal: '2 April 2025',
      tempatTerbaik: 'Startup Nusantara Tech',
      skor: 0.654,
      jumlahAlternatif: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // === APP BAR ===
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo, Mahasiswa 👋',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.75),
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 2),
                            // TODO: Ganti "Mahasiswa" dengan nama user dari API
                            const Text(
                              'Dashboard SPK Magang',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.notifications_outlined,
                              color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // === SUMMARY CARD ===
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.2), width: 1),
                      ),
                      child: Row(
                        children: [
                          _buildStatItem(
                              '${_historyList.length}', 'Total Analisis'),
                          Container(
                            width: 1,
                            height: 36,
                            color: Colors.white.withOpacity(0.2),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          _buildStatItem(
                            _historyList.isNotEmpty
                                ? _historyList.first.tempatTerbaik
                                    .split(' ')
                                    .take(2)
                                    .join(' ')
                                : '-',
                            'Rekomendasi Terakhir',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // === HISTORY LIST ===
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Riwayat Analisis',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      '${_historyList.length} data',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            _historyList.isEmpty
                ? SliverToBoxAdapter(child: _buildEmptyState())
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          _buildHistoryCard(_historyList[index]),
                      childCount: _historyList.length,
                    ),
                  ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.7),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(HistoryItem item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      child: Card(
        child: InkWell(
          onTap: () {
            // TODO: Navigate ke halaman detail hasil ranking
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.tanggal,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.accentLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${item.jumlahAlternatif} alternatif',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.accent,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.emoji_events_outlined,
                          color: AppTheme.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rekomendasi Terbaik',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.textSecondary,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Text(
                            item.tempatTerbaik,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.skor.toStringAsFixed(3),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primary,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const Text(
                          'Skor MOORA',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppTheme.textSecondary,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Icon(Icons.history_rounded, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text(
            'Belum ada riwayat analisis',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Mulai analisis SPK di tab SPK',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
