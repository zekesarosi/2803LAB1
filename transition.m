%% Here we are using cubic geometry to create smooth transitions between sections

transition_length = 5; %meters

fidelity = 100;

x_trans = linspace(transition_start(1), banked_turn_origin(1), 100);
y_trans = linspace(transition_start(2), banked_turn_origin(2), 100);
z_trans = transition_start(3) - drop_length + (banked_turn_origin(3) - (transition_start(3) - drop_length)) * (3*t.^2 - 2*t.^3); 



