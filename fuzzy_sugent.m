FIS = sugfis;
%n=negative,z=zero,p=positive
FIS = addInput(FIS,[-0.3 0.3],'Name','dist_err');
FIS = addMF(FIS,'dist_err','trimf',[-1 -0.3 0],'Name','n');
FIS = addMF(FIS,'dist_err','trimf',[-0.3 0 0.3],'Name','z');
FIS = addMF(FIS,'dist_err','trimf',[0 0.3 1],'Name','p');
FIS = addInput(FIS,[-0.3 0.3],'Name','rel_vel');
FIS = addMF(FIS,'rel_vel','trimf',[-1 -0.3 0],'Name','n');
FIS = addMF(FIS,'rel_vel','trimf',[-0.3 0 0.3],'Name','z');
FIS = addMF(FIS,'rel_vel','trimf',[0 0.3 1],'Name','p');
FIS = addInput(FIS,[-0.2 0.2],'Name','speed_error');
FIS = addMF(FIS,'speed_error','trimf',[-1 -0.2 0],'Name','n');
FIS = addMF(FIS,'speed_error','trimf',[-0.2 0 0.2],'Name','z');
FIS = addMF(FIS,'speed_error','trimf',[0 0.2 1],'Name','p');
FIS = addOutput(FIS,[-3 2],'Name','acc');
FIS = addMF(FIS,'acc','constant',-3,'Name','n_big');
FIS = addMF(FIS,'acc','constant',-1.5,'Name','n_small');
FIS = addMF(FIS,'acc','constant',0,'Name','z');
FIS = addMF(FIS,'acc','constant',1,'Name','p_small');
FIS = addMF(FIS,'acc','constant',2,'Name','p_big');
rule1="dist_err == n & rel_vel == n & speed_error == n => acc = n_big";
rule2="dist_err == z & rel_vel == n & speed_error == n => acc = n_small";
rule3="dist_err == n & rel_vel == z & speed_error == n => acc = n_small";
rule4="dist_err == z & rel_vel == z & speed_error == n => acc = z";
rule5="dist_err == p & rel_vel == z & speed_error == n => acc = p_small";

rules = [rule1 rule2 rule3 rule4 rule5];
FIS.Rules = fisrule(rules);