# SPK Pemilihan Tempat Magang Terbaik 📱

Aplikasi mobile Android berbasis Flutter untuk membantu mahasiswa Teknik Informatika dalam menentukan tempat magang terbaik menggunakan metode MOORA (Multi-Objective Optimization on the Basis of Ratio Analysis).

Backend aplikasi dibangun menggunakan Laravel 12 dan komunikasi data menggunakan REST API.

---

## 📌 Latar Belakang

Mahasiswa sering mengalami kesulitan dalam memilih tempat magang karena banyaknya alternatif yang tersedia dan setiap tempat memiliki kelebihan serta kekurangan masing-masing.

Aplikasi ini dikembangkan sebagai Sistem Pendukung Keputusan (SPK) untuk membantu proses pengambilan keputusan secara objektif berdasarkan beberapa kriteria yang telah ditentukan menggunakan metode MOORA.

---

## 🎯 Tujuan Aplikasi

- Membantu mahasiswa memilih tempat magang terbaik
- Mengurangi subjektivitas dalam pengambilan keputusan
- Mempermudah proses perankingan alternatif tempat magang
- Mengimplementasikan metode MOORA pada platform mobile

---

## 🧠 Metode yang Digunakan

### MOORA (Multi-Objective Optimization on the Basis of Ratio Analysis)

Metode MOORA digunakan untuk melakukan proses pengambilan keputusan multikriteria dengan tahapan:

1. Menentukan alternatif tempat magang
2. Menentukan kriteria penilaian
3. Normalisasi matriks keputusan
4. Perhitungan nilai optimasi
5. Perankingan alternatif

### Contoh Kriteria

| Kriteria | Tipe |
|---|---|
| Uang Saku | Benefit |
| Jam Kerja | Cost |
| Jarak dari Kampus | Cost |
| Risiko Bentrok dengan Jadwal Kuliah | Benefit |
| Relevansi Techstack| Benefit |

---

## 🛠️ Tech Stack

### Frontend (Mobile)
- Flutter
- Dart

### Backend
- Laravel 12
- REST API
- MySQL

### Networking
- HTTP / Dio *(sesuaikan dengan project kamu)*

---

## 🏗️ Arsitektur Sistem

```text
Flutter Mobile App
        ↓
    REST API
        ↓
Laravel 12 Backend
        ↓
     MySQL Database