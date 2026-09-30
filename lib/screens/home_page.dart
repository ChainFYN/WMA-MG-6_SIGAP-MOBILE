import 'package:flutter/material.dart';
import '../services/report_service.dart';
import 'form_laporan_page.dart';
import 'riwayat_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: _getBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _getBody() {
    switch (_selectedIndex) {
      case 0:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingSection(),
              const SizedBox(height: 20),
              _buildHeroBanner(),
              const SizedBox(height: 24),
              _buildStatusHeader(),
              const SizedBox(height: 16),
              _buildStatusGrid(),
              if (ReportService.reports.isNotEmpty) ...[
                const SizedBox(height: 24),
                _buildRecentReports(),
              ],
            ],
          ),
        );
      case 2:
        return const RiwayatPage();
      case 3:
        return const Center(child: Text('Halaman Profil'));
      default:
        return const SizedBox.shrink();
    }
  }

  // === Bagian Navigasi Bawah ===
  Widget _buildBottomNavigationBar() {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
          children: [
            _buildNavItem(0, Icons.home_rounded, 'Beranda'),
            _buildNavItem(1, Icons.camera_alt_rounded, 'Kamera'),
            _buildNavItem(2, Icons.history_rounded, 'Riwayat'),
            // _buildNavItem(3, Icons.person_outline_rounded, 'Profil'),
          ],
        ),
      ),
    );
  }

  // Widget tunggal untuk semua menu agar seragam
  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isActive = _selectedIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (index == 1) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormLaporanPage(),
            ),
          );
          if (mounted) {
            setState(() {
              _selectedIndex = 0;
            });
          }
          return;
        }
        setState(() {
          _selectedIndex = index; 
        });
      },
      child: SizedBox(
        width: 75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              padding: EdgeInsets.all(isActive ? 12.0 : 8.0),
              decoration: BoxDecoration(
                color: isActive ? Colors.blue[800] : Colors.transparent, 
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 26,
                color: isActive ? Colors.white : Colors.grey[400], 
              ),
            ),
            const SizedBox(height: 6),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                fontSize: isActive ? 12 : 11,
                color: isActive ? Colors.blue[800] : Colors.grey[500],
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                fontFamily: 'Arial',
              ),
              child: Text(label),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Icon(Icons.location_on, color: Colors.blue[800]),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SIGAP', style: TextStyle(fontSize: 12, color: Colors.blue[900], fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black54),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: _showAccountPopup,
            child: const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 16,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        )
      ],
    );
  }

  void _showAccountPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Garis kecil di atas sebagai penanda bisa diseret
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.blue[800],
                  child: const Icon(Icons.person, color: Colors.white, size: 36),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Afan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                const Text(
                  'warga@sigap.id',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(sheetContext); // tutup popup
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Keluar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red[700],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGreetingSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Pagi, Afan!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 14, color: Colors.blue[800]),
                  const SizedBox(width: 4),
                  Text(
                    'Desa Sumbersari, Kec. Kaliwates',
                    style: TextStyle(fontSize: 12, color: Colors.blue[900], fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.verified_user_outlined, color: Colors.blue[800]),
        )
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          const Text(
            'Menemukan Jalan Rusak di Sekitarmu?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2),
          ),
          const SizedBox(height: 8),
          Text(
            'Laporkan langsung ke dinas terkait hanya dalam 3 langkah mudah.',
            style: TextStyle(fontSize: 13, color: Colors.blue[100]),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FormLaporanPage(),
                    ),
                  );
                  if (context.mounted) {
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.warning_amber_rounded, size: 18),
                label: const Text('Buat Laporan Baru'),
              ),
              const SizedBox(width: 12),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Status Laporan Saya',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
        ),
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              Text('Lihat Semua', style: TextStyle(fontSize: 13, color: Colors.blue[800], fontWeight: FontWeight.bold)),
              Icon(Icons.arrow_forward, size: 16, color: Colors.blue[800]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusGrid() {
    final totalDiajukan = ReportService.totalSubmitted;
    final totalMenunggu = ReportService.totalWaiting;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildStatusCard('Total Diajukan', '$totalDiajukan', 'Laporan', Icons.folder_outlined, Colors.blue[50]!, Colors.blue[800]!),
        _buildStatusCard('Menunggu', '$totalMenunggu', 'Verifikasi', Icons.hourglass_empty, Colors.orange[50]!, Colors.orange[800]!),
        _buildStatusCard('Proses PUPR', '0', 'Lokasi', Icons.engineering_outlined, Colors.blue[50]!, Colors.blue[800]!),
        _buildStatusCard('Tuntas Diperbaiki', '0', 'Jalan', Icons.check_circle_outline, Colors.teal[50]!, Colors.teal[800]!),
      ],
    );
  }

  Widget _buildStatusCard(String title, String count, String subtitle, IconData icon, Color iconBgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500)),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
                child: Icon(icon, size: 16, color: iconColor),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(count, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(width: 4),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.black54)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRecentReports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Laporan Baru Dikirim',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Text(
                '${ReportService.reports.length} Baru',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green.shade800),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...ReportService.reports.map((report) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        report.kategori,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Menunggu Verifikasi',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E88E5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: Colors.black54),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${report.jalanPatokan}, ${report.desa}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (report.deskripsi.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    report.deskripsi,
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${report.photos.length} Bukti Foto Terunggah',
                      style: const TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: report.tingkatBahaya == 'Bahaya Tinggi'
                            ? const Color(0xFFFEF2F2)
                            : const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        report.tingkatBahaya,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: report.tingkatBahaya == 'Bahaya Tinggi'
                              ? const Color(0xFFDC2626)
                              : const Color(0xFFD97706),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}