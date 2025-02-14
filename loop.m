FIDELITY = parameters.feature_fid;
g = parameters.g;
h_0 = parameters.initial_h;
x0 = feature_start(1);
y0 = feature_start(2);
z0 = feature_start(3);


y_Q1 = y0 + radius * cos( linspace(0, pi / 2, FIDELITY / 4) );
y_Q2 = y0 + radius * cos( linspace(pi / 2, pi, FIDELITY / 4) );
y_Q3 = flip(y_Q2);
y_Q4 = flip(y_Q1);

y = [y_Q1 y_Q2 y_Q3 y_Q4];

z_Q1 = calculateCircleHeight(radius, y_Q1, y0, z0, 1);
z_Q2 = calculateCircleHeight(radius, y_Q2, y0, z0, 1);
z_Q3 = calculateCircleHeight(radius, y_Q3, y0, z0, -1);
z_Q4 = calculateCircleHeight(radius, y_Q4, y0, z0, -1);

z = [z_Q1 z_Q2 z_Q3 z_Q4];

G_Q1 = calculateLoopGs(radius, y_Q1, y0, z0, h_0, 1);
G_Q2 = calculateLoopGs(radius, y_Q2, y0, z0, h_0, 1);
G_Q3 = calculateLoopGs(radius, y_Q3, y0, z0, h_0, -1);
G_Q4 = calculateLoopGs(radius, y_Q4, y0, z0, h_0, -1);

G_loop = [G_Q1 G_Q2 G_Q3 G_Q4];

% calculate distance
s_loop = linspace(0, 2 * pi * radius, FIDELITY); % gives the same answer as for loop below
% s_loop = zeros(1, FIDELITY);
% for i=2:FIDELITY
%     s_loop(i) = calculateCircleDistance(radius, y(i), y(i - 1), y0, s_loop(i - 1));
% end

%scatter3(x0 * ones(size(y)), y, z, 20, abs(G_loop), "filled");
%xlabel("x");
%ylabel("y");
%zlabel("z");

function G_N_loop = calculateLoopGs(R, x, x_0, z_0, h_0, sign)
    G_N_loop = (2 * (h_0 - calculateCircleHeight(R, x, x_0, z_0, sign) ) ./ R) - sin( sign * acos((x - x_0) ./ R) );
end

function distance = calculateCircleDistance(R, x, x_prev, x_0, current_distance)
    y = sqrt(R^2 - (x - x_0)^2);
    y_prev = sqrt(R^2 - (x_prev - x_0)^2);
    distance = current_distance + sqrt( (x - x_prev)^2 + (y - y_prev)^2 ); 
end

function pos = calculateCircleHeight(R, x, x_0, h_0, sign)
    pos = sign * sqrt( R^2 - (x - x_0).^2 ) + R + h_0;
end