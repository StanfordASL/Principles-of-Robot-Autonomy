clear; clc; close all;
path = fileparts(which('distributions.m'));
cardinal = [140, 21, 21]/256;
pink = [234, 174, 174]/256;
fontsize = 16;

fig = figure();
set(fig, 'Visible', 'on', 'color', [1,1,1], 'Position', [1, 1, 600, 1000]);
subplot(3,1,1);
x = -10:0.1:10;
y = normpdf(x,0,1);
plot(x, y, 'color', cardinal, 'linewidth', 2);
ylim([-.1, 0.5]);
set(gca,'xtick',[])
set(gca,'ytick',[])
xlabel('$x$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('probability, $p(x)$', 'interpreter', 'latex', 'fontsize', fontsize);
title('Gaussian', 'interpreter', 'latex', 'fontsize', fontsize);

subplot(3,1,2); hold on;
x = -10:0.1:10;
y1 = normpdf(x,1,0.75);
y2 = normpdf(x,-7,2);
y3 = normpdf(x,4,1);
plot(x, y1, 'color', cardinal, 'linewidth', 2);
plot(x, y2, 'color', cardinal, 'linewidth', 2);
plot(x, y3, 'color', cardinal, 'linewidth', 2);
ylim([-.1, 0.7]);
set(gca,'xtick',[])
set(gca,'ytick',[])
xlabel('$x$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('probability, $p(x)$', 'interpreter', 'latex', 'fontsize', fontsize);
title('Mixture of Gaussians', 'interpreter', 'latex', 'fontsize', fontsize);

subplot(3,1,3); hold on;
x = randn(100,1);
h = histogram(x, 20, 'facecolor', cardinal);
set(gca,'xtick',[])
set(gca,'ytick',[])
xlabel('$x$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('probability, $p(x)$', 'interpreter', 'latex', 'fontsize', fontsize);
title('Discrete', 'interpreter', 'latex', 'fontsize', fontsize);

filename = strcat(path, '/distributions');
export_fig(filename, '-png', '-m4','-transparent')

