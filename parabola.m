FIDELITY = parameters.feature_fid;
g = parameters.g;
h_0 = parameters.initial_h;
x0 = transition_start(1);
y0 = transition_start(2);
z0 = transition_start(3);
v0 = sqrt(2 * g * (h_0 - z0));
launch_angle = pi/8;
yf = z0;

y = linspace(y0, yf, FIDELITY);
delta_y = (yf - y0) / FIDELITY;

% for zero g parabola
a = -1 / (4 * (h_0 - z0) * ( cos(launch_angle) )^2);
b = tan(launch_angle);
c = z0;

Gs = calculateParabolaGs(a, b, c, y, y0, h_0);
z = a * y.^2 + b * y + c;
s = zeros(1, FIDELITY);
for i=2:FIDELITY
    s(i) = calculateParabolaDistance(a, b, c, y(i), delta_y, s(i - 1));
end
v = sqrt(2 * g * (h_0 - z));

scatter3(x0 * ones(1, FIDELITY), y, z, 20, v, 'filled');
xlabel("x");
ylabel("y");
zlabel("z");

function G_N_parabola = calculateParabolaGs(a, b, c, x, x_0, h_0)
    G_N_parabola = ( 4 * a * (h_0 - c) + b^2 + 1 ) ./ ( ( 4 * a^2 .* (x - x_0).^2 ) + ( 4 * a * b .* (x - x_0) ) + b^2 + 1).^1.5;
end

function distance = calculateParabolaDistance(a, b, c, x, delta_x, current_distance)
    y = a * x^2 + b * x + c;
    y_prev = a * (x - delta_x)^2 + b * (x - delta_x) + c;
    delta_y = abs(y - y_prev);
    distance = current_distance + sqrt(delta_x^2 + delta_y^2); 
end