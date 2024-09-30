Aplikasi ini merupakan GUI (Graphical User Interface) untuk melakukan analisis citra digital menggunakan dua metode pemrosesan: Contrast Stretching dan Histogram Equalization.
Tampilan figure dalam aplikasi ini sepenuhnya dibuat menggunakan kode program MATLAB, sehingga memberikan fleksibilitas dan konsistensi dalam desain antarmuka.
Dengan aplikasi ini, pengguna dapat memuat gambar, menerapkan metode pemrosesan citra, dan menyimpan hasilnya dengan mudah.

FITUR UTAMA :

- Ambil Gambar: Memungkinkan pengguna untuk memuat gambar dari file lokal dengan format yang didukung (JPG, JPEG, PNG, BMP).
- Proses Gambar: Mengimplementasikan dua metode pemrosesan citra:
- Contrast Stretching: Meningkatkan kontras gambar dengan meregangkan rentang nilai pixel.
- Histogram Equalization: Mendistribusikan nilai pixel untuk meningkatkan kontras secara keseluruhan.
- Simpan Citra Hasil: Menyimpan gambar hasil pemrosesan ke format PNG.
- Menampilkan MSE dan PSNR: Menyediakan informasi tentang kualitas gambar hasil pemrosesan menggunakan Mean Squared Error (MSE) dan Peak Signal-to-Noise Ratio (PSNR).
- Konversi RGB ke Grayscale: Opsional checkbox untuk mengonversi gambar RGB menjadi grayscale sebelum pemrosesan.

CARA MENGGUNAKAN :

1. Jalankan aplikasi dengan menjalankan fungsi image_analysis_gui.
2. Klik tombol Ambil Gambar untuk memilih gambar dari file Anda.
3. Centang opsi RGB ke Greyscale jika ingin mengonversi gambar sebelum pemrosesan.
4. Klik tombol Proses Gambar untuk menerapkan metode pemrosesan.
5. Setelah pemrosesan selesai, klik Simpan Citra Hasil untuk menyimpan hasil gambar.

PRASYARAT :

- MATLAB (R2015a atau yang lebih baru).
- Toolboxes: Image Processing Toolbox.

INSTALASI :

Clone repository ini ke lokal Anda dan jalankan file image_analysis_gui.m di MATLAB.

