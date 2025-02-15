%% Banked turn script

cart.speed = sqrt(2*parameters.g*(parameters.initial_h - banked_turn_origin(3)));
bank_angle_rads = bank_angle_degs * (pi/180);
radius = (cart.speed^2)*(cot(bank_angle_rads))/(parameters.g); % In meters


% Total track length since banked turn is a half circle

total_banked_turn_length = radius*pi;

fidelity = parameters.feature_fid; % amount of points to be modeled

s_banked_turn = linspace(0,total_banked_turn_length,fidelity); % array of discrete track lengths 

G_normal_banked_turn = 1/cos(bank_angle_rads);
G_lateral_banked_turn = zeros(1, length(s_banked_turn));
G_forwardback_banked_turn = zeros(1, length(s_banked_turn));

[x_banked_turn, y_banked_turn, z_banked_turn] = banked_turn_path(s_banked_turn, radius, banked_turn_origin(1), banked_turn_origin(2), banked_turn_origin(3), dir);

% v = cart.speed.*ones(1, length(s));


%% Create Figure with Subplots
figure(2);
hold on;
% Normal G-Force Plot
subplot(3,1,1);
plot(s_banked_turn, G_normal_banked_turn*ones(size(s_banked_turn)), 'r', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Up / Down G');
title('Up / Down G-Force Along Banked Turn');
grid on;

% Lateral G-Force Plot
subplot(3,1,2);
plot(s_banked_turn, G_lateral_banked_turn, 'b', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Lateral G');
title('Lateral G-Force Along Banked Turn');
grid on;

% Up/Down G-Force Plot
subplot(3,1,3);
plot(s_banked_turn, G_forwardback_banked_turn, 'g', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Forward / Backwards G');
title('Forward / Backwards G-Force Along Banked Turn');
grid on;

% Adjust spacing between subplots
fig_title = sprintf('G-Forces Along Banked Turn %i', banked_turn_count);
sgtitle(fig_title); % Overall title for the figure
hold off;

filename = sprintf("G_Forces_Banked_Turn_%i.png", banked_turn_count);
saveas(gcf, filename);

function [x, y, z] = banked_turn_path(s, radius, x0, y0, z0, dir)
   

    % Function to compute the x, y coordinates of a banked turn
    % s      - Track length along the arc 
    % radius - Radius of the circular turn
    % x0, y0 - Starting coordinates of the turn
    
    % Compute the angle theta as a function of s
    theta = s / radius; % Angular position in radians
    
    % Parametric equations for x and y
    x = (x0 + radius * cos(theta)) - radius;
    
    if dir 
        y = y0 + radius * 1*sin(theta);
    else
        y = y0 + radius * -1*sin(theta);
    end
    
    z = z0 * ones(1,length(s));


end

