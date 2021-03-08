clear; clc; close all;
path = fileparts(which('signals.m'));
cardinal = [140, 21, 21]/256;
fontsize = 16;

%% Edge Detection in 1D
width = 15;
I = zeros(1,1000);
I(501:end) = 1;
I(500-width:500+width) = linspace(0,1,2*width + 1);
noise = 0.02*randn(1,1000);
I = I + noise;
dI = diff(I);

fig = figure();
set(fig, 'Visible', 'on', 'color', [1,1,1], 'Position', [1, 1, 600,500]);
subplot(2,1,1);
plot(I, 'color', cardinal, 'linewidth', 2);
ylim([-0.1, 1.1])
set(gca,'xtick',[])
set(gca,'ytick',[])
title('$I(x)$', 'interpreter', 'latex', 'fontsize', fontsize)

subplot(2,1,2);
plot(dI, 'color', cardinal, 'linewidth', 2);
set(gca,'xtick',[])
set(gca,'ytick',[])
title('$dI(x)/dx$', 'interpreter', 'latex', 'fontsize', fontsize)
% filename = strcat(path, '/edge_detection');
% export_fig(filename, '-png', '-m4','-transparent')

%% Gaussian smoothing differentiation
I_smooth = smoothdata(I, 'gaussian', 200);
dI_smooth = diff(I_smooth);

fig = figure();
set(fig, 'Visible', 'on', 'color', [1,1,1], 'Position', [1, 1, 600,7500]);
subplot(3,1,1);
plot(I, 'color', cardinal, 'linewidth', 2);
ylim([-0.1, 1.1])
set(gca,'xtick',[])
set(gca,'ytick',[])
title('$I(x)$', 'interpreter', 'latex', 'fontsize', fontsize)

subplot(3,1,2);
plot(I_smooth, 'color', cardinal, 'linewidth', 2);
ylim([-0.1, 1.1])
set(gca,'xtick',[])
set(gca,'ytick',[])
title('$s(x) = g_{\sigma}(x) \ast I(x)$', 'interpreter', 'latex', 'fontsize', fontsize)

subplot(3,1,3);
plot(dI_smooth, 'color', cardinal, 'linewidth', 2);
set(gca,'xtick',[])
set(gca,'ytick',[])
title('$ds(x)/dx$', 'interpreter', 'latex', 'fontsize', fontsize)
% filename = strcat(path, '/edge_detection_smooth');
% export_fig(filename, '-png', '-m4','-transparent')