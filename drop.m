%% This section serves as a transition between track elements. It will serve to accelerate the cart further

x0_drop = transition_start(1);

y0_drop = transition_start(2);

z0_drop = transition_start(3);

ramp_angle = 45; % degrees
ramp_angle_rads = ramp_angle*(pi/180);

fidelity = parameters.trans_fid; % points

total_section_length = drop_length/sin(ramp_angle_rads);

s_drop = linspace(0,total_section_length,fidelity);

[x_drop, y_drop, z_drop] = drop_path(s_drop, ramp_angle_rads, x0_drop, y0_drop, z0_drop, pos_y);

% Calculate velocity as sqrt(2gh) where h = z0_drop - z
h = parameters.initial_h - z0_drop; % height difference

% Compute velocity at each point
v = sqrt(2 * parameters.g * h);
cart.speed = v;

% Normal G-force (perpendicular to the surface)
G_normal_drop = cos(ramp_angle_rads) * ones(size(s_drop));

% Lateral G-force (zero for straight ramp)
G_lateral_drop = zeros(size(s_drop));

G_forwardback_drop = zeros(size(s_drop));

%% Plot G-Forces vs. Path Length
figure;
hold on;
% Normal G-Force Plot
subplot(3,1,1);
plot(s_drop, G_normal_drop, 'r', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Up / Down G');
title('Up / Down G-Force Along Ramp');
grid on;

% Lateral G-Force Plot
subplot(3,1,2);
plot(s_drop, G_lateral_drop, 'b', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Lateral G');
title('Lateral G-Force Along Ramp');
grid on;

% Up/Down G-Force Plot
subplot(3,1,3);
plot(s_drop, G_forwardback_drop, 'g', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Forward / Backwards G');
title('Forward / Backwards G-Force Along Ramp');
grid on;

% Overall title for figure
fig_title = sprintf("G-Forces Along Drop %d", drop_count);
sgtitle(fig_title);
hold off;

filename = sprintf("G_Forces_Drop_%i.png", drop_count);
saveas(gcf, filename);

%%
parameters.path_length = parameters.path_length + s_drop(end);

function [x,y,z] = drop_path(s, ramp_angle, x0, y0, z0, pos_y)

    x = x0*ones(1,length(s));
    
    if pos_y
        y = y0 + s*cos(ramp_angle);
    else
        y = y0 - s*cos(ramp_angle);
    end

    z = z0 - s*sin(ramp_angle);

end




