# 😷 Temenin Isoman
[![Pre-Release](https://github.com/sabynn/temenin-isoman-mobileapp/actions/workflows/pre-release.yml/badge.svg)](https://github.com/sabynn/temenin-isoman-mobileapp/actions/workflows/pre-release.yml)
[![Release](https://github.com/sabynn/temenin-isoman-mobileapp/actions/workflows/release.yml/badge.svg)](https://github.com/sabynn/temenin-isoman-mobileapp/actions/workflows/release.yml)

Isolasi mandiri shouldn't be lonely. Let's accompany those in need.


## 📱 APK
You can download our apk on [_releases_](https://github.com/sabynn/temenin-isoman-mobileapp/releases).

## 🔗 Integrasi dengan Web Service
Integrasi dilakukan dengan mengimplementasikan API endpoint pada backend Django dari [web](https://github.com/MarcellinoCO/temenin-isoman) yang sudah dibuat sebelumnya dengan menggunakan JsonResponse. Selanjutnya, mengimplementasikan desain frontend mobile yang menyesuaikan desain [web](https://temenin-isoman.herokuapp.com/), serta melakukan integrasi frontend-backend dengan menggunakan konsep asynchronous HTTP.

## 👨‍⚕👩‍⚕️ Brief
Pada saat seorang pasien pertama kali terkena COVID-19, pasti mereka akan kebingungan akan banyak hal terutama tentang apa yang harus selanjutnya mereka lakukan. Aplikasi yang hendak kami bangun, bertujuan untuk memberikan berbagai informasi tersebut.

Hal ini dimulai dari pendeteksian mandiri untuk pasien yang hendak mengetahui apakah ia terkena COVID-19 atau tidak, di mana pendeteksian ini dilakukan dengan pengisian form yang berisi gejala-gejala yang terjadi umumnya pada pasien penderita COVID-19. Hasil dari pengisian form ini akan menentukan tindakan pasien selanjutnya. Jika pasien terindikasi mengidap COVID-19, maka akan ditampilkan informasi-informasi kontak penting yang dapat dihubungi pasien untuk mendapatkan tindakan medis selanjutnya.

Pasien juga bisa melihat informasi ketersediaan kamar di rumah sakit tertentu jika mereka memutuskan untuk menjalani rawat inap. Selanjutnya, jika pasien memilih untuk melakukan isoman, mereka juga diberikan suatu checklist harian maupun berkala mengenai apa saja yang harus mereka lakukan.

Selain fitur khusus untuk pasien, kami juga akan memberikan informasi-informasi penting yang berhubungan dengan COVID-19 itu sendiri yang dapat berupa informasi terbaru mengenai COVID-19, serta tips dan trik untuk dapat terhindar maupun sembuh dari COVID-19.

Fitur yang kami kembangkan juga dapat menjembatani kepentingan tenaga kesehatan dalam memberikan informasi yang akurat kepada masyarakat luas mengenai gejala-gejala COVID-19 yang ada dan yang akan ada, serta obat dan penanganan yang bisa diberikan kepada pasien.

Yang terakhir, adalah fitur yang dapat diakses oleh semua orang berupa notes, yang berisikan pesan yang bertujuan untuk memberikan semangat bagi semua orang yang terkena COVID-19. Notes ini dapat ditampilkan langsung melalui app tersebut.


## 📝 Daftar Modul
- Deteksi Mandiri
- Isoman Check List
- COVID Tips and Tricks
- Emergency Contacts
- Daftar Obat dan Gejala
- Info Bed Capacity
- Happy Notes


## 👨‍👩‍👧‍👦 Persona
### User Yang Tidak Login
User yang tidak login dapat:
- Melakukan Deteksi Mandiri
- Melihat COVID Tips and Tricks
- Melihat Emergency Contacts
- Melihat Daftar Obat dan Gejala
- Melihat Info Bed Capacity
- Melihat Happy Notes

### User Yang Sudah Login
User yang sudah login dapat:
- Mengakses semua modul dari user yang tidak login
- Mengakses Isoman Check List
- Mengumpulkan Happy Notes

### Fasilitas Kesehatan
Fasilitas Kesehatan dapat:
- Mengubah Deteksi Mandiri
- Menambah Tips and Tricks
- Menambah Emergency Contacts
- Menambah Daftar Obat dan Gejala
- Menambah Info Bed Capacity


## 👨‍💻 Team Members:
- Dinda Adriani Siregar - 2006528622
- I Made Indra Mahaarta - 2006595955
- Immanuel Gerald Ronaldo Nadeak - 2006527336
- Marcellino Chris O'Vara - 2006523823
- Muhammad Agil Ghifari - 2006595835
- Sabyna Maharani - 2006595886
- Stephanus Dario - 2006527550
