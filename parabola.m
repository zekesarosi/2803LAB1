function G_N_parabola = calculateParabolaGs(a, b, c, x, h_0)
    G_N_parabola = (4 * a * (h_0 - (a .* x.^2 + b .* x + c) ) ) ./ ( (4 * a^2 .* x.^2) + (4 * a * b .* x) + b^2 + 1).^1.5 + ( 1 ./ (sqrt( (2 * a .* x).^2 + 1 )));
end