FIS = mamfis;
%n=negative,z=zero,p=positive
FIS = addInput(FIS,[-1 1],'Name','dist_err');
FIS = addMF(FIS,'dist_err','trapmf',[-1 -1 -0.3 0],'Name','n');
FIS = addMF(FIS,'dist_err','trimf',[-0.3 0 0.3],'Name','z');
FIS = addMF(FIS,'dist_err','trapmf',[0 0.3 1 1],'Name','p');

FIS = addInput(FIS,[-1 1],'Name','rel_vel');
FIS = addMF(FIS,'rel_vel','trapmf',[-1 -1 -0.3 0],'Name','n');
FIS = addMF(FIS,'rel_vel','trimf',[-0.3 0 0.3],'Name','z');
FIS = addMF(FIS,'rel_vel','trapmf',[0 0.3 1 1],'Name','p');

FIS = addInput(FIS,[-1 1],'Name','speed_error');
FIS = addMF(FIS,'speed_error','trapmf',[-1 -1 -0.4 0],'Name','n');
FIS = addMF(FIS,'speed_error','trimf',[-0.4 0 0.4],'Name','z');
FIS = addMF(FIS,'speed_error','trapmf',[0 0.4 1 1],'Name','p');

FIS = addOutput(FIS,[-3 2],'Name','accel');
FIS = addMF(FIS,'accel','trapmf',[-3 -3 -2 -1.5],'Name','n_big');
FIS = addMF(FIS,'accel','trimf',[-2 -1.25 -0.5],'Name','n_small');
FIS = addMF(FIS,'accel','trimf',[-0.5 0 0.75],'Name','z');
FIS = addMF(FIS,'accel','trimf',[0 0.75 1.5],'Name','p_small');
FIS = addMF(FIS,'accel','trapmf',[0.75 1.5 2 2],'Name','p_big');

rules=[
"dist_err == p => accel = p_small";
"dist_err == z => accel = z";
"dist_err == n => accel = n_big";
"rel_vel == n => accel = n_big";
"rel_vel == z => accel = z";
"rel_vel == p => accel = p_big";
"speed_error == n => accel = n_big";
"speed_error == z => accel = z";
"speed_error == p => accel = p_small";
];
FIS.Rules = fisrule(rules);