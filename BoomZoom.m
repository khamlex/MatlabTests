iter_all = 200;
x_n_min = 0;
x_n_max = 300;
x_g_min = 150;
x_g_max = 200;
y_n_min = 0;
y_n_max = 300;
y_g_min = 150;
y_g_max = 200;
for iter_now = 1:iter_all
    clf
    %h = figure(k);
    plot(X_abs.', exp_abs.', 'Color', [0 0 1], 'LineWidth', 0.5);
    x_m_min = x_n_min + sign(x_g_min - x_n_min)*abs(x_n_min - x_g_min)*iter_now/iter_all;
    x_m_max = x_n_max + sign(x_g_max - x_n_max)*abs(x_n_max - x_g_max)*iter_now/iter_all;
    y_m_min = y_n_min + sign(y_g_min - y_n_min)*abs(y_n_min - y_g_min)*iter_now/iter_all;
    y_m_max = y_n_max + sign(y_g_max - y_n_max)*abs(y_n_max - y_g_max)*iter_now/iter_all;
    set(gcf,'color','w', 'Position', [900, 00, 900, 700]);
    title(['Relay controller']);
    xlabel('Time');
    ylabel('Angle');
    ylim([y_m_min y_m_max]);
    xlim([x_m_min x_m_max]);
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    pause(0.0001);
    %saveas(h,fullfile('X:\RR theory\GIF Data',[num2str(k) '.bmp']));
    %close(h);
end
