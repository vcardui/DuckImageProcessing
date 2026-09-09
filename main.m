% +-----------------------------------------------------------------------+
% | Author.......: Vanessa Reteguín <vanessa@reteguin.com>
% | First release: August 29th, 2026
% | Last update..: August 31th, 2026
% | WhatIs.......: Matrix Image Processing Homework 1 - Main
% +-----------------------------------------------------------------------+

% ------------ Resources / Documentation involved -------------
% Guillaume. (2017, 12 mayo). Indexing a matrix intuitively. Centro de Ayuda Matlab.
% https://la.mathworks.com/matlabcentral/answers/340033-indexing-a-matrix-intuitively#answer_266809

% RutledgePaulV. (2013, 24 junio). Manually turn RGB image into Grayscale Matlab.
% https://stackoverflow.com/questions/17276770/manually-turn-rgb-image-into-grayscale-matlab

% https://la.mathworks.com/help/matlab/ref/image.html#d127e121883
% https://la.mathworks.com/help/images/getting-started-with-image-processing-toolbox.html
% https://la.mathworks.com/matlabcentral/answers/1888952-what-is-the-efficient-way-to-loop-though-a-multidimensional-array-in-matlab
% https://la.mathworks.com/help/matlab/matlab_prog/validate-required-and-optional-positional-arguments.html

% --------------------------- Code ----------------------------------------
clc;

function [] = showAndSaveImage(matrix, graphTitle, filename, options)
% Create a binary image out of given coordinates of white pixels

arguments
    matrix
    graphTitle
    filename
    options.saveImg logical = false
end

folder = 'results';

imshow(matrix);
colorbar;
axis on;  
title(graphTitle);

if options.saveImg
    fullpath = fullfile(folder, filename);
    exportgraphics(gcf, fullpath, 'Resolution', 300);
end

end

% Representación Matricial de una Imagen ----------------------------------
fprintf('Representación Matricial de una Imagen ---------------------\n\n')

% Cargar y mostrar matriz como imágen

% I = [1 1 0 0 0 0 0; 1 0 0 0 1 0 0; 0 0 0 1 0 0 0; 0 0 1 0 0 0 0; 0 1 0 0 1 0 0; 0 1 0 0 0 0 0];
% I = [0 0 0 0 0 1 1;0 1 0 1 0 0 0;0 0 1 0 1 0 1;0 1 0 0 0 0 1;1 1 0 0 1 0 1;1 1 0 0 0 0 1];

I = [0 0 0 1 1 0 0; 0 0 1 1 1 1 0; 0 1 1 1 1 1 1; 0 1 1 1 1 1 0; 0 0 1 1 1 0 0; 0 0 0 1 0 0 0];
showAndSaveImage(I, 'Matriz original', 'original_matrix.jpg', 'saveImg', true);

fprintf('Matriz I:\n')
disp(I);

% 1. Determinar el tamaño de la imagen. -----------------------------------
fprintf('1. Determinar el tamaño de la imagen.\n')
[height, width] = size(I);
fprintf('Altura (height): %dpx\nAnchura (width): %dpx\n\n', height, width)

% 2. Indicar el valor del pixel localizado en las posiciones I(3, 4)-------
% Nota: Matlab ordena las matrices como (fila, columna), por lo tanto
% debemos pedir las cordenadas en formato (y, x) (Guillaume, 2017)
fprintf('2. Indicar el valor del pixel localizado en las posiciones I(3, 4), I(5, 5) y I(7, 4).\n')
fprintf('I(3, 4) = %d\n', I(4,3))
fprintf('I(5, 5) = %d\n', I(5,5))
fprintf('I(7, 4) = %d\n\n', I(4,7))

% 3. Determinar los componentes 4-conectados. -----------------------------
fprintf('3. Determinar los componentes 4-conectados.\n\n')

function [img] = binaryImgFromCoordinates(coordinates, max_i, max_j, options)
% Create a binary image out of given coordinates of white pixels

arguments
    coordinates
    max_i
    max_j
    options.debug logical = false
    options.showSaveimg logical = false
    options.imgTitle (1,1) string = ""
    options.filename (1,1) string = ""
end

img = zeros(max_i, max_j);

[rows, cols] = size(coordinates);

for j = 1:cols
    x = coordinates(1, j);
    y = coordinates(2, j);
    img(x,y) = 1;
    if options.debug
        fprintf('Element at [%d] = [%d; %d]\n', j, x, y);
    end
end

if options.showSaveimg
    % showAndSaveImage(img, 'Componentes 4-conectados', options.imgTitle, 'saveImg', true);
    showAndSaveImage(img, options.imgTitle, options.filename, 'saveImg', true);
end

end


function [components] = connectedComponents4(matrix, options)
% Determine the 4-connected components of a given binary matrix

arguments
    matrix
    options.debug logical = false
end

[rows, cols] = size(matrix);
components = [];

for j = 1:cols
    for i = 1:rows
        if matrix(i,j) == 1
            if options.debug
                fprintf('Element at (%d,%d) is white\n', i, j);
            end
            try
                if (matrix(i - 1,j) > 0) || (matrix(i,j + 1) > 0) || (matrix(i +  1,j) > 0) || (matrix(i,j - 1) > 0)
                    if options.debug
                        fprintf('Element at (%d,%d) is 4 component\n', i, j);
                    end
                    components = [components, [i; j]];
                end
            catch ME
                if options.debug
                    fprintf('Error: ')
                    disp(ME.message);
                end
                try
                    if (matrix(i,j + 1) > 0) || (matrix(i +  1,j) > 0) || (matrix(i,j - 1) > 0)
                        if options.debug
                            fprintf('Element at (%d,%d) is 4 component\n', i, j);
                        end
                        components = [components, [i; j]];
                    end
                catch ME
                    if options.debug
                        fprintf('Error: ')
                        disp(ME.message);
                    end
                    try
                        if (matrix(i +  1,j) > 0) || (matrix(i,j - 1) > 0)
                            if options.debug
                                fprintf('Element at (%d,%d) is 4 component\n', i, j);
                            end
                            components = [components, [i; j]];
                        end
                    catch ME
                        if options.debug
                            fprintf('Error: ')
                            disp(ME.message);
                        end
                        try
                            if (matrix(i,j - 1) > 0)
                                if options.debug
                                    fprintf('Element at (%d,%d) is 4 component\n', i, j);
                                end
                                components = [components, [i; j]];
                            end
                        catch ME
                            if options.debug
                                fprintf('Error: ')
                                disp(ME.message);
                            end
                        end
                    end
                end
            end
        end
        % fprintf('Element at (%d,%d) is %d\n', i, j, matrix(i,j));
    end
end

end

% connectedComponents4(I, 'debug', true)
cc4 = connectedComponents4(I);
cc4

[rows, cols] = size(I);
binaryImgFromCoordinates(cc4, rows, cols, 'debug', false, 'showSaveimg', true, 'imgTitle', 'Componentes 4-conectados', 'filename', '4_connected_components.jpg');
% cc4Img = binaryImgFromCoordinates(cc4, rows, cols);

% 4. Determinar los componentes 8-conectados. -----------------------------
fprintf('4. Determinar los componentes 8-conectados.\n\n')

function [components] = connectedComponents8(matrix, options)
% Determine the 8-connected components of a given binary matrix

arguments
    matrix
    options.debug logical = false
end

[rows, cols] = size(matrix);
components = [];

for j = 1:cols
    for i = 1:rows
        if matrix(i,j) == 1
            if options.debug
                fprintf('Element at (%d,%d) is white\n', i, j);
            end
            try
                if (matrix(i - 1,j) >= 0) || (matrix(i,j + 1) >= 0) || (matrix(i +  1,j) >= 0) || (matrix(i,j - 1) >= 0)
                    if options.debug
                        fprintf('Element at (%d,%d) is 4 component\n', i, j);
                    end
                    components = [components, [i; j]];
                end
            catch ME
                if options.debug
                    fprintf('Error: ')
                    disp(ME.message);
                end
                try
                    if (matrix(i,j + 1) >= 0) || (matrix(i +  1,j) >= 0) || (matrix(i,j - 1) >= 0)
                        if options.debug
                            fprintf('Element at (%d,%d) is 4 component\n', i, j);
                        end
                        components = [components, [i; j]];
                    end
                catch ME
                    if options.debug
                        fprintf('Error: ')
                        disp(ME.message);
                    end
                    try
                        if (matrix(i +  1,j) >= 0) || (matrix(i,j - 1) >= 0)
                            if options.debug
                                fprintf('Element at (%d,%d) is 4 component\n', i, j);
                            end
                            components = [components, [i; j]];
                        end
                    catch ME
                        if options.debug
                            fprintf('Error: ')
                            disp(ME.message);
                        end
                        try
                            if (matrix(i,j - 1) >= 0)
                                if options.debug
                                    fprintf('Element at (%d,%d) is 4 component\n', i, j);
                                end
                                components = [components, [i; j]];
                            end
                        catch ME
                            if options.debug
                                fprintf('Error: ')
                                disp(ME.message);
                            end
                        end
                    end
                end
            end
        end
        % fprintf('Element at (%d,%d) is %d\n', i, j, matrix(i,j));
    end
end

end

% connectedComponents8(I, 'debug', true)
cc8 = connectedComponents8(I);
cc8

[rows, cols] = size(I);
binaryImgFromCoordinates(cc8, rows, cols, 'debug', false, 'showSaveimg', true, 'imgTitle', 'Componentes 8-conectados', 'filename', '8_connected_components.jpg');
% cc8Img = binaryImgFromCoordinates(cc8, rows, cols);

% Escala de Grises --------------------------------------------------------
fprintf('\n\nEscala de Grises -------------------------------------------\n\n')

% 1. Leer la imagen -------------------------------------------------------
fprintf('1. Leer la imagen\n')
img = imread('pato.jpg');

% 2. Mostrar la imagen original -------------------------------------------
fprintf('2. Mostrar la imagen original\n')
showAndSaveImage(img, 'Imagen original', 'original_photo.jpg', 'saveImg', true);

% 3. Determinar las dimensiones -------------------------------------------
fprintf('3. Determinar el tamaño de la imagen.\n')
[width, height] = size(img);
fprintf('Altura (height): %dpx\nAnchura (width): %dpx\n\n', height, width)

% 4. Convertirla a escala de grises ---------------------------------------
fprintf('4. Convertirla a escala de grises\n')

function [grayManual] = manualGrayScale(img, options)
% Transform an rgb image into grayscale manualy

arguments
    img
    options.debug logical = false
    options.imgTitle (1,1) string = ""
    options.filename (1,1) string = ""
    options.saveImg logical = false
end

folder = 'results';

% Obtenemos los componentes individuales rojo, verde y azul (rgb) de la
% imagen (RutledgePaulV, 2013)

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

% Pasamos todos los valores a decimales (float) para prevenir errores
R = double(R);
G = double(G);
B = double(B);
if options.debug
    fprintf('R: %d\nG: %d\nB: %d\n', R, G, B);
end

% Obtenemos el promedio de los componentes de la imagen
grayManual = (R + G + B) / 3;

% Convertimos de nuevo a enteros (visualización estándar para imágenes)
grayManual = uint8(grayManual);

if options.saveImg
    showAndSaveImage(grayManual, options.imgTitle, options.filename, 'saveImg', true);
end

end

imgGrayScale = manualGrayScale(img, 'debug', false, 'imgTitle', 'Imagen en escala de grises', 'filename', 'grayscale_image.jpg', 'saveImg', true);

% 5. Mostrar la imagen en escala de grises --------------------------------
fprintf('5. Mostrar la imagen en escala de grises\n')
imshow(imgGrayScale);

% 6. Obtener los valores de intensidad de los pixeles ---------------------
% [!] Se entiende que es de la imagen en escala de grieses, NO la original

fprintf('6. Obtener los valores de intensidad de los pixeles\n')
% imgGrayScale 
% [!] Los valores completos se obtienen al descomentar la línea anterior,
% se deja comentada porque son demasiados y abarcan toda la consola

% 7. Determinar el valor mínimo de intensidad -----------------------------
fprintf('7. Determinar el valor mínimo de intensidad\n')
minImg = min(imgGrayScale, [], 'all')

% 8. Determinar el valor máximo de intesidad ------------------------------
fprintf('8. Determinar el valor máximo de intesidad\n')
maxImg = max(imgGrayScale, [], 'all')

% 9. Calcular la intensidad promedio --------------------------------------
fprintf('9. Calcular la intensidad promedio\n')

function [manualMean] = manualMeanIntensity(img, options)
% Calculate the mean intensity of an image by hand

arguments
    img
    options.debug logical = false
end

% Pasamos todos los valores a decimales (float) para prevenir errores
imgDouble = double(img);

% Concatenamos todos los valores de la matriz en un solo vector de 1
% dimensión para poder sumar todos los valores y hacer el promedio
imgSum = sum(imgDouble(:));

if options.debug
    imgSum
end

% Obtenemos el número de pixeles de la imagen para dividir sobre este valor
% al hacer el promedio
totalImgPixels = numel(imgDouble);

if options.debug
    fprintf('totalImgPixels: %d\n', totalImgPixels);
end

% Hacemos el promedio
manualMean = imgSum / totalImgPixels;
if options.debug
    fprintf('manualMean: %d\n', manualMean);
end

end

intensity = manualMeanIntensity(imgGrayScale, 'debug', true);
intensity