FIDELITY = parameters.feature_fid;
g = parameters.g;
h_0 = parameters.initial_h;
x0_parab = parabola_start(1);
y0_parab = parabola_start(2);
z0_parab = parabola_start(3);
v0 = sqrt(2 * g * (h_0 - z0_parab));
launch_angle = 3*pi/4;
yf_parab = -200;

y_parab = linspace(y0_parab, yf_parab, FIDELITY);
delta_y_parab = (yf_parab - y0_parab) / FIDELITY;

% for zero g parabola
a = -1 / (4 * (h_0 - z0_parab) * ( cos(launch_angle) )^2);
b = tan(launch_angle);
c = z0_parab;

G_parab = calculateParabolaGs(a, b, c, y_parab, y0_parab, h_0);
z_parab = a * (y_parab - y0_parab) .^2 + b * (y_parab - y0_parab) + c;
s_parab = zeros(1, FIDELITY);
for i=2:FIDELITY
    s_parab(i) = calculateParabolaDistance(a, b, c, y_parab(i), delta_y_parab, s_parab(i - 1));
end
v_parab = sqrt(2 * g * (h_0 - z_parab));

%% Plot G Forces
figure();
hold on;
% Normal G-Force Plot
subplot(3,1,1);
plot(s_parab, G_parab, 'r', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Up / Down G');
title('Up / Down G-Force');
grid on;

% Lateral G-Force Plot
subplot(3,1,2);
plot(s_parab, zeros(1, FIDELITY), 'b', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Lateral G');
title('Lateral G-Force');
grid on;

% Up/Down G-Force Plot
subplot(3,1,3);
plot(s_parab, zeros(1, FIDELITY), 'g', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Forward / Backwards G');
title('Forward / Backwards G-Force');
grid on;

sgtitle('G-Forces Along Parabola'); 
hold off;
saveas(gcf, "G_Forces_Parabola.png");

function G_N_parabola = calculateParabolaGs(a, b, c, x, x_0, h_0)
    G_N_parabola = ( 4 * a * (h_0 - c) + b^2 + 1 ) ./ ( ( 4 * a^2 .* (x - x_0).^2 ) + ( 4 * a * b .* (x - x_0) ) + b^2 + 1).^1.5;
end

function distance = calculateParabolaDistance(a, b, c, x, delta_x, current_distance)
    y = a * x^2 + b * x + c;
    y_prev = a * (x - delta_x)^2 + b * (x - delta_x) + c;
    delta_y_parab = abs(y - y_prev);
    distance = current_distance + sqrt(delta_x^2 + delta_y_parab^2); 
end