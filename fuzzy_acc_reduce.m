fr = mamfis;
%n=negative,z=zero,p=positive
fr = addInput(fr,[-10 10],'Name','dist_err');
fr = addMF(fr,'dist_err','trapmf',[-10 -10 -5 0],'Name','n');
fr = addMF(fr,'dist_err','trimf',[-5 0 5],'Name','z');
fr = addMF(fr,'dist_err','trapmf',[0 5 10 10],'Name','p');

fr = addInput(fr,[-50 50],'Name','rel_vel');
fr = addMF(fr,'rel_vel','trapmf',[-50 -50 -20 0],'Name','n');
fr = addMF(fr,'rel_vel','trimf',[-20 0 20],'Name','z');
fr = addMF(fr,'rel_vel','trapmf',[0 20 50 50],'Name','p');

fr = addInput(fr,[-10 10],'Name','speed_error');
fr = addMF(fr,'speed_error','trapmf',[-10 -10 -0.2 0],'Name','n');
fr = addMF(fr,'speed_error','trimf',[-2 0 2],'Name','z');
fr = addMF(fr,'speed_error','trapmf',[0 2 10 10],'Name','p');

fr= addInput(fr,[-0.2 0],'Name','ego_vel');
fr = addMF(fr,'ego_vel','trimf',[-0.2 0 0],'Name','z');

fr = addInput(fr,[-3 2],'Name','accel');
fr = addMF(fr,'accel','trapmf',[-3 -3 -1.5 -0.75],'Name','n_big');
fr = addMF(fr,'accel','trimf',[-1.5 -0.75 0],'Name','n_small');
fr = addMF(fr,'accel','trimf',[-0.75 0 0.5],'Name','z');
fr = addMF(fr,'accel','trimf',[0 0.5 1],'Name','p_small');
fr = addMF(fr,'accel','trapmf',[0.5 1 2 2],'Name','p_big');

fr = addOutput(fr,[-3 0.5],'Name','acc');
fr = addMF(fr,'acc','trapmf',[-3 -3 -1.5 -0.75],'Name','n_big');
fr = addMF(fr,'acc','trimf',[-1.5 -0.75 0],'Name','n_small');
fr = addMF(fr,'acc','trimf',[-0.75 0 0.5],'Name','z');

rules=[
    "dist_err == p & rel_vel== p & speed_error == n => acc = n_small";
    "dist_err == p & rel_vel== p & speed_error == z => acc = z";
    "dist_err == p & rel_vel== n & speed_error == n => acc = n_small";
    "dist_err == p & rel_vel== n & speed_error == z => acc = z";
    "dist_err == p & rel_vel== z & speed_error == n => acc = n_small";
"dist_err == p & rel_vel== z & speed_error == z => acc = z";
"dist_err == n & rel_vel== p & speed_error == p => acc = n_small";
"dist_err == n & rel_vel== p & speed_error == n => acc = n_small";
"dist_err == n & rel_vel== p & speed_error == z => acc = z";
"dist_err == n & rel_vel== n => acc = n_big";
"dist_err == n & rel_vel== p & speed_error == p => acc = z";
"dist_err == n & rel_vel== p & speed_error == n => acc = n_small";
"dist_err == n & rel_vel== p & speed_error == z => acc = z";
"dist_err == z & rel_vel== n => acc= n_big";
"dist_err == z & rel_vel== p & speed_error == n => acc= n_small";
"dist_err == z & rel_vel== z & speed_error == p => acc= z";
"dist_err == z & rel_vel== z & speed_error == z => acc= z";
"dist_err == z & rel_vel== z & speed_error == n => acc= n_big";
"accel == p_big => acc = n_big";
"accel == p_small => acc = n_small";
"accel == z => acc = z";
    ];
fr.Rules=fisrule(rules);