function [x_vals, y_vals, z_vals, s_vals] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, trans_fid, parameters)
    global parameters;
    % Extract start coordinates
    y0 = transition_start(2);
    z0 = transition_start(3);
    
    % Compute yf based on pos_y direction
    if pos_y
        yf = y0 + L;
    else
        yf = y0 - L;
    end

    % Define differences
    dy = yf - y0;

    % Solve for cubic polynomial coefficients
    A = [dy^3, dy^2, dy, 1;   % z(yf) = zf
         3*dy^2, 2*dy, 1, 0;  % dz/dy at y_f = end_slope
         0, 0, 1, 0;          % dz/dy at y_0 = start_slope
         0, 0, 0, 1];         % z(y0) = z0
    
    b_vec = [zf; end_slope; start_slope; z0];

    coeffs = A \ b_vec; % Solve system

    % Extract coefficients
    a = coeffs(1);
    b = coeffs(2);
    c = coeffs(3);
    d = coeffs(4);
    
    % Apply concavity (flips the curve if needed)
    if ~concavity
        a = -a;
        b = -b;
        c = -c;
    end
    
    % Generate transition path
    y_vals = linspace(y0, yf, trans_fid);
    z_vals = a * (y_vals - y0).^3 + b * (y_vals - y0).^2 + c * (y_vals - y0) + d;
    
    % Compute incremental arc length (ds)
    dy_vals = diff(y_vals);
    dz_vals = diff(z_vals);
    ds_vals = sqrt(dy_vals.^2 + dz_vals.^2);  % Arc length elements

    % Compute cumulative arc length s
    s_vals = [0, cumsum(ds_vals)];  % Append zero at start

    % Compute velocity profile
    v = sqrt(2 * parameters.g * (parameters.initial_h - z_vals));

    %% Compute G-forces

    % First derivatives (dz/dy)
    dz_dy = gradient(z_vals, y_vals);

    % Second derivatives (d^2z/dy^2)
    d2z_dy2 = gradient(dz_dy, y_vals);

    % Compute radius of curvature R
    R = ((1 + dz_dy.^2).^(3/2)) ./ max(abs(d2z_dy2), 1e-6);  % Avoid division by zero

    % Compute normal acceleration
    a_n = v.^2 ./ R;

    % Compute tangential acceleration
    dv = diff(v);  % Velocity change
    a_t = [0, dv ./ max(ds_vals, 1e-6)]; % Avoid division by zero

    % Compute lateral and up/down accelerations
    theta = atan(dz_dy);  % Local path slope
    a_lat = zeros(size(a_t));  % Lateral acceleration
    a_updown = a_n .* cos(theta);  % Vertical acceleration

    % Convert to G-forces
    G_normal = a_n / parameters.g;
    G_lateral = a_lat / parameters.g;
    G_updown = a_updown / parameters.g;

    x_vals = transition_start(1) * ones(size(y_vals));

    %% Plot G-Forces vs. Path Length s
    figure;
    hold on;
    % Normal G-Force Plot
    subplot(3,1,1);
    plot(s_vals, G_normal, 'r', 'LineWidth', 2);
    xlabel('Path Length (s) [m]');
    ylabel('Up / Down G');
    title('Up / Down G-Force Along Transition');
    grid on;
    
    % Lateral G-Force Plot
    subplot(3,1,2);
    plot(s_vals, G_lateral, 'b', 'LineWidth', 2);
    xlabel('Path Length (s) [m]');
    ylabel('Lateral G');
    title('Lateral G-Force Along Transition');
    grid on;
    
    % Up/Down G-Force Plot
    subplot(3,1,3);
    plot(s_vals, G_updown, 'g', 'LineWidth', 2);
    xlabel('Path Length (s) [m]');
    ylabel('Forward / Backwards G');
    title('Forward / Backwards G-Force Along Transition');
    grid on;
    
    % Overall title for the figure
    fig_title = sprintf("G-Forces Along Transition Path %d", parameters.transition_count);
    sgtitle(fig_title);
    hold off;

    % Define filename with transition count
    filename = sprintf('G_Forces_Transition_%d.png', parameters.transition_count);

    % Save the figure with the dynamic filename
    saveas(gcf, filename);  
    parameters.transition_count = parameters.transition_count + 1;
    parameters.path_length = parameters.path_length + s_vals(end);
end
