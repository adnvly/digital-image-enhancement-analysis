function image_analysis_gui
   % Buat figure utama dengan warna latar belakang
   hFig = figure('Name', 'Analisis Citra', 'NumberTitle', 'off', ...
                 'Position', [100, 100, 1000, 600], 'MenuBar', 'none', ...
                 'Resize', 'off', 'Color', [0.9, 0.9, 0.9]);
   
   % Buat axes untuk menampilkan gambar dengan batas dan warna latar belakang
   hAxes1 = axes('Parent', hFig, 'Position', [0.05, 0.25, 0.3, 0.4], ...
                 'Color', [1, 1, 1], 'Box', 'on');
   hAxes2 = axes('Parent', hFig, 'Position', [0.4, 0.55, 0.3, 0.4], ...
                 'Color', [1, 1, 1], 'Box', 'on');
   hAxes3 = axes('Parent', hFig, 'Position', [0.4, 0.05, 0.3, 0.4], ...
                 'Color', [1, 1, 1], 'Box', 'on');
   
   % Buat tombol untuk memuat gambar dengan desain yang lebih menarik
   uicontrol('Style', 'pushbutton', 'String', 'Ambil Gambar', ...
             'Position', [50, 520, 150, 40], 'Callback', @loadImage, ...
             'BackgroundColor', [0.5, 0.7, 0.9], 'FontSize', 12);
   
   % Buat tombol untuk menerapkan kedua metode pemrosesan
   uicontrol('Style', 'pushbutton', 'String', 'Proses Gambar', ...
             'Position', [50, 470, 150, 40], 'Callback', @processImages, ...
             'BackgroundColor', [0.7, 0.9, 0.5], 'FontSize', 12);

   % Buat tombol untuk menyimpan kedua hasil citra
   uicontrol('Style', 'pushbutton', 'String', 'Simpan Citra Hasil', ...
             'Position', [50, 420, 150, 40], 'Callback', @saveBothImages, ...
             'BackgroundColor', [0.8, 0.8, 0.8], 'FontSize', 12);

   % Buat label untuk MSE dan PSNR untuk Peregangan Kontras
   uicontrol('Style', 'text', 'String', 'MSE (CS):', 'Position', [720, 460, 80, 25], ...
             'BackgroundColor', [0.9, 0.9, 0.9], 'FontSize', 10);
   hMSE_CS = uicontrol('Style', 'text', 'Position', [810, 460, 100, 25], ...
                      'String', '', 'BackgroundColor', [1, 1, 1], 'FontSize', 12);

   uicontrol('Style', 'text', 'String', 'PSNR (CS):', 'Position', [720, 430, 80, 25], ...
             'BackgroundColor', [0.9, 0.9, 0.9], 'FontSize', 10);
   hPSNR_CS = uicontrol('Style', 'text', 'Position', [810, 430, 100, 25], ...
                        'String', '', 'BackgroundColor', [1, 1, 1], 'FontSize', 12);

   % Buat label untuk MSE dan PSNR untuk Equalasi Histogram
   uicontrol('Style', 'text', 'String', 'MSE (HE):', 'Position', [720, 120, 80, 25], ...
             'BackgroundColor', [0.9, 0.9, 0.9], 'FontSize', 10);
   hMSE_HE = uicontrol('Style', 'text', 'Position', [810, 120, 100, 25], ...
                      'String', '', 'BackgroundColor', [1, 1, 1], 'FontSize', 12);

   uicontrol('Style', 'text', 'String', 'PSNR (HE):', 'Position', [720, 90, 80, 25], ...
             'BackgroundColor', [0.9, 0.9, 0.9], 'FontSize', 10);
   hPSNR_HE = uicontrol('Style', 'text', 'Position', [810, 90, 100, 25], ...
                        'String', '', 'BackgroundColor', [1, 1, 1], 'FontSize', 12);

   % Buat checkbox untuk konversi RGB ke Grayscale
   hCheckbox = uicontrol('Style', 'checkbox', 'String', 'RGB ke Greyscale', ...
                         'Position', [50, 100, 150, 30], 'BackgroundColor', [0.9, 0.9, 0.9], ...
                         'FontSize', 12);

   % Variabel untuk menyimpan gambar asli dan gambar yang diproses
   originalImage = [];
   processedImage_CS = [];
   processedImage_HE = [];
   
   % Fungsi callback untuk memuat gambar
   function loadImage(~, ~)
       [filename, pathname] = uigetfile({'*.*', 'Semua File'; ...
                                         '*.jpg;*.jpeg;*.png;*.bmp', 'File Gambar (*.jpg, *.jpeg, *.png, *.bmp)'});
       if isequal(filename, 0)
           return;
       end
       
       % Cek format file
       [~, ~, ext] = fileparts(filename);
       validFormats = {'.jpg', '.jpeg', '.png', '.bmp'};
       if ~ismember(lower(ext), validFormats)
           errordlg('Format file tidak didukung. Harap pilih file dengan format .jpg, .jpeg, .png, atau .bmp.', 'Format File Tidak Valid');
           return;
       end
       
       % Jika format valid, load gambar
       originalImage = imread(fullfile(pathname, filename));
       imshow(originalImage, 'Parent', hAxes1);
       title(hAxes1, 'Gambar Asli', 'FontSize', 14, 'FontWeight', 'bold');
   end
   
   % Fungsi untuk menerapkan pemrosesan gambar
   function processImages(~, ~)
       if isempty(originalImage)
           errordlg('Ambil gambar terlebih dahulu.');
           return;
       end

       % Tampilkan loading bar
       hWaitBar = waitbar(0, 'Memproses Gambar...');
       
       % Pemrosesan Peregangan Kontras
       waitbar(0.3, hWaitBar, 'Melakukan Contrast Stretching...');
       img = originalImage;
       if get(hCheckbox, 'Value')
           img = rgb2gray(img);
       end
       c = double(min(img(:)));
       d = double(max(img(:)));
       L = 256; % Untuk gambar grayscale 8-bit
       processedImage_CS = im2double(img);
       processedImage_CS = (processedImage_CS - c) / (d - c) * (L - 1);
       processedImage_CS = uint8(processedImage_CS * (L - 1));
       imshow(processedImage_CS, 'Parent', hAxes2);
       title(hAxes2, 'Contrast Stretching', 'FontSize', 14, 'FontWeight', 'bold');
       [mse, psnr] = calculateMSE_PSNR(img, processedImage_CS);
       set(hMSE_CS, 'String', num2str(mse));
       set(hPSNR_CS, 'String', num2str(psnr));
       
       % Pemrosesan Equalasi Histogram
       waitbar(0.7, hWaitBar, 'Melakukan Histogram Equalization...');
       processedImage_HE = histeq(img, 256);
       imshow(processedImage_HE, 'Parent', hAxes3);
       title(hAxes3, 'Histogram Equalization', 'FontSize', 14, 'FontWeight', 'bold');
       [mse, psnr] = calculateMSE_PSNR(img, processedImage_HE);
       set(hMSE_HE, 'String', num2str(mse));
       set(hPSNR_HE, 'String', num2str(psnr));
       
       % Tutup loading bar
       waitbar(1, hWaitBar, 'Selesai!');
       pause(0.5);
       close(hWaitBar);
   end
   
   % Fungsi untuk menghitung MSE dan PSNR
   function [mse, psnr] = calculateMSE_PSNR(original, processed)
       original = double(original);
       processed = double(processed);
       mse = mean((original(:) - processed(:)).^2);
       if mse == 0
           psnr = Inf;
       else
           psnr = 10 * log10(255^2 / mse);
       end
   end

   % Fungsi untuk menyimpan kedua gambar sekaligus
   function saveBothImages(~, ~)
       if isempty(processedImage_CS) || isempty(processedImage_HE)
           errordlg('Tidak ada gambar yang dihasilkan.');
           return;
       end
       folderName = uigetdir('','Pilih Folder untuk Menyimpan Gambar');
       if ischar(folderName)
           % Simpan gambar hasil Contrast Stretching
           imwrite(processedImage_CS, fullfile(folderName, 'Contrast_Stretching.png'));
           % Simpan gambar hasil Histogram Equalization
           imwrite(processedImage_HE, fullfile(folderName, 'Histogram_Equalization.png'));
           msgbox('Kedua gambar telah disimpan.', 'Sukses', 'help');
       end
   end
end
