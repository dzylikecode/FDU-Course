wpts = [0 1 1 0; 0 0 2 2];
tpts = [0 1 2 3];
numsamples = 100;
[q,qd,qdd,qddd,qdddd,pp,timepoints,tsamples] = minsnappolytraj(wpts,tpts,numsamples, "TimeAllocation", false);
plot(tsamples,q)
hold on
plot(timepoints,wpts,'x')
xlabel('t')
ylabel('Positions')
legend('X-positions','Y-positions')
hold off
figure
plot(q(1,:),q(2,:),'.b',wpts(1,:),wpts(2,:),'or')
xlabel('X')
ylabel('Y')
hold on;
[q, ~] = minsnappolytraj(wpts,tpts,numsamples, "TimeAllocation", true);
plot(q(1,:),q(2,:),'.g')