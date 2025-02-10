%% Here we are using circular arc geometry to create smooth transitions between sections

y0 = transition_start(2); % Start y-position
z0 = transition_start(3); % Start height
zf = transition_start(3) - 5; % End height (fixed at banked turn)

% Hardcoded values


if pos_y
    yf = y0 + 2 * (z0 - zf); % Compute y_f
else 
    yf = y0 + 2 * (z0 - zf)*-1; % Compute y_f if y direction is neg
end


if concavity
    a = 1 / (4 * (z0 - zf));
else
    a = -1 / (4 * (z0 - zf));
end

c = z0;

% Generate transition path
y_vals = linspace(y0, yf, parameters.trans_fid);
z_vals = a * (y_vals - y0).^2 + b * (y_vals - y0) + c;
x_vals = ones(size(y_vals)) * transition_start(1); % Keep x constant

v = sqrt(2*parameters.g.*(parameters.initial_h - z_vals));

% Plot the transition section
scatter3(x_vals, y_vals, z_vals, 20, v, 'filled');
