clear; clc; close all;
path = fileparts(which('sobel.m'));
img = imread(strcat(path, '/track.jpg'));
X = double(rgb2gray(img));

%% Sobel filter
S = edge(X,'sobel');
figure;
imshow(S);
filename = strcat(path, '/track_sobel');
export_fig(filename, '-png', '-m4','-transparent')