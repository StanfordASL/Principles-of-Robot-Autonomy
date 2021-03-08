clear; clc; close all;
path = fileparts(which('gaussians.m'));
cardinal = [140, 21, 21]/256;
pink = [234, 174, 174]/256;
fontsize = 22;

fig = figure();
set(fig, 'Visible', 'on', 'color', [1,1,1], 'Position', [1, 1, 1200, 500]);
subplot(1,2,1);
mu = 0;
sigma = 1;
x = -5:0.1:5;
y = normpdf(x,mu,sigma);
plot(x, y, 'color', cardinal, 'linewidth', 2);
ylim([-.1, 0.6]);
set(gca,'xtick',[])
set(gca,'ytick',[])
xlabel('$x$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('$p(x)$', 'interpreter', 'latex', 'fontsize', fontsize);
title('Univariate Gaussian', 'interpreter', 'latex', 'fontsize', fontsize);

subplot(1,2,2);
mu = [0 0];
Sigma = [0.7 0.4; 0.4 1];
x1 = -2:0.1:2;
x2 = -2:0.1:2;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y = mvnpdf(X,mu,Sigma);
y = reshape(y,length(x2),length(x1));
C = zeros(size(y,1), size(y,2), 3);
for i = 1:size(y,1)
    for j = 1:size(y,2)
        C(i,j,:) = pink;
    end
end
surf(x1,x2,y,C, 'edgecolor', cardinal)
set(gca,'xtick',[])
set(gca,'ytick',[])
set(gca,'ztick',[])
xlabel('$x_1$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('$x_2$', 'interpreter', 'latex', 'fontsize', fontsize);
zlabel('$p(x_1, x_2)$', 'interpreter', 'latex', 'fontsize', fontsize);
title('Multivariate Gaussian', 'interpreter', 'latex', 'fontsize', fontsize);

filename = strcat(path, '/gaussians');
export_fig(filename, '-png', '-m4','-transparent')

