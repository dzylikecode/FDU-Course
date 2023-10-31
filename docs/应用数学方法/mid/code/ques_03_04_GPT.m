mid4
%%
function mid4
    % 定义矩阵 A 和向量 b
    A = [-1, 1; -2, -2];
    b = [5; -1];

    % 定义时间步长和时间范围
    dt = 0.01;
    t = 0:dt:10;

    % 定义一组初始条件
    initial_conditions = [1.5,2,2.5,3,3,3,3,2.5,2,1.5,1.5,1.5;-1,-1,-1,-1,-2,-3,-4,-4,-4,-4,-3,-2]; % 每列是一组初始条件

    % 为每组初始条件绘制轨迹线
    figure; 
    hold on; 
    for j = 1:size(initial_conditions, 2)
        % 初始化向量 x
        x = zeros(2, length(t));
        x(:,1) = initial_conditions(:,j); 

        % 使用欧拉法迭代
        for i = 1:length(t)-1
            dxdt = A*x(:,i) + b;
            x(:,i+1) = x(:,i) + dxdt*dt;
        end

        % 绘制相轨线
        plot(x(1,:), x(2,:));
     % 添加箭头
        arrow_indices = 1:100:(length(t)-1); 
        scale_factor = 4; 
        for k = arrow_indices
            dx = (x(1,k+1)-x(1,k)) * scale_factor;
            dy = (x(2,k+1)-x(2,k)) * scale_factor;
            quiver(x(1,k), x(2,k), dx, dy, 0, 'MaxHeadSize', 10); 
        end
     end
        hold off;
        xlabel('x_1');
        ylabel('x_2');
        title('相轨线');
        grid on;
end