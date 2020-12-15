clear; clc; close all;
path = fileparts(which('houghtransform.m'));
cardinal = [140, 21, 21]/256;
pink = [234, 174, 174]/256;
fontsize = 16;
N = 11;
fig = figure();
set(fig, 'Visible', 'on', 'color', [1,1,1], 'Position', [1, 1, 1000, 500]);

% Original points
line1 = [linspace(1,2,N);
         linspace(1,2,N)];
line2 = [linspace(1,2,N);
         linspace(2,1,N)];
subplot(1,2,1); hold on;
plot(line1(1,:), line1(2,:), 'marker', '.', 'color', pink, 'LineStyle', 'none', 'markersize', 20);
plot(line2(1,:), line2(2,:), 'marker', '.', 'color', pink, 'LineStyle', 'none', 'markersize', 20);
xlim([0.5, 2.5])
ylim([0.5, 2.5])
axis off
axis equal

% Hough transform points
subplot(1,2,2); hold on;
alpha = linspace(0, pi, 100);
for i = 1:N
    r1 = line1(1,i)*cos(alpha) + line1(2,i)*sin(alpha);
    plot(alpha, r1, 'color', pink, 'linewidth', 1);
    
    r2 = line2(1,i)*cos(alpha) + line2(2,i)*sin(alpha);
    plot(alpha, r2, 'color', pink, 'linewidth', 1);
end
axis off
filename = strcat(path, '/hough_paramspace');
export_fig(filename, '-png', '-m4','-transparent')

% Single line
figure;
plot(alpha, r2, 'color', pink, 'linewidth', 5);
axis off
filename = strcat(path, '/hough_curve');
export_fig(filename, '-png', '-m4','-transparent')