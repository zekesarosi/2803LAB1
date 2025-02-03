%% Banked turn script


bank_angle_rads = bank_angle_degs * (pi/180);
radius = (cart.speed^2)*(cot(bank_angle_rads))/(parameters.g); % In meters



% Total track length since banked turn is a half circle

total_banked_turn_length = radius*pi;

G_banked_turn = 1/cos(bank_angle_rads);

fidelity = 1000; % amount of points to be modeled

s = linspace(0,total_banked_turn_length,fidelity); % array of discrete track lengths 

[x, y, z] = banked_turn_path(s, radius, banked_turn_origin(1), banked_turn_origin(2), banked_turn_origin(3));

plot3(x,y,z)


function [x, y, z] = banked_turn_path(s, radius, x0, y0, z0)
   

    % Function to compute the x, y coordinates of a banked turn
    % s      - Track length along the arc 
    % radius - Radius of the circular turn
    % x0, y0 - Starting coordinates of the turn
    
    % Compute the angle theta as a function of s
    theta = s / radius; % Angular position in radians
    
    % Parametric equations for x and y
    x = (x0 + radius * cos(theta)) - radius;
    y = y0 + radius * sin(theta);

    z = z0 * ones(length(s));


end

