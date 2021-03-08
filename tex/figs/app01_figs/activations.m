clear; close all; clc;
path = fileparts(which('activations.m'));
cardinal = [140, 21, 21]/256;
pink = [234, 174, 174]/256;
fontsize = 24;

fig = figure();
set(fig, 'Visible', 'on', 'color', [1,1,1], 'Position', [1, 1, 2000, 400]);

% Sigmoid
x = linspace(-10,10,1001);
y = sigmoid(x);
subplot(1,4,1);
plot(x, y, 'color', cardinal, 'linewidth', 2);
ylim([-0.1 1.1]);
xlabel('$x$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('$\sigma(x)$', 'interpreter', 'latex', 'fontsize', fontsize);

% Hyperbolic tangent
y = tanh(x);
subplot(1,4,2);
plot(x, y, 'color', cardinal, 'linewidth', 2);
ylim([-1.1 1.1]);
xlabel('$x$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('tanh$(x)$', 'interpreter', 'latex', 'fontsize', fontsize);

% ReLU function
y = relu(x);
subplot(1,4,3);
plot(x, y, 'color', cardinal, 'linewidth', 2);
ylim([-1 10]);
xlabel('$x$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('relu$(x)$', 'interpreter', 'latex', 'fontsize', fontsize);

% Leaky ReLU function
y = leaky_relu(x);
subplot(1,4,4);
plot(x, y, 'color', cardinal, 'linewidth', 2);
% ylim([-0.1 1.1]);
xlabel('$x$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('leaky\_relu$(x)$', 'interpreter', 'latex', 'fontsize', fontsize);


filename = strcat(path, '/activations');
export_fig(filename, '-png', '-m4','-transparent')

function [y] = sigmoid(x)
y = 1./(1 + exp(-x));
end

function [y] = relu(x)
y = zeros(size(x));
for i = 1:length(x)
    y(i) = max([0, x(i)]);
end
end

function [y] = leaky_relu(x)
y = zeros(size(x));
for i = 1:length(x)
    y(i) = max([0.1*x(i), x(i)]);
end
end