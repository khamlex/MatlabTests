bot_x = [];
bot_y = [];
bot_a = [];
accuracy = 800;
for i = 1:accuracy
    clf
    %h = figure(i);
    bot_x = [bot_x, SX(i*floor(length(SX)/accuracy))];
    bot_y = [bot_y, SY(i*floor(length(SX)/accuracy))];
    bot_a = [bot_a, SA(i*floor(length(SX)/accuracy))];
    plot(bot_x, bot_y, 'color', [0 0 1]);
    hold on
    draw_bot(bot_x(i), bot_y(i), bot_a(i), 80, 60, 40, 10);
    xlim([-500 600]);
    ylim([-500 600]);
    grid on
    set(gcf,'color','w', 'Position', [900, 00, 870, 800]);
    title('Test');
    xlabel('X');
    ylabel('Y');
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    %saveas(h,fullfile('X:\My Tests\GIF Data\Odometry2',[num2str(i) '.bmp']));
    %close(h);
end


function[] = draw_rectangle(center_location, L, H, W,Z, theta)
R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
dot_1 = [+H; -L];
dot_2 = [-H; -L];
dot_3 = [-H; +L];
dot_4 = [+H; +L];
dot_1 = R*dot_1;
dot_2 = R*dot_2;
dot_3 = R*dot_3;
dot_4 = R*dot_4;
wheel = [Z;W];
wheel = R*wheel;
dot_1 = dot_1 + center_location + wheel;
dot_2 = dot_2 + center_location + wheel;
dot_3 = dot_3 + center_location + wheel;
dot_4 = dot_4 + center_location + wheel;
plot([dot_1(1), dot_2(1)],[dot_1(2), dot_2(2)], 'color', [0 0 0]);
hold on
plot([dot_2(1), dot_3(1)],[dot_2(2), dot_3(2)], 'color', [0 0 0]);
hold on
plot([dot_3(1), dot_4(1)],[dot_3(2), dot_4(2)], 'color', [0 0 0]);
hold on
plot([dot_1(1), dot_4(1)],[dot_1(2), dot_4(2)], 'color', [0 0 0]);
hold on
end

function[] = draw_bot(X, Y, A, bot_x_val, bot_y_val, wheel_x_val, wheel_y_val)
draw_rectangle([X; Y], bot_y_val, bot_x_val, 0, 0, A);
draw_rectangle([X; Y], wheel_y_val, wheel_x_val, (bot_y_val + wheel_y_val), 0,  A);
draw_rectangle([X; Y], wheel_y_val, wheel_x_val, -(bot_y_val + wheel_y_val),0, A);
draw_rectangle([X; Y], bot_y_val, bot_x_val*0.1, 0, bot_x_val*0.9, A);
end



















