## 🛠️ Persyaratan Sistem (Requirements)

Proyek **PlutoXAnalyzer** membutuhkan beberapa komponen agar dapat berjalan sempurna di lingkungan Linux atau Termux.

### 1. Paket Sistem (System Packages)
Tool ini berbasis Bash dan bergantung pada pustaka biner berikut:
* **[span_0](start_span)Java JDK (17+)**: Diperlukan untuk menjalankan `apktool`[span_0](end_span).
* **[span_1](start_span)Apktool**: Digunakan untuk dekompilasi dan membangun ulang (rebuild) file APK[span_1](end_span).
* **[span_2](start_span)[span_3](start_span)Binutils**: Diperlukan untuk perintah `strings` guna menganalisis library native (`.so`)[span_2](end_span)[span_3](end_span).
* **[span_4](start_span)Apksigner**: Untuk menandatangani APK hasil modifikasi agar dapat diinstal[span_4](end_span).

### 2. Pustaka Python (requirements.txt)
Jika Anda menggunakan modul tambahan berbasis Python dalam repositori ini, instal dependensinya dengan perintah:
```bash
pip install -r requirements.txt
