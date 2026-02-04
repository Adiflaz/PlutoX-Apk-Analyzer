​🌌 PlutoXAnalyzer - Ultimate APK Forensic & Bypass Tool

​PlutoXAnalyzer adalah alat analisis statis APK otomatis yang dirancang khusus oleh PlutoXTeam untuk para peneliti keamanan seluler dan antusias modifikasi Android. Tool ini melakukan dekompilasi mendalam untuk memetakan arsitektur keamanan aplikasi, mendeteksi sistem proteksi, dan mengidentifikasi titik lemah untuk keperluan bypass.

​🚀 Fitur Utama
​🛡️ Multi-Dex Forensic Scan: Memindai seluruh folder Smali (DEX 1-5+) secara rekursif untuk mencari logika tersembunyi.  
​🔑 Login UI & Auth Detection: Mengidentifikasi kelas Java/Smali yang bertanggung jawab atas sistem autentikasi dan form login.  

​💎 Premium & VIP Identifier: Melacak metode pengecekan status langganan, lisensi Google Play, dan fitur berbayar.

​🔒 Native Library Audit (.so): Melakukan ekstraksi string pada library C++ untuk mendeteksi Signature Verification, Anti-Tamper, dan proteksi Pairip.  

​📊 Manifest Intelligence: Menganalisis izin aplikasi sensitif seperti ACCESS_SUPERUSER (Root check) dan SYSTEM_ALERT_WINDOW (Overlay login).  

​🛠️ Auto-Patching (Experimental): Fitur otomatis untuk menyuntikkan nilai balik (return true) pada metode pengecekan lisensi yang terdeteksi.  

​📋 Hasil Analisis (Report)
​Tool ini menghasilkan laporan detail bernama PLUTOX_REPORT.txt yang mencakup:
​Analisis Manifest: Daftar izin dan entry point aplikasi.  

​Kategori Smali: Pengelompokan file berdasarkan fungsinya (Premium, Root, Login, dll.).  

​Audit Native: Daftar string keamanan yang ditemukan dalam file .so.  

​📦 Persyaratan Sistem
​Daftar dependensi yang diperlukan untuk menjalankan tool ini:
Paket :
1. Java JDK 17+ (Menjalankan mesin utama Apktool)
2. Apktool (Dekompilasi dan Rebuild APK)
3. Binutils (Ekstraksi string dari library Native .so)
4. Apksigner (Menandatangani APK agar bisa diinstal)

 Cara Penggunaan :
 
# Clone repo
git clone https://github.com/PlutoXTeam/PlutoXAnalyzer.git
cd PlutoXAnalyzer

# Install dependensi (Termux/Ubuntu)
chmod +x install.sh && ./install.sh

# Mulai Analisis
bash plutox_analyzer.sh target_aplikasi.apk

Disclaimer : Tool ini dibuat hanya untuk tujuan pendidikan dan penelitian keamanan. Penggunaan untuk aktivitas ilegal adalah tanggung jawab pengguna sepenuhnya. PlutoXTeam tidak bertanggung jawab atas penyalahgunaan alat ini.
