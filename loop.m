function G_N_loop = calculateLoopGs(R, x, x_0, h_0, sign)
    G_N_loop = (2 * ( h_0 - sign * sqrt(R^2 - (x - x_0).^2) ) ./ R) - sin( sign * acos((x - x_0) ./ R) );
end