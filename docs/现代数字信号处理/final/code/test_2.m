Fpass = 0.37; 
Fstop = 0.43;
Ap = 1;
Ast = 30;

d = designfilt('lowpassfir','PassbandFrequency',Fpass,...
  'StopbandFrequency',Fstop,'PassbandRipple',Ap,'StopbandAttenuation',Ast);
hfvt = fvtool(d);