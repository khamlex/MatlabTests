bot_x = [];
bot_y = [];
bot_a = [];
data_l = ML_8;
data_r = MR_8;
r = 43;
B = 160;
for i = 1:1
    clf
    %h = figure(i);
    
    theta = 1;
    for k = 2:length(data_l)
        data_l(k) = data_l(k-1)*(1-theta) + data_l(k)*theta;
    end
    
    for k = 2:length(data_r)
        data_r(k) = data_r(k-1)*(1-theta) + data_r(k)*theta;
    end
    
    bot_a = [bot_a; (data_r(1) - data_l(1))*pi/180*r/B];
    bot_x = [bot_x; 0];
    bot_y = [bot_y; 0];
    
    for k = 2:length(data_l)
        bot_a = [bot_a; bot_a(k-1) + (data_r(k)-data_l(k))*pi/180*r/B];
    end
    
    bot_a_old = bot_a;
    theta = 0.6;
    for k = 2:length(bot_a)
        bot_a(k) = bot_a(k-1)*(1-theta) + bot_a(k)*theta;
    end
    
    for k = 2:length(data_l)
        bot_x = [bot_x; bot_x(k-1) + (data_r(k)+data_l(k))*cos(bot_a(k))*r*pi/180];
        bot_y = [bot_y; bot_y(k-1) + (data_r(k)+data_l(k))*sin(bot_a(k))*r*pi/180];
    end
    
    plot(bot_x, bot_y, 'color', [0 0 0]);
    hold on
    for k = 1:length(data_l)
        bot_y(k) = bot_y(k) - k*bot_y(length(bot_y))/length(bot_y);
    end
    
    plot(bot_x, bot_y, 'color', [0 0 1]);
    grid on
    set(gcf,'color','w', 'Position', [760, 0, 1160, 1000]);
    title('Test');
    xlabel('X');
    ylabel('Y');
    ax = gca;
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    %saveas(h,fullfile('X:\My Tests\GIF Data\Odometry2',[num2str(i) '.bmp']));
    %close(h);
end

function filtr = kalman(sensor, alfa)
global kalman_buff;
global it_k;
if it_k == 0
    kalman_buff = sensor;
    it_k = 1;
else
    kalman_buff = alfa*sensor + (1 - alfa)*kalman_buff;
end
filtr = kalman_buff;
end