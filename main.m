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

%% Globals
drop_length = 25;
NUM_DROPS = 3;
drop_count = 1;
drops = struct;
drops.pos = zeros(NUM_DROPS, parameters.trans_fid, 3);
drops.gs = zeros(NUM_DROPS, parameters.trans_fid, 3);
drops.distance = zeros(NUM_DROPS, parameters.trans_fid);

NUM_TRANSITIONS = 8;
transitions = struct;
transitions.pos = zeros(NUM_TRANSITIONS, parameters.trans_fid, 3);
transitions.gs = zeros(NUM_TRANSITIONS, parameters.trans_fid, 3);
transitions.distance = zeros(NUM_TRANSITIONS, parameters.trans_fid);
transitions.g_total = zeros(NUM_TRANSITIONS, parameters.trans_fid);

NUM_BANKED_TURNS = 2;
banked_turn_count = 1;
banked_turns = struct;
banked_turns.pos = zeros(NUM_BANKED_TURNS, parameters.feature_fid, 3);
banked_turns.gs = zeros(NUM_BANKED_TURNS, parameters.feature_fid, 3);
banked_turns.distance = zeros(NUM_BANKED_TURNS, parameters.feature_fid);

%% Drop 1:
% Our first section features a drop of 25 meters
pos_y = true;
transition_start = parameters.orgin;
drop;
drops.pos(1, :, 1) = x_drop;
drops.pos(1, :, 2) = y_drop;
drops.pos(1, :, 3) = z_drop;

drops.gs(1, :, 1) = G_normal_drop;
drops.gs(1, :, 2) = G_lateral_drop;
drops.gs(1, :, 3) = G_forwardback_drop;

drops.distance(1, :) = s_drop;

s_drop_1 = s_drop;
drop_count = drop_count + 1;

%% Transition 1:
pos_y = true;
concavity = true;
transition_start = [x_drop(end), y_drop(end), z_drop(end)];
L = 15;
zf = z_drop(end) - L/2;
start_slope = -1;
end_slope = 0;
[transitions.pos(parameters.transition_count, :, 1), transitions.pos(parameters.transition_count, :, 2), transitions.pos(parameters.transition_count, :, 3), transitions.distance(parameters.transition_count, :), transitions.gs(parameters.transition_count, :, 1), transitions.gs(parameters.transition_count, :, 2), transitions.gs(parameters.transition_count, :, 3), transitions.g_total(parameters.transition_count, :)] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);

s_transition_1 = transitions.distance(1, :) + s_drop_1(end);

%% Banked Turn 1:
% Our second section of track features an idealy banked turn
dir = true;
bank_angle_degs = 65;
banked_turn_origin = [transitions.pos(parameters.transition_count - 1, end, 1), transitions.pos(parameters.transition_count - 1, end, 2), transitions.pos(parameters.transition_count - 1, end, 3)];
banked_turn;

banked_turns.pos(1, :, 1) = x_banked_turn;
banked_turns.pos(1, :, 2) = y_banked_turn;
banked_turns.pos(1, :, 3) = z_banked_turn;

banked_turns.gs(1, :, 1) = G_normal_banked_turn;
banked_turns.gs(1, :, 2) = G_lateral_banked_turn;
banked_turns.gs(1, :, 3) = G_forwardback_banked_turn;

banked_turns.distance(1, :) = s_banked_turn;

s_banked_turn_1 = banked_turns.distance(1, :) + s_transition_1(end);

banked_turn_count = banked_turn_count + 1;

%% Transition 2:
pos_y = false;
concavity = true;
transition_start = [x_banked_turn(end), y_banked_turn(end), z_banked_turn(end)];
L = 15;
zf = z_banked_turn(end) - L/2;
start_slope = 0;
end_slope = 1;
[transitions.pos(parameters.transition_count, :, 1), transitions.pos(parameters.transition_count, :, 2), transitions.pos(parameters.transition_count, :, 3), transitions.distance(parameters.transition_count, :), transitions.gs(parameters.transition_count, :, 1), transitions.gs(parameters.transition_count, :, 2), transitions.gs(parameters.transition_count, :, 3), transitions.g_total(parameters.transition_count, :)] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);

s_transition_2 = transitions.distance(2, :) + s_banked_turn_1(end);

%% Drop 2:
% Our third section will feature another drop of 25 meters

transition_start = [transitions.pos(parameters.transition_count - 1, end, 1), transitions.pos(parameters.transition_count - 1, end, 2), transitions.pos(parameters.transition_count - 1, end, 3)];
drop;
drops.pos(2, :, 1) = x_drop;
drops.pos(2, :, 2) = y_drop;
drops.pos(2, :, 3) = z_drop;

drops.gs(2, :, 1) = G_normal_drop;
drops.gs(2, :, 2) = G_lateral_drop;
drops.gs(2, :, 3) = G_forwardback_drop;

drops.distance(2, :) = s_drop;

s_drop_2 = s_drop + s_transition_2(end);

drop_count = drop_count + 1;

%% Transition 3:
pos_y = false;
concavity = true;
transition_start = [x_drop(end), y_drop(end), z_drop(end)];
L = 40;
zf = z_drop(end) - L/2;
start_slope = 1;
end_slope = 0;
[transitions.pos(parameters.transition_count, :, 1), transitions.pos(parameters.transition_count, :, 2), transitions.pos(parameters.transition_count, :, 3), transitions.distance(parameters.transition_count, :), transitions.gs(parameters.transition_count, :, 1), transitions.gs(parameters.transition_count, :, 2), transitions.gs(parameters.transition_count, :, 3), transitions.g_total(parameters.transition_count, :)] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);

s_transition_3 = transitions.distance(3, :) + s_drop_2(end);

%% Flat Section:
% x stays constant 
% z stays constant

flat_distance = 10;
y_flat = linspace(transitions.pos(parameters.transition_count - 1, end, 2), transitions.pos(parameters.transition_count - 1, end, 2) - flat_distance, parameters.trans_fid);
x_flat = ones(1,parameters.trans_fid) .* transitions.pos(parameters.transition_count - 1, end, 1);
z_flat = ones(1,parameters.trans_fid) .* transitions.pos(parameters.transition_count - 1, end, 3);

s_flat = linspace(0, flat_distance, parameters.trans_fid) + s_transition_3(end);

%% Transition 4:
pos_y = false;
concavity = true;
transition_start = [x_flat(end), y_flat(end), z_flat(end)];
L = 40;
zf = z_flat(end) +15;
start_slope = 0;
end_slope = -1;
[transitions.pos(parameters.transition_count, :, 1), transitions.pos(parameters.transition_count, :, 2), transitions.pos(parameters.transition_count, :, 3), transitions.distance(parameters.transition_count, :), transitions.gs(parameters.transition_count, :, 1), transitions.gs(parameters.transition_count, :, 2), transitions.gs(parameters.transition_count, :, 3), transitions.g_total(parameters.transition_count, :)] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);

s_transition_4 = transitions.distance(4, :) + s_flat(end);

%% Parabola:

parabola_start = [transitions.pos(parameters.transition_count - 1, end, 1), transitions.pos(parameters.transition_count - 1, end, 2), transitions.pos(parameters.transition_count - 1, end, 3)];
parabola;

s_parab_total = s_parab + s_transition_4(end);

%% Transition 5:
pos_y = false;
concavity = false;
transition_start = [x0_parab, y_parab(end), z_parab(end)];
L = 50;
zf = z_parab(end) + 5;
start_slope = -1;
end_slope = 0;
[transitions.pos(parameters.transition_count, :, 1), transitions.pos(parameters.transition_count, :, 2), transitions.pos(parameters.transition_count, :, 3), transitions.distance(parameters.transition_count, :), transitions.gs(parameters.transition_count, :, 1), transitions.gs(parameters.transition_count, :, 2), transitions.gs(parameters.transition_count, :, 3), transitions.g_total(parameters.transition_count, :)] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);

s_transition_5 = transitions.distance(5, :) + s_parab_total(end);

%% Banked Turn 2:
dir = false;
bank_angle_degs = 75;
banked_turn_origin = [transitions.pos(parameters.transition_count - 1, end, 1), transitions.pos(parameters.transition_count - 1, end, 2), transitions.pos(parameters.transition_count - 1, end, 3)];
banked_turn;

banked_turns.pos(2, :, 1) = x_banked_turn;
banked_turns.pos(2, :, 2) = y_banked_turn;
banked_turns.pos(2, :, 3) = z_banked_turn;

banked_turns.gs(2, :, 1) = G_normal_banked_turn;
banked_turns.gs(2, :, 2) = G_lateral_banked_turn;
banked_turns.gs(2, :, 3) = G_forwardback_banked_turn;

banked_turns.distance(2, :) = s_banked_turn;

s_banked_turn_2 = banked_turns.distance(2, :) + s_transition_5(end);

banked_turn_count = banked_turn_count + 1;

%% Transition 6:
pos_y = true;
concavity = true;
transition_start = [x_banked_turn(end), y_banked_turn(end), z_banked_turn(end)];
L = 25;
zf = z_banked_turn(end) - L/2;
start_slope = 0;
end_slope = -1;
[transitions.pos(parameters.transition_count, :, 1), transitions.pos(parameters.transition_count, :, 2), transitions.pos(parameters.transition_count, :, 3), transitions.distance(parameters.transition_count, :), transitions.gs(parameters.transition_count, :, 1), transitions.gs(parameters.transition_count, :, 2), transitions.gs(parameters.transition_count, :, 3), transitions.g_total(parameters.transition_count, :)] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);

s_transition_6 = transitions.distance(6, :) + s_banked_turn_2(end);

%% Drop 3:

pos_y = true;
transition_start = [transitions.pos(parameters.transition_count - 1, end, 1), transitions.pos(parameters.transition_count - 1, end, 2), transitions.pos(parameters.transition_count - 1, end, 3)];
drop;
drops.pos(3, :, 1) = x_drop;
drops.pos(3, :, 2) = y_drop;
drops.pos(3, :, 3) = z_drop;

drops.gs(3, :, 1) = G_normal_drop;
drops.gs(3, :, 2) = G_lateral_drop;
drops.gs(3, :, 3) = G_forwardback_drop;

drops.distance(3, :) = s_drop;

s_drop_3 = s_drop + s_transition_6(end);

drop_count = drop_count + 1;

%% Transition 7:
pos_y = true;
concavity = true;
transition_start = [x_drop(end), y_drop(end), z_drop(end)];
L = 100;
zf = z_drop(end) - 30;
start_slope = -1;
end_slope = 0;
[transitions.pos(parameters.transition_count, :, 1), transitions.pos(parameters.transition_count, :, 2), transitions.pos(parameters.transition_count, :, 3), transitions.distance(parameters.transition_count, :), transitions.gs(parameters.transition_count, :, 1), transitions.gs(parameters.transition_count, :, 2), transitions.gs(parameters.transition_count, :, 3), transitions.g_total(parameters.transition_count, :)] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);

s_transition_7 = transitions.distance(7, :) + s_drop_3(end);

%% Loop:

loop_start = [transitions.pos(parameters.transition_count - 1, end, 1), transitions.pos(parameters.transition_count - 1, end, 2), transitions.pos(parameters.transition_count - 1, end, 3)];
radius = 50;
loop;

s_loop_total = s_loop + s_transition_7(end);

%% Transition 8:
pos_y = true;
concavity = true;
transition_start = [x0_loop, y0_loop, z0_loop];
L = 100;
zf = 0;
start_slope = 0;
end_slope = 0;
[transitions.pos(parameters.transition_count, :, 1), transitions.pos(parameters.transition_count, :, 2), transitions.pos(parameters.transition_count, :, 3), transitions.distance(parameters.transition_count, :), transitions.gs(parameters.transition_count, :, 1), transitions.gs(parameters.transition_count, :, 2), transitions.gs(parameters.transition_count, :, 3), transitions.g_total(parameters.transition_count, :)] = compute_transition(pos_y, concavity, start_slope, end_slope, transition_start, L, zf, parameters.trans_fid, parameters);

s_transition_8 = transitions.distance(8, :) + s_loop_total(end);

%% Braking zone:

braking_length = 50; %meters

transition_start = [transitions.pos(parameters.transition_count - 1, end, 1), transitions.pos(parameters.transition_count - 1, end, 2), transitions.pos(parameters.transition_count - 1, end, 3)];

braking;

s_braking = y_braking + s_transition_8(end);

%% Graphs
plot_scatter;

s_total = [s_drop_1 s_transition_1 s_banked_turn_1 s_transition_2 s_drop_2 s_transition_3 s_flat s_transition_4 s_parab_total s_transition_5 s_banked_turn_2 s_transition_6 s_drop_3 s_transition_7 s_loop_total s_transition_8 s_braking];

g_total_normal = [drops.gs(1, :, 1) transitions.gs(1, :, 1) banked_turns.gs(1, :, 1) transitions.gs(2, :, 1) drops.gs(2, :, 1) transitions.gs(3, :, 1) ones(1, parameters.trans_fid) transitions.gs(4, :, 1) G_parab transitions.gs(5, :, 1) banked_turns.gs(2, :, 1) transitions.gs(6, :, 1) drops.gs(3, :, 1) transitions.gs(7, :, 1) G_loop transitions.gs(8, :, 1) G_normal_braking];

g_total_lateral = [drops.gs(1, :, 2) transitions.gs(1, :, 2) banked_turns.gs(1, :, 2) transitions.gs(2, :, 2) drops.gs(2, :, 2) transitions.gs(3, :, 2) zeros(1, parameters.trans_fid) transitions.gs(4, :, 2) zeros(1, parameters.feature_fid) transitions.gs(5, :, 2) banked_turns.gs(2, :, 2) transitions.gs(6, :, 2) drops.gs(3, :, 2) transitions.gs(7, :, 2) zeros(1, parameters.feature_fid) transitions.gs(8, :, 2) G_lateral_braking];

g_total_forwardback = [drops.gs(1, :, 3) transitions.gs(1, :, 3) banked_turns.gs(1, :, 3) transitions.gs(2, :, 3) drops.gs(2, :, 3) transitions.gs(3, :, 3) zeros(1, parameters.trans_fid) transitions.gs(4, :, 3) zeros(1, parameters.feature_fid) transitions.gs(5, :, 3) banked_turns.gs(2, :, 3) transitions.gs(6, :, 3) drops.gs(3, :, 3) transitions.gs(7, :, 3) zeros(1, parameters.feature_fid) transitions.gs(8, :, 3) G_forwardback_braking];

figure();
subplot(3, 1, 1);
plot(s_total, g_total_normal, 'LineWidth', 2);
title("Up / Down G-Force");
xlabel("Path Length (s) [m]");
ylabel("Up / Down G");
ylim([-1 7]);

subplot(3, 1, 2);
plot(s_total, g_total_lateral, 'LineWidth', 2);
title("Lateral G-Force");
xlabel("Path Length (s) [m]");
ylabel("Lateral G");

subplot(3, 1, 3);
plot(s_total, g_total_forwardback, 'LineWidth', 2);
title("Forward / Backward G-Force");
xlabel("Path Length (s) [m]");
ylabel("Forward / Backward G");
ylim([-3 5]);

sgtitle("G-Forces vs. Path Length");


%xlim([-200,0]);
%ylim([-350,100]);
%zlim([0,150]);

%clim([0, 6]);
%colormap jet; % Choose a colormap
%colorbar; % Display color bar
%hold off;