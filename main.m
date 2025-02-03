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


%% Initialize Cart

cart_struct;


figure;
hold on;
xlabel("X Axis");
ylabel("Y Axis");
zlabel("Z Axis");

%% Track Section 1:
% Our first section features a drop of 25 meters
pos_y = true;
transition_start = parameters.orgin;
drop_length = 25;
drop;



%% Transition 1:
transition_length = 5; % meters
concavity = true; % concave up
transition_start = [x(1000), y(1000), z(1000)];
transition;


%% Track Section 2:
% Our second section of track features an idealy banked turn

banked_turn_origin = [x_vals(100),y_vals(100),z_vals(100)];
bank_angle_degs = 60;
cart.speed = 25;
banked_turn;

%% Transition 2:
transition_length = 5; % meters
concavity = false; % concave down
pos_y = false;

transition_start = [x(1000), y(1000), z(1000)];
transition;

%% Track Section 3:
% Our third section will feature another drop of 25 meters

transition_start = [x_vals(100),y_vals(100),z_vals(100)];
drop_length = 25;
drop;

hold off;


