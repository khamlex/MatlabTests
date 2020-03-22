
t = linspace(0, 2*pi,600);
x = 110+70*cos(t);
y = 130+60*sin(2*t);
z = 130+90*sin(t);
data_x = VarName1.';
data_y = VarName2.';
data_z = VarName3.';
count = 4;
colors = 6;
line = 5;
size = 18;
sizeplus = 0;
C = ones(count*colors ,3);

C(1, 1) = 32;
C(1, 2) = 6;
C(1, 3) = 14;

C(2, 1) = 6;
C(2, 2) = 16;
C(2, 3) = 13;

C(3, 1) = 6;
C(3, 2) = 10;
C(3, 3) = 35;

C(4, 1) = 41;
C(4, 2) = 20;
C(4, 3) = 14;

C(5, 1) = 6;
C(5, 2) = 5;
C(5, 3) = 11;

C(6, 1) = 50;
C(6, 2) = 40;
C(6, 3) = 60;

for i = 2:count
    for k = 1:colors
        for j = 1:3
            C(k+(i-1)*colors,j) = C(k,j) + 55*(rand - 0.5);
        end
    end
end


for k = 1:length(data_x)
    clf
    h = figure(k);
    set(gcf,'color','w', 'Position', [00, 00, 900, 700]);
    x_s = data_x(k);
    y_s = data_y(k);
    z_s = data_z(k);
    for i = 0:count-1
        plot3(C(1 + i*colors, 1), C(1 + i*colors, 2), C(1 + i*colors, 3), 'go', 'Color', 'red', 'LineWidth', line, 'MarkerSize', floor(1/(i+1))*sizeplus+size)
        hold on
        plot3(C(2 + i*colors, 1), C(2 + i*colors, 2), C(2 + i*colors, 3), 'go', 'Color', 'green', 'LineWidth', line, 'MarkerSize', floor(1/(i+1))*sizeplus+size)
        hold on
        plot3(C(3 + i*colors, 1), C(3 + i*colors, 2), C(3 + i*colors, 3), 'go', 'Color', 'blue', 'LineWidth', line, 'MarkerSize', floor(1/(i+1))*sizeplus+size)
        hold on
        plot3(C(4 + i*colors, 1), C(4 + i*colors, 2), C(4 + i*colors, 3), 'go', 'Color', 'yellow', 'LineWidth', line, 'MarkerSize', floor(1/(i+1))*sizeplus+size)
        hold on
        plot3(C(5 + i*colors, 1), C(5 + i*colors, 2), C(5 + i*colors, 3), 'go', 'Color', 'black', 'LineWidth', line, 'MarkerSize', floor(1/(i+1))*sizeplus+size)
        hold on
        plot3(C(6 + i*colors, 1), C(6 + i*colors, 2), C(6 + i*colors, 3), 'go', 'Color', [0.85 0.85 0.85], 'LineWidth', line, 'MarkerSize', floor(1/(i+1))*sizeplus+size)
        hold on
    end
    
    plot3(x_s, y_s, z_s, 'go', 'Color', 'black', 'LineWidth', 10, 'MarkerSize', 10)
    hold on
    
    for i = 1:colors
        plot3([x_s C(i, 1)], [y_s C(i, 2)], [z_s C(i, 3)], 'Color', 'black', 'LineWidth', 1);
        hold on
    end
    
    axis([0, 80, 0, 80, 0, 80]);
    grid on
    xlabel('RED', 'Color', [1 0 0])
    ylabel('GREEN', 'Color', [0 1 0])
    zlabel('BLUE', 'Color', [0 0 1])
    title('RGB Dimension')
    view([50+20*sin(k*2*pi/length(data_x)) 10])
    
    
    pause(0.001)
    saveas(h,fullfile('X:\RR\Line1',[num2str(k) '.bmp']));
    close(h)
    
end