%% This section serves as a transition between track elements. It will serve to accelerate the cart further


x0 = transition_start(1);

y0 = transition_start(2);

z0 = transition_start(3);

ramp_angle = 40; % degrees
ramp_angle_rads = ramp_angle*(pi/180);

fidelity = 1000; % points

total_section_length = drop_length/sin(ramp_angle_rads);

s = linspace(0,total_section_length,fidelity);

[x, y, z] = drop_path(s, ramp_angle_rads, x0, y0, z0, pos_y);

plot3(x,y,z);

function [x,y,z] = drop_path(s, ramp_angle, x0, y0, z0, pos_y)

    x = x0*ones(length(s));
    
    if pos_y
        y = y0 + s*cos(ramp_angle);
    else
        y = y0 - s*cos(ramp_angle);
    end

    z = z0 - s*sin(ramp_angle);

end




