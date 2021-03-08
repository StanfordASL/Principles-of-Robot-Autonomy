clear; clc; close all;
path = fileparts(which('carKFfusion.m'));
cardinal = [140, 21, 21]/256;
pink = [234, 174, 174]/256;
fontsize = 16;
sig_lidar = 0.5;
sig_gnss = 0.1;
sig_imu = 0.2;
R = diag([0.05, 0.001, 0.05]);

% Car longitudinal dynamics
T = 0.015;
A_KF = [1, T, T^2/1;
        0, 1, T;
        0, 0, 1];
A = [1, T;
     0, 1];
B = [T^2/1;
     T];

% Simulation
a = [ones(1,100), -ones(1,150), ones(1,50), zeros(1,100), -ones(1,75), ...
     ones(1,100), -0.25*ones(1,100), zeros(1,100)];
N = size(a,2);
x = zeros(2, N);
for i = 1:N
    x(:,i+1) = A*x(:,i) + B*a(i);
end

% Sensor fusion, lidar only
Q = diag([sig_lidar^2, sig_imu^2]);
C_KF = [1, 0, 0;
        0, 0, 1];
t_1 = 1:N+1;
xhat_1 = zeros(3, N);
z_1 = zeros(2,N-1);
S_t = eye(3);
for i = 1:N-1
    delta_t = mvnrnd(zeros(2,1), Q)';
    xhat_t = xhat_1(:,i);
    z_t = C_KF*[x(:,i+1); a(i+1)] + delta_t;
    z_1(:,i) = z_t;
    mubar_t = A_KF*xhat_t;
    Sbar_t = A_KF*S_t*A_KF' + R;
    K_t = Sbar_t*C_KF'*inv(C_KF*Sbar_t*C_KF' + Q);
    mu_t = mubar_t + K_t*(z_t - C_KF*mubar_t);
    S_t = (eye(3) - K_t*C_KF)*Sbar_t;
    xhat_1(:,i+1) = mu_t;
end

% Sensor fusion, lidar and gnss
Q = diag([sig_lidar^2, sig_gnss^2, sig_imu^2]);
C_KF = [1, 0, 0;
        1, 0, 0;
        0, 0, 1];
xhat_2 = zeros(3, N);
z_2 = zeros(3,N-1);
S_t = eye(3);
for i = 1:N-1
    delta_t = mvnrnd(zeros(3,1), Q)';
    xhat_t = xhat_2(:,i);
    z_t = C_KF*[x(:,i+1); a(i+1)] + delta_t;
    z_2(:,i) = z_t;
    mubar_t = A_KF*xhat_t;
    Sbar_t = A_KF*S_t*A_KF' + R;
    K_t = Sbar_t*C_KF'*inv(C_KF*Sbar_t*C_KF' + Q);
    mu_t = mubar_t + K_t*(z_t - C_KF*mubar_t);
    S_t = (eye(3) - K_t*C_KF)*Sbar_t;
    xhat_2(:,i+1) = mu_t;
end
    
fig = figure();
set(fig, 'Visible', 'on', 'color', [1,1,1], 'Position', [1, 1, 1000, 1000]);
subplot(2,1,1); hold on;
plot(t_1, x(1,:), 'color', cardinal, 'linewidth', 2, 'linestyle', '--');
plot(t_1(2:end), xhat_1(1,:), 'color', pink, 'linewidth', 1);
ylim([-.5, 2.5]);
set(gca,'xtick',[])
set(gca,'ytick',[])
xlabel('$t$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('$p$', 'interpreter', 'latex', 'fontsize', fontsize);
legend('Ground truth', 'Sensor fusion', 'interpreter', 'latex', 'fontsize', fontsize);
title('Kalman Filter with Lidar and IMU', 'interpreter', 'latex', 'fontsize', fontsize);

subplot(2,1,2); hold on;
plot(t_1, x(1,:), 'color', cardinal, 'linewidth', 2, 'linestyle', '--');
plot(t_1(2:end), xhat_2(1,:), 'color', pink, 'linewidth', 1);
ylim([-.5, 2.5]);
set(gca,'xtick',[])
set(gca,'ytick',[])
xlabel('$t$', 'interpreter', 'latex', 'fontsize', fontsize);
ylabel('$p$', 'interpreter', 'latex', 'fontsize', fontsize);
legend('Ground truth', 'Sensor fusion', 'interpreter', 'latex', 'fontsize', fontsize);
title('Kalman Filter with Lidar, GNSS, and IMU', 'interpreter', 'latex', 'fontsize', fontsize);

filename = strcat(path, '/carKFfusion');
export_fig(filename, '-png', '-m4','-transparent')

