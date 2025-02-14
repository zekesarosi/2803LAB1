%% This section serves as a transition between track elements. It will serve to accelerate the cart further


x0 = transition_start(1);

y0 = transition_start(2);

z0 = transition_start(3);

ramp_angle = 45; % degrees
ramp_angle_rads = ramp_angle*(pi/180);

fidelity = parameters.trans_fid; % points

total_section_length = drop_length/sin(ramp_angle_rads);

s = linspace(0,total_section_length,fidelity);

[x, y, z] = drop_path(s, ramp_angle_rads, x0, y0, z0, pos_y);

% Calculate velocity as sqrt(2gh) where h = z0 - z
h = parameters.initial_h - z; % height difference

% Compute velocity at each point
v = sqrt(2 * parameters.g * h);

% Create scatter plot with color proportional to velocity
%figure(1);
%hold on;
%scatter3(x, y, z, 20, ones(size(v)), 'filled'); % 50 is marker size
%hold off;

cart.speeed = v(fidelity);


% Normal G-force (perpendicular to the surface)
G_normal = cos(ramp_angle_rads) * ones(size(s));

% Lateral G-force (zero for straight ramp)
G_lateral = zeros(size(s));

% Up/Down G-force (along gravity direction)
G_updown = sin(ramp_angle_rads) * ones(size(s));

%% Plot G-Forces vs. Path Length
figure;
hold on;
% Normal G-Force Plot
subplot(3,1,1);
plot(s, G_normal, 'r', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Normal G');
title('Normal G-Force Along Ramp');
grid on;

% Lateral G-Force Plot
subplot(3,1,2);
plot(s, G_lateral, 'b', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Lateral G');
title('Lateral G-Force Along Ramp');
grid on;

% Up/Down G-Force Plot
subplot(3,1,3);
plot(s, G_updown, 'g', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Up/Down G');
title('Up/Down G-Force Along Ramp');
grid on;

% Overall title for figure
sgtitle('G-Forces Along Ramp');
hold off;

parameters.path_length = parameters.path_length + s(end);

function [x,y,z] = drop_path(s, ramp_angle, x0, y0, z0, pos_y)

    x = x0*ones(1,length(s));
    
    if pos_y
        y = y0 + s*cos(ramp_angle);
    else
        y = y0 - s*cos(ramp_angle);
    end

    z = z0 - s*sin(ramp_angle);

end




