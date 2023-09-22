clc;clear;close all;

l=[0,0.1,0.2,0.3,0.5,1.0];
r=0:0.01:2.5;

for i=1:6
    y=1./sqrt((1-r.^2).^2+(2*l(i)*r).^2);

    h_p=plot(r,y);
    h_a=gca;
    
    set(h_p,'LineWidth',1.7);
    set(h_a,'FontName','Times New Roman','FontSize',12,'FontWeight','bold');
    
    hold on;
    
end

title("Amplitude",'FontName','Times New Roman','FontSize',12,'FontWeight','bold');
xlabel("Frequency Ratio r=f/fn");
ylabel("Amplitude Ratio X*k/F");
ylim([0 5]);
xlim([0 2.5]);
grid on;
legend("\xi=0","\xi=0.1","\xi=0.2","\xi=0.3","\xi=0.5","\xi=1");

