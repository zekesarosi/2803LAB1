y0 = transition_start(2); % Start y-position
z0 = transition_start(3); % Start height
L = 10; % Desired transition length

if pos_y
    yf = y0 + L; % Compute y_f based on desired length
else
    yf = y0 - L;
end

% Define end height based on transition length and curvature
zf = z0 - 5; % You can adjust this for different transition steepness

% Solve for a to enforce transition length L
a = -(zf - z0) / L^2;

if ~concavity
    a = -a;
end


c = z0;

% Generate transition path
y_vals = linspace(y0, yf, parameters.trans_fid);
z_vals = a * (y_vals - y0).^2 + c;
x_vals = ones(size(y_vals)) * transition_start(1); % Keep x constant

% Compute velocity profile
v = sqrt(2 * parameters.g .* (parameters.initial_h - z_vals));

%% Compute G-forces

% First derivatives (dz/dy)
dz_dy = gradient(z_vals, y_vals);

% Second derivatives (d^2z/dy^2)
d2z_dy2 = gradient(dz_dy, y_vals);

% Compute radius of curvature R
R = ((1 + dz_dy.^2).^(3/2)) ./ abs(d2z_dy2);

% Compute normal acceleration
a_n = v.^2 ./ R;

% Compute tangential acceleration
ds = sqrt(diff(y_vals).^2 + diff(z_vals).^2); % Arc length elements
dv = diff(v); % Velocity change
a_t = [0, dv ./ ds]; % Tangential acceleration (assuming zero at start)

% Compute total acceleration
a_total = sqrt(a_t.^2 + a_n.^2);

% Convert to G-force
G_total = a_total / parameters.g;

%% Plot results
figure(1);
hold on;
scatter3(x_vals, y_vals, z_vals, 20, G_total, 'filled');
colorbar;
xlabel('X Axis');
ylabel('Y Axis');
zlabel('Z Axis');
hold off;