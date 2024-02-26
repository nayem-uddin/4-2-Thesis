fisi = sugfis;
%n=negative,z=zero,p=positive
fisi = addInput(fisi,[-50 50],'Name','Range_Err');
fisi = addMF(fisi,'Range_Err','trapmf',[-50 -50 -20 0],'Name','Negative');
fisi = addMF(fisi,'Range_Err','trimf',[-20 0 20],'Name','Zero');
fisi = addMF(fisi,'Range_Err','trapmf',[0 20 50 50],'Name','Positive');

fisi = addInput(fisi,[-1 1],'Name','Range_Err_Rate');
fisi = addMF(fisi,'Range_Err_Rate','trapmf',[-1 -1 -0.3 0],'Name','Negative');
fisi = addMF(fisi,'Range_Err_Rate','trimf',[-0.3 0 0.3],'Name','Zero');
fisi = addMF(fisi,'Range_Err_Rate','trapmf',[0 0.3 1 1],'Name','Positive');

fisi = addInput(fisi,[-1 1],'Name','Speed_Err');
fisi = addMF(fisi,'Speed_Err','trapmf',[-1 -1 -0.2 0],'Name','Negative');
fisi = addMF(fisi,'Speed_Err','trimf',[-0.2 0 0.2],'Name','Zero');
fisi = addMF(fisi,'Speed_Err','trapmf',[0 0.2 1 1],'Name','Positive');

fisi = addInput(fisi,[-1 1],'Name','Acceleration');
fisi = addMF(fisi,'Acceleration','trapmf',[-1 -1 -0.4 -0.2],'Name','Negative_Big');
fisi = addMF(fisi,'Acceleration','trimf',[-0.4 -0.2 0],'Name','Negative_Small');
fisi = addMF(fisi,'Acceleration','trimf',[-0.2 0 0.2],'Name','Zero');
fisi = addMF(fisi,'Acceleration','trimf',[0 0.2 0.4],'Name','Positive_Small');
fisi = addMF(fisi,'Acceleration','trapmf',[0.2 0.4 1 1],'Name','Positive_Big');

fisi = addOutput(fisi,[0 2],'Name','Desired_Acceleration');
%fisi = addMF(fisi,'Desired_Acceleration','trapmf',[-1 -1 -0.4 -0.2],'Name','Negative_Big');
%fisi = addMF(fisi,'Desired_Acceleration','trimf',[-0.4 -0.2 0],'Name','Negative_Small');
%fisi = addMF(fisi,'Desired_Acceleration','trimf',[-0.2 0 0.2],'Name','Zero');
fisi = addMF(fisi,'Desired_Acceleration','constant',0.75,'Name','Positive_Small');
fisi = addMF(fisi,'Desired_Acceleration','constant',2,'Name','Positive_Big');

rules=[
    "IF Range_Err is Positive and Range_Err_Rate is Zero and Speed_Err is Negative, THEN Desired_Acceleration is Positive_Small";
    "IF Range_Err is Zero and Range_Err_Rate is Positive and Speed_Err is Negative, THEN Desired_Acceleration is Positive_Small";
    "IF Range_Err is Positive and Range_Err_Rate is Negative and Speed_Err is Negative, THEN Desired_Acceleration is Positive_Big";
    "IF Speed_Err is Positive and Range_Err is Positive, THEN Desired_Acceleration is Positive_Small";
    %"IF Acceleration is Negative_Big, THEN Desired_Acceleration is Positive_Big";
    %"IF Acceleration is Negative_Small, THEN Desired_Acceleration is Positive_Small";
    ];
fisi.Rules=fisrule(rules);