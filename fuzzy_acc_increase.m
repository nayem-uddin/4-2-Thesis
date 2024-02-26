fi = mamfis;
%n=negative,z=zero,p=positive
fi = addInput(fi,[-10 10],'Name','dist_err');
fi = addMF(fi,'dist_err','trapmf',[-10 -10 -5 0],'Name','n');
fi = addMF(fi,'dist_err','trimf',[-5 0 5],'Name','z');
fi = addMF(fi,'dist_err','trapmf',[0 5 10 10],'Name','p');

fi = addInput(fi,[-50 50],'Name','rel_vel');
fi = addMF(fi,'rel_vel','trapmf',[-50 -50 -20 0],'Name','n');
fi = addMF(fi,'rel_vel','trimf',[-20 0 20],'Name','z');
fi = addMF(fi,'rel_vel','trapmf',[0 20 50 50],'Name','p');

fi = addInput(fi,[-10 10],'Name','speed_error');
fi = addMF(fi,'speed_error','trapmf',[-10 -10 -0.2 0],'Name','n');
fi = addMF(fi,'speed_error','trimf',[-2 0 2],'Name','z');
fi = addMF(fi,'speed_error','trapmf',[0 2 10 10],'Name','p');

fi= addInput(fi,[-0.2 0],'Name','ego_vel');
fi = addMF(fi,'ego_vel','trimf',[-0.2 0 0],'Name','z');

fi = addInput(fi,[-3 2],'Name','accel');
fi = addMF(fi,'accel','trapmf',[-3 -3 -1.5 -0.75],'Name','n_big');
fi = addMF(fi,'accel','trimf',[-1.5 -0.75 0],'Name','n_small');
fi = addMF(fi,'accel','trimf',[-0.75 0 0.5],'Name','z');
fi = addMF(fi,'accel','trimf',[0 0.5 1],'Name','p_small');
fi = addMF(fi,'accel','trapmf',[0.5 1 2 2],'Name','p_big');

fi = addOutput(fi,[0 2],'Name','acc');
fi = addMF(fi,'acc','trimf',[0 0.5 1],'Name','p_small');
fi = addMF(fi,'acc','trapmf',[0.5 1 2 2],'Name','p_big');
rules=[
    "ego_vel == z => acc = p_big";
    "dist_err == p & rel_vel== p & speed_error == p => acc = p_big";
    "dist_err == p & rel_vel== n & speed_error == p => acc = p_small";
    "dist_err == p & rel_vel== z & speed_error == p => acc = p_small";
    "dist_err == z & rel_vel== p & speed_error == p => acc= p_small";
    "accel == n_big => acc = p_big";
    "accel == n_small => acc = p_small";
    ];
fi.Rules=fisrule(rules);