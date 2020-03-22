data = VarName1.';

global it_k;
global it_a;
global buff;
global it_triang;
global count;
global savitzky_weight;
global it_savitzky;
global it_my;
it_savitzky = 1;
count = 1;
it_triang = 1;
savitzky_weight = [1 2 2 2 1];
a_max = 0.5;
a_min = 0.01;
delta_min = 10;
delta_max = 100;
R_exp = 30;
x_n_min = 0;
x_n_max = 300;
y_n_min = 75;
y_n_max = 260;

%AxesLim = [5, 45, 70];
%AxesLim = [55, 105, 195];
for main_loop = 0:0%length(AxesLim)/5-1
    %x_g_min = AxesLim(main_loop*5+1);
    %x_g_max = AxesLim(main_loop*5+2);
    %y_g_min = AxesLim(main_loop*5+3);
    %y_g_max = AxesLim(main_loop*5+4);
    %iter_all = AxesLim(main_loop*5+5);
    x_g_min = x_n_min;
    x_g_max = x_n_max;
    y_g_min = y_n_min;
    y_g_max = y_n_max;
    iter_all = 1;
    
    for iter_now = 1:iter_all
        
        clf
        %h = figure(count);
        
        buff = [];
        it_a = 1;
        it_k = 0;
        it_my = 1;
        filtr_my = [];
        filtr_middle = [];
        filtr_my = [];
        filtr_triangular = [];
        filtr_exp = [];
        theta = (iter_all+1)/2-abs((iter_all+1)/2-iter_now);
        for i = 1:length(data)-1
            filtr_middle = [filtr_middle, middle(data(i), 5)];
            theta = 0.45;
        end
        theta = 0.45;
        for i = 1:length(data)-1
            filtr_exp = [filtr_exp, kalman(data(i), theta)];
            delta_k = abs(filtr_exp(i) - data(i+1));
            theta = (1/2+(abs(delta_k-delta_max)-abs(delta_k-delta_min))/(2*(delta_max-delta_min)))*(a_max - a_min)+ a_min;
        end
        it_k = 0;
        for i = 1:length(data)-1
            filtr_triangular = [filtr_triangular, triangular(data(i), 5)];
            delta_k = abs(filtr_triangular(i) - data(i+1));
            theta = (1-1/(1+exp(-(delta_k-R_exp))))*(a_max-a_min)+a_min;
        end
        it_k = 0;
        for i = 1:length(data)-1
            filtr_my = [filtr_my, savitzky(data(i), 5)];
        end
        X_d = 1:length(data);
        X_simple = 1:length(filtr_middle);
        X_abs = 1:length(filtr_exp);
        X_exp = 1:length(filtr_exp);
        
        plot(X_d.', data.', '-','Color', [0 0 0], 'LineWidth', 0.5)
        hold on
        plot(X_exp.', filtr_exp.', '-', 'Color', [0 0 1], 'LineWidth', 0.5)
        hold on
        plot(X_abs.', filtr_exp.', '-', 'Color', [0 0 1], 'LineWidth', 0.5)
        hold on
        plot(X_exp.', filtr_my.', '-', 'Color', [0 0 1], 'LineWidth', 0.5)
        
        x_m_min = x_n_min + sign(x_g_min - x_n_min)*abs(x_n_min - x_g_min)*iter_now/iter_all;
        x_m_max = x_n_max + sign(x_g_max - x_n_max)*abs(x_n_max - x_g_max)*iter_now/iter_all;
        y_m_min = y_n_min + sign(y_g_min - y_n_min)*abs(y_n_min - y_g_min)*iter_now/iter_all;
        y_m_max = y_n_max + sign(y_g_max - y_n_max)*abs(y_n_max - y_g_max)*iter_now/iter_all;
        set(gcf,'color','w', 'Position', [900, 00, 900, 700]);
        title(['Filters comparison']);
        xlabel('Iteration');
        ylabel('Value');
        legend({'Raw data','Moving average'},'Location','northwest','NumColumns',2)
        ylim([y_m_min y_m_max]);
        xlim([x_m_min x_m_max]);
        ax = gca;
        ax.XAxisLocation = 'origin';
        ax.YAxisLocation = 'origin';
        pause(0.01);
        saveas(h,fullfile('X:\GIF Data\Glob_compare',[num2str(main_loop*1000 + iter_now) '.bmp']));
        close(h);
    end
    x_n_min = x_g_min;
    x_n_max = x_g_max;
    y_n_min = y_g_min;
    y_n_max = y_g_max;
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

function filtr = triangular(sensor, len)
global triangular_buff;
global triangular_weight;
global it_triang;
if it_triang <= len
    triangular_weight(it_triang) = (len+1)/2 - abs(it_triang-(len+1)/2);
    triangular_buff(it_triang) = sensor;
    it_triang = it_triang + 1;
    filtr = sensor;
else
    for i = 1:len-1
        triangular_buff(i) = triangular_buff(i+1);
    end
    triangular_buff(len) = sensor;
    sum = 0;
    for j = 1:len
        sum = sum + triangular_buff(j)*triangular_weight(j);
    end
    filtr = sum/(len-(len-1)/2)^2;
    
end
end

function filtr = my(sensor, len)
global triangular_buff;
global it_my;
koef = 0;
if it_my <= len
    triangular_buff(it_my) = sensor;
    it_my = it_my + 1;
    filtr = sensor;
    
else
    for i = 1:len-1
        triangular_buff(i) = triangular_buff(i+1);
    end
    triangular_buff(len) = sensor;
    sum = 0;
    for j = 1:len
        sum = sum + triangular_buff(j)*j;
        koef = koef + j;
    end
    filtr = sum/koef;
    
end
end

function filtr = savitzky(sensor, len)
global savitzky_buff;
global savitzky_weight;
global it_savitzky;
if it_savitzky <= len
    savitzky_buff(it_savitzky) = sensor;
    it_savitzky = it_savitzky + 1;
    filtr = sensor;
else
    for i = 1:len-1
        savitzky_buff(i) = savitzky_buff(i+1);
    end
    savitzky_buff(len) = sensor;
    sum1 = 0;
    sum2 = 0;
    for j = 1:len
        sum1 = sum1 + savitzky_buff(j)*savitzky_weight(j);
        sum2 = sum2 + savitzky_weight(j);
    end
    disp(sum2);
    filtr = sum1/sum2;
    
end
end

function filtr = middle(sensor, len)
global buff;
global it_a;
if it_a <= len
    buff(it_a) = sensor;
    it_a = it_a + 1;
    filtr = sensor;
else
    for i = 1:len-1
        buff(i) = buff(i+1);
    end
    buff(len) = sensor;
    filtr = sum(buff)/len;
end
end
