%% Banked turn script

cart.speed = sqrt(2*parameters.g*(parameters.initial_h - banked_turn_origin(3)));
bank_angle_rads = bank_angle_degs * (pi/180);
radius = (cart.speed^2)*(cot(bank_angle_rads))/(parameters.g); % In meters


% Total track length since banked turn is a half circle

total_banked_turn_length = radius*pi;

G_banked_turn = 1/cos(bank_angle_rads);



fidelity = parameters.feature_fid; % amount of points to be modeled

s = linspace(0,total_banked_turn_length,fidelity); % array of discrete track lengths 

up_down_Gs = zeros(size(s));
lateral_Gs = zeros(size(s));

[x, y, z] = banked_turn_path(s, radius, banked_turn_origin(1), banked_turn_origin(2), banked_turn_origin(3), dir);

%v = cart.speed.*ones(1, length(s));
%scatter3(x, y, z, 20, G_banked_turn*ones(size(x)), 'filled'); % 20 is marker size


%% Create Figure with Subplots
figure(2);
hold on;
% Normal G-Force Plot
subplot(3,1,1);
plot(s, G_banked_turn*ones(size(s)), 'r', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Up / Down G');
title('Up / Down G-Force Along Banked Turn');
grid on;

% Lateral G-Force Plot
subplot(3,1,2);
plot(s, lateral_Gs, 'b', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Lateral G');
title('Lateral G-Force Along Banked Turn');
grid on;

% Up/Down G-Force Plot
subplot(3,1,3);
plot(s, up_down_Gs, 'g', 'LineWidth', 2);
xlabel('Path Length (s) [m]');
ylabel('Forward / Backwards G');
title('Forward / Backwards G-Force Along Banked Turn');
grid on;

% Adjust spacing between subplots
sgtitle('G-Forces Along Banked Turn'); % Overall title for the figure
hold off;

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

