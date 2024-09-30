function display_image_matrix_gui()
    % Buat sebuah figure untuk GUI
    fig = figure('Name', 'Display Image Matrix', 'Position', [100 100 600 400]);

    % Tambahkan label untuk judul
    uicontrol('Style', 'text', 'Position', [200 350 200 30], ...
              'String', 'Image Matrix', 'FontSize', 14, 'HorizontalAlignment', 'center');

    % Tambahkan tombol untuk memilih citra
    uicontrol('Style', 'pushbutton', 'Position', [250 300 100 30], ...
              'String', 'Load Image', 'Callback', @load_image_callback);
          
    % Fungsi callback untuk tombol Load Image
    function load_image_callback(~, ~)
        [file, path] = uigetfile({'*.jpg;*.png;*.bmp', 'Image Files (*.jpg, *.png, *.bmp)'});
        if isequal(file, 0)
            disp('User canceled file selection');
            return;
        else
            imgPath = fullfile(path, file);
            img = imread(imgPath);
        end

        % Convert to grayscale if the image is RGB
        if size(img, 3) == 3
            img = rgb2gray(img);
        end

        % Tampilkan matriks dalam bentuk tabel
        [M, N] = size(img);
        uit = uitable('Parent', fig, 'Data', num2cell(img), 'Position', [50 50 500 200]);
        uit.ColumnWidth = {30}; % Set column width for better visibility
        uit.FontName = 'Courier';
        uit.FontSize = 10;

        % Tampilkan ukuran matriks
        matrixSizeLabel = sprintf('Matrix Size: %dx%d', M, N);
        uicontrol('Style', 'text', 'Position', [250 270 150 20], ...
                  'String', matrixSizeLabel, 'FontSize', 12, 'HorizontalAlignment', 'center');
    end
end
