function G_N_loop = calculateLoopGs(R, x, h_0, sign)
    G_N_loop = (2 * ( h_0 - sign * sqrt(R^2 - x.^2) ) ./ R) - sin( sign * acos(x ./ R) );
end