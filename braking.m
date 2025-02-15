%% Braking Section

x0 = transition_start(1); % Start x coord
y0 = transition_start(2); % Start y-position
z0 = transition_start(3); % Start height

% Calculate velocity as sqrt(2gh) where h = z0 - z
h = parameters.initial_h - z0; % height difference

% Compute velocity at start
v = sqrt(2 * parameters.g * h);

a = ( -v*v ) / (2*braking_length);

y_braking = linspace(y0, y0 + braking_length, parameters.trans_fid);
x_braking = x0 * ones(size(y_braking));
z_braking = z0 * ones(size(y_braking));

G_s_braking = a * ones(size(y_braking)) ./ parameters.g;

% Compute G-Forces
G_normal_braking = ones(size(y_braking)); % Normal force supports full weight
G_lateral_braking = zeros(size(y_braking)); % No lateral forces
G_forwardback_braking = (a / parameters.g) * ones(size(y_braking)); % Braking force effect

G_total_braking = vecnorm([G_normal_braking; G_lateral_braking; G_forwardback_braking], 2, 1);

%% Plot G-Forces vs. Path Length
figure;

% Normal G-Force Plot
subplot(3,1,1);
plot(y_braking, G_normal_braking, 'r', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Up / Down G');
title('Up / Down G-Force Along Braking Section');
grid on;

% Lateral G-Force Plot
subplot(3,1,2);
plot(y_braking, G_lateral_braking, 'b', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Lateral G');
title('Lateral G-Force Along Braking Section');
grid on;

% Up/Down G-Force Plot
subplot(3,1,3);
plot(y_braking, G_forwardback_braking, 'g', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Forward / Backwards G');
title('Forward / Backwards G-Force Along Braking Section');
grid on;

% Overall title for figure
sgtitle('G-Forces Along Braking Section');
saveas(gcf, "G_Forces_Braking.png");

parameters.path_length = parameters.path_length + braking_length;