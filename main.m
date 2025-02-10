%% This is our main code script for ASEN 2803 LAB 1

clear;
clc;
close all;


%% Initial Parameters

parameters = struct;

parameters.initial_h = 125; % meters
parameters.g = 9.81; % m/s^2
parameters.initial_v = 0; % m/s

parameters.orgin = [0, 0, parameters.initial_h];
parameters.feature_fid = 500;
parameters.trans_fid = 100;


%% Initialize Cart

cart_struct;


figure;
hold on;
xlabel("X Axis");
ylabel("Y Axis");
zlabel("Z Axis");

final_v = sqrt(2*parameters.g*parameters.initial_h);





%% Track Section 1:
% Our first section features a drop of 25 meters
pos_y = true;
transition_start = parameters.orgin;
drop_length = 25;

drop;



%% Transition 1:

transition_length = 5; % meters
concavity = true;
b = -1;
transition_start = [x(parameters.trans_fid), y(parameters.trans_fid), z(parameters.trans_fid)];
transition;


%% Track Section 2:
% Our second section of track features an idealy banked turn

banked_turn_origin = [x_vals(parameters.trans_fid),y_vals(parameters.trans_fid),z_vals(parameters.trans_fid)];
bank_angle_degs = 60;
cart.speed = sqrt(2*parameters.g*(parameters.initial_h - z_vals(parameters.trans_fid)))
banked_turn;

%% Transition 2:
transition_length = 5; % meters
concavity = false; % concave down
b = 0;
pos_y = false;

cart.speed = sqrt(2*parameters.g*(parameters.initial_h - z(parameters.feature_fid)))

transition_start = [x(parameters.feature_fid), y(parameters.feature_fid), z(parameters.feature_fid)];

transition;


%% Track Section 3:
% Our third section will feature another drop of 25 meters

transition_start = [x_vals(parameters.trans_fid),y_vals(parameters.trans_fid),z_vals(parameters.trans_fid)];
drop_length = 25;
drop;



%% Transition 3:
transition_length = 5; % meters
concavity = true; % concave down
pos_y = false;
b = 1;
cart.speed = sqrt(2*parameters.g*(parameters.initial_h - z(parameters.trans_fid)))

transition_start = [x(parameters.trans_fid), y(parameters.trans_fid), z(parameters.trans_fid)];

transition;





clim([0, final_v]);
colormap jet; % Choose a colormap
colorbar; % Display color bar

hold off;
