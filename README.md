Sistem Pendukung Keputusan (SPK) Pemilihan Tempat Magang Terbaik
Flutter Mobile App & Laravel 12 REST API dengan Metode MOORA
Aplikasi Sistem Pendukung Keputusan (SPK) berbasis mobile ini dirancang khusus untuk membantu mahasiswa Teknik Informatika dalam menentukan tempat magang terbaik. Sistem ini mengintegrasikan taksonomi kebutuhan industri IT dengan metode MOORA (Multi-Objective Optimization on the basis of Ratio Analysis) untuk menghasilkan rekomendasi yang objektif dan presisi.

🚀 Kilasan Arsitektur Sistem
Aplikasi ini menggunakan arsitektur modern untuk memastikan pemisahan tanggung jawab (separation of concerns) dan kemudahan dalam pengembangan skala besar (scalability).

Frontend (Mobile): Flutter menggunakan pendekatan Clean Architecture atau BLoC/Provider State Management (sesuaikan dengan yang kamu pakai) untuk memastikan kode UI terpisah dari logika bisnis.

Backend (API): Laravel 12 yang dikonfigurasi sebagai REST API Stateless. Backend menangani manajemen data master (kriteria, bobot, alternatif perusahaan) dan mengeksekusi komputasi algoritma MOORA.

📊 Implementasi Metode MOORA
Metode MOORA digunakan karena efisiensinya yang sangat tinggi dalam menangani kalkulasi multi-objektif dengan kriteria yang saling bertentangan (Benefit vs Cost).

1. Kriteria & Pembobotan (Contoh Kasus IT)
Sistem mengukur alternatif berdasarkan kriteria berikut:

C1: Relevansi Teknis (Benefit) — Kesesuaian tech stack tempat magang dengan kurikulum TI.

C2: Fasilitas & Uang Saku (Benefit) — Dukungan finansial atau perangkat kerja.

C3: Portofolio & Jaringan (Benefit) — Reputasi perusahaan dan peluang kerja pasca-magang.

C4: Jarak / Aksesibilitas (Cost) — Tingkat kesulitan mobilitas mahasiswa ke lokasi.

C5: Jam Kerja (Cost) — Fleksibilitas waktu agar tidak mengganggu bimbingan/perkuliahan.