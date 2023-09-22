clc;clear;close all;

l=[0,0.1,0.2,0.3,0.5,1.0];
r=0:0.001:2.5;


for i=1:6
    %y=atan(2*l(i)*r./(1-r.^2))*180./pi;
    if(i==1)
        y=0.*(r<=1)+180.*(r>1);
    else
        y=(atan(2*l(i)*r./(1-r.^2))*180./pi).*(r<=1)+(atan(2*l(i)*r./(1-r.^2))*180./pi+180).*(r>1);
    end
    h_p=plot(r,y);
    h_a=gca;
    
    set(h_p,'LineWidth',1.7);
    set(h_a,'FontName','Times New Roman','FontSize',12,'FontWeight','bold');
    
    hold on;
    
end
% 
% for i=1:6
%     y=atan(2*l(i)*r./(1-r.^2))*180./pi+180;
%     plot(r,y);
%     
%     hold on;
% end

title("Phase",'FontName','Times New Roman','FontSize',12,'FontWeight','bold');
xlabel("Frequency Ratio r=f/fn");
ylabel("Phase Angle(deg)");
ylim([0 180]);
xlim([0 2.5]);
grid on;
legend("\xi=0","\xi=0.1","\xi=0.2","\xi=0.3","\xi=0.5","\xi=1");

