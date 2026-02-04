#!/bin/bash

# Warna
G='\033[0;32m'
R='\033[0;31m'
Y='\033[0;33m'
B='\033[0;34m'
C='\033[0;36m'
NC='\033[0m'

clear
echo -e "${C}"
echo "  ____  _       _        __  _______                      "
echo " |  _ \| |_   _| |_ ___  \ \/ /_   _|__  __ _ _ __ ___    "
echo " | |_) | | | | | __/ _ \  \  /  | |/ _ \/ _\` | '_ \` _ \   "
echo " |  __/| | |_| | || (_) | /  \  | |  __/ (_| | | | | | |  "
echo " |_|   |_|\__,_|\__\___/ /_/\_\ |_|\___|\__,_|_| |_| |_|  "
echo -e "          ${Y}Modified by PlutoXTeam - 2026${NC}"
echo -e "${B}=======================================================${NC}"

if [ "$#" -ne 1 ]; then
    echo -e "${R}Penggunaan: bash plutox_analyzer.sh target.apk${NC}"
    exit 1
fi

APK_FILE=$1
OUT_DIR="workdir"
REPORT="PLUTOX_REPORT.txt"

# 1. Dekompilasi
echo -e "${G}[*] Memulai Bedah APK...${NC}"
apktool d "$APK_FILE" -o "$OUT_DIR" --force --no-res > /dev/null 2>&1

# Inisialisasi Laporan
{
    echo "======================================================="
    echo "          PLUTOX TEAM - APK ANALYSIS REPORT           "
    echo "======================================================="
    echo "TARGET FILE : $APK_FILE"
    echo "WAKTU SCAN  : $(date)"
    echo "-------------------------------------------------------"
} > "$REPORT"

# 2. Analisis Manifest
echo -e "${Y}[*] Menganalisis Struktur Manifest...${NC}"
{
    echo -e "\n[+] ANALISIS MANIFEST (Android-Permissions)"
    echo "-------------------------------------------------------"
    echo "Keterangan: Izin ini menentukan akses aplikasi ke sistem."
    echo "Perhatikan 'SYSTEM_ALERT_WINDOW' untuk Floating Login UI"
    echo "dan 'ACCESS_SUPERUSER' untuk deteksi Root."
} >> "$REPORT"
grep -Ei "permission|request|authorities|SYSTEM_ALERT_WINDOW|SUPERUSER" "$OUT_DIR/AndroidManifest.xml" >> "$REPORT"

# 3. Analisis Smali (DEX)
echo -e "${Y}[*] Memindai Kode Logic (Smali)...${NC}"
echo -e "\n[+] ANALISIS KODE LOGIC (Smali Classes)" >> "$REPORT"
echo "-------------------------------------------------------"

scan_logic() {
    local key=$1
    local label=$2
    local desc=$3
    echo -e "\n[#] KATEGORI: $label" >> "$REPORT"
    echo "    DESKRIPSI: $desc" >> "$REPORT"
    echo "    LOKASI FILE:" >> "$REPORT"
    grep -rliE "$key" "$OUT_DIR"/smali*/ >> "$REPORT" || echo "    - Tidak ditemukan -" >> "$REPORT"
}

scan_logic "isLicensed|checkLicense|google.android.vending" "LICENSE_CHECK" "Mengecek keaslian aplikasi dari Play Store."
scan_logic "isPremium|isVip|getIsPremium|purchased|subscription" "PREMIUM_VIP" "Pengecekan status akun Sultan/Berbayar."
scan_logic "Pairip|StubApp|verifySignature|killProcess" "ANTI_TAMPER_PAIRIP" "Proteksi agar aplikasi tidak bisa dimodifikasi/rebuild."
scan_logic "isRooted|Superuser|XposedBridge|LSPosed" "ROOT_LSPOSED" "Deteksi lingkungan Root dan Xposed."
scan_logic "Login|Password|Auth|KeyAuth|Register" "LOGIN_SYSTEM" "Sistem keamanan masuk (Halaman Login)."
scan_logic "isMockLocation|AllowMock" "FAKE_GPS_CHECK" "Deteksi penggunaan lokasi palsu/Fake GPS."

# 4. Analisis Native Library (.so)
echo -e "${Y}[*] Menembus Native Library (.so)...${NC}"
echo -e "\n[+] ANALISIS NATIVE LIBRARY (.so strings)" >> "$REPORT"
echo "-------------------------------------------------------"
echo "Keterangan: Pengecekan keamanan tingkat tinggi di level C++." >> "$REPORT"

find "$OUT_DIR/lib/" -name "*.so" | while read -r so_file; do
    echo -e "\n>> FILE: $so_file" >> "$REPORT"
    strings "$so_file" | grep -Ei "tamper|signature|pTrace|checkRoot|pairip" | head -n 15 >> "$REPORT"
done

echo -e "${B}=======================================================${NC}"
echo -e "${G}[+] SELESAI! Laporan: ${Y}$REPORT${NC}"
echo -e "${G}[+] Folder Kerja: ${Y}$OUT_DIR${NC}"
echo -e "${B}=======================================================${NC}"
