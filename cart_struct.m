cart = struct;

cart.speed = parameters.initial_v; % Initialize speed as our starting vel
% Note: Speed is based only on cart vertical position rel to starting
% height


cart.s = 0; % Initialize cart track length position as 0

cart.h = parameters.initial_h; 
cart.x = parameters.orgin(1);
cart.y = parameters.orgin(2);

cart.G = 0; % Initialize cart G's as 0