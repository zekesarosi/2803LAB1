%% Braking Section

x0 = transition_start(1); % Start x coord
y0 = transition_start(2); % Start y-position
z0 = transition_start(3); % Start height

% Calculate velocity as sqrt(2gh) where h = z0 - z
h = parameters.initial_h - z0; % height difference

% Compute velocity at start
v = sqrt(2 * parameters.g * h);

a = (-v*v)/(2*length);

y = linspace(y0, y0+length, parameters.trans_fid);
x = x0 * ones(size(y));
z = z0 * ones(size(y));

G_s = a*ones(size(y))./parameters.g;

% Compute G-Forces
G_normal = ones(size(s)); % Normal force supports full weight
G_lateral = zeros(size(s)); % No lateral forces
G_updown = (a / parameters.g) * ones(size(s)); % Braking force effect

%% Plot G-Forces vs. Path Length
figure;

% Normal G-Force Plot
subplot(3,1,1);
plot(s, G_normal, 'r', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Up / Down G');
title('Up / Down G-Force Along Braking Section');
grid on;

% Lateral G-Force Plot
subplot(3,1,2);
plot(s, G_lateral, 'b', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Lateral G');
title('Lateral G-Force Along Braking Section');
grid on;

% Up/Down G-Force Plot
subplot(3,1,3);
plot(s, G_updown, 'g', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Forward / Backwards G');
title('Forward / Backwards G-Force Along Braking Section');
grid on;

% Overall title for figure
sgtitle('G-Forces Along Braking Section');

parameters.path_length = parameters.path_length + length;

%scatter3(x, y, z, 20, abs(G_s), "filled")