rollercoaster = figure();
xlabel("x");
ylabel("y");
zlabel("z");
title("The Best Rollercoaster Plot (G's)")
hold on;

% 20 is marker size
for i=1:NUM_DROPS
    scatter3(drops.pos(i, :, 1), drops.pos(i, :, 2), drops.pos(i, :, 3), 20, drops.gs(i, :, 1), 'filled'); 
end

for i=1:NUM_TRANSITIONS
    scatter3(transitions.pos(i, :, 1), transitions.pos(i, :, 2), transitions.pos(i, :, 3), 20, transitions.g_total(i, :), 'filled'); 
end

for i=1:NUM_BANKED_TURNS
    scatter3(banked_turns.pos(i, :, 1), banked_turns.pos(i, :, 2), banked_turns.pos(i, :, 3), 20, banked_turns.gs(i, :, 1), 'filled'); 
end

scatter3(x_flat, y_flat, z_flat, 20, ones(1, parameters.trans_fid), 'filled');
scatter3(x0_loop * ones(size(y_loop)), y_loop, z_loop, 20, abs(G_loop), "filled");
scatter3(x0_parab * ones(size(y_parab)), y_parab, z_parab, 20, G_parab, 'filled');
scatter3(x_braking, y_braking, z_braking, 20, G_total_braking, 'filled');

colorbar;
clim([-1 6]);
saveas(gcf, "Rollercoaster_scatter.png");
