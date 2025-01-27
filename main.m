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


%% Track Section 1:
% Our first section features a drop of 25 meters 


%% Track Section 2:
% Our second section of track features an idealy banked turn
bank_angle_degs = 60;
cart.speed = 25;
banked_turn;


%% Track Section 3:
% Our third section will feature another drop of ... meters


