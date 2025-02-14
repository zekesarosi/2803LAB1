%% This is our main code script for ASEN 2803 LAB 1

clear;
clc;
close all;


%% Initial Parameters
global parameters;

parameters = struct;

parameters.initial_h = 125; % meters
parameters.g = 9.81; % m/s^2
parameters.initial_v = 0; % m/s

parameters.orgin = [0, 0, parameters.initial_h];
parameters.feature_fid = 200;
parameters.trans_fid = 50;

parameters.transition_count = 1;
parameters.path_length = 0;

%% Initialize Cart

cart_struct;
%figure(1);
%hold("on");
%xlabel("X Axis");
%ylabel("Y Axis");
%zlabel("Z Axis");
%hold("off");
final_v = sqrt(2*parameters.g*parameters.initial_h);


total_path_length = 0;


%% Track Section 1:
% Our first section features a drop of 25 meters
pos_y = true;
transition_start = parameters.orgin;
drop_length = 25;

drop;



%% Transition 1:
pos_y = true;
concavity = true;
transition_start = [x(end), y(end), z(end)];
L = 15;
zf = z(end) - L/2;
start_slope = -1;
end_slope = 0;
[x_vals, y_vals, z_vals] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);


%% Track Section 2:
% Our second section of track features an idealy banked turn
dir = true;
banked_turn_origin = [x_vals(parameters.trans_fid),y_vals(parameters.trans_fid),z_vals(parameters.trans_fid)];
bank_angle_degs = 60;
banked_turn;

%% Transition 2:
pos_y = false;
concavity = true;
transition_start = [x(end), y(end), z(end)];
L = 15;
zf = z(end) - L/2;
start_slope = 0;
end_slope = 1;
[x_vals, y_vals, z_vals] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);

%% Track Section 3:
% Our third section will feature another drop of 25 meters

transition_start = [x_vals(parameters.trans_fid),y_vals(parameters.trans_fid),z_vals(parameters.trans_fid)];
drop_length = 25;
drop;



%% Transition 3:
pos_y = false;
concavity = true;
transition_start = [x(end), y(end), z(end)];
L = 40;
zf = z(end) - L/2;
start_slope = 1;
end_slope = 0;
[x_vals, y_vals, z_vals] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);

%% Flat Section:
% x stays constant 
% z stays constant

length = 10;

y = linspace(y_vals(end), y_vals(end)-length, parameters.trans_fid);

x = ones(1,parameters.trans_fid).*x_vals(end);
z = ones(1,parameters.trans_fid).*z_vals(end);

scatter3(x,y,z, 20, zeros(1,parameters.trans_fid), 'filled');


%% Transition 4:
pos_y = false;
concavity = true;
transition_start = [x(end), y(end), z(end)];
L = 40;
zf = z(end) +15;
start_slope = 0;
end_slope = -1;
[x_vals, y_vals, z_vals] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);



%% Parabola:

transition_start = [x_vals(parameters.trans_fid),y_vals(parameters.trans_fid),z_vals(parameters.trans_fid)];
parabola;




%% Transition 5:
pos_y = false;
concavity = false;
transition_start = [x(end), y(end), z(end)];
L = 50;
zf = z(end) + 5;
start_slope = -1;
end_slope = 0;
[x_vals, y_vals, z_vals] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);


%% Banked Turn 2:
dir = false;
banked_turn_origin = [x_vals(parameters.trans_fid),y_vals(parameters.trans_fid),z_vals(parameters.trans_fid)];
bank_angle_degs = 60;
banked_turn;

%% Transition 6:
pos_y = true;
concavity = true;
transition_start = [x(end), y(end), z(end)];
L = 25;
zf = z(end) - L/2;
start_slope = 0;
end_slope = -1;
[x_vals, y_vals, z_vals] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);


%% Drop 3:

pos_y = true;
transition_start = [x_vals(parameters.trans_fid),y_vals(parameters.trans_fid),z_vals(parameters.trans_fid)];
drop_length = 25;

drop;

%% Transition 7:
pos_y = true;
concavity = true;
transition_start = [x(end), y(end), z(end)];
L = 100;
zf = z(end) - 30;
start_slope = -1;
end_slope = 0;
[x_vals, y_vals, z_vals] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);


%% Loop:

feature_start = [x_vals(end), y_vals(end), z_vals(end)];
radius = 58;
loop;

%% Transition 8:
pos_y = true;
concavity = true;
transition_start = [x_vals(end), y_vals(end), z_vals(end)];
L = 100;
zf = 0;
start_slope = 0;
end_slope = 0;
[x_vals, y_vals, z_vals] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);


%% Braking zone:

length = 50; %meters

transition_start = [x_vals(end), y_vals(end), z_vals(end)];

braking;



%xlim([-200,0]);
%ylim([-350,100]);
%zlim([0,150]);

%clim([0, 6]);
%colormap jet; % Choose a colormap
%colorbar; % Display color bar
%hold off;