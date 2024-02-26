fisr = mamfis;
%n=negative,z=zero,p=positive
fisr = addInput(fisr,[-50 50],'Name','Range_Err');
fisr = addMF(fisr,'Range_Err','trapmf',[-50 -50 -20 0],'Name','Negative');
fisr = addMF(fisr,'Range_Err','trimf',[-20 0 20],'Name','Zero');
fisr = addMF(fisr,'Range_Err','trapmf',[0 20 50 50],'Name','Positive');

fisr = addInput(fisr,[-1 1],'Name','Range_Err_Rate');
fisr = addMF(fisr,'Range_Err_Rate','trapmf',[-1 -1 -0.3 0],'Name','Negative');
fisr = addMF(fisr,'Range_Err_Rate','trimf',[-0.3 0 0.3],'Name','Zero');
fisr = addMF(fisr,'Range_Err_Rate','trapmf',[0 0.3 1 1],'Name','Positive');

fisr = addInput(fisr,[-1 1],'Name','Speed_Err');
fisr = addMF(fisr,'Speed_Err','trapmf',[-1 -1 -0.2 0],'Name','Negative');
fisr = addMF(fisr,'Speed_Err','trimf',[-0.2 0 0.2],'Name','Zero');
fisr = addMF(fisr,'Speed_Err','trapmf',[0 0.2 1 1],'Name','Positive');

fisr = addInput(fisr,[-3 2],'Name','Acceleration');
fisr = addMF(fisr,'Acceleration','trapmf',[-3 -3 -1.5 -0.75],'Name','Negative_Big');
fisr = addMF(fisr,'Acceleration','trimf',[-1.5 -0.75 0],'Name','Negative_Small');
fisr = addMF(fisr,'Acceleration','trimf',[-0.75 0 0.5],'Name','Zero');
fisr = addMF(fisr,'Acceleration','trimf',[0 0.5 1],'Name','Positive_Small');
fisr = addMF(fisr,'Acceleration','trapmf',[0.5 1 2 2],'Name','Positive_Big');

fisr = addOutput(fisr,[-3 2],'Name','Desired_Acceleration');
fisr = addMF(fisr,'Desired_Acceleration','trapmf',[-3 -3 -1.5 -0.75],'Name','Negative_Big');
fisr = addMF(fisr,'Desired_Acceleration','trimf',[-1.5 -0.75 0],'Name','Negative_Small');
fisr = addMF(fisr,'Desired_Acceleration','trimf',[-0.75 0 0.5],'Name','Zero');
fisr = addMF(fisr,'Desired_Acceleration','trimf',[0 0.5 1],'Name','Positive_Small');
fisr = addMF(fisr,'Desired_Acceleration','trapmf',[0.5 1 2 2],'Name','Positive_Big');

rules=[
    "IF Range_Err is Negative and Range_Err_Rate is Negative and Speed_Err is Negative, THEN Desired_Acceleration is Negative_Big";
    "IF Range_Err is Zero and Range_Err_Rate is Negative and Speed_Err is Negative, THEN Desired_Acceleration is Negative_Small";
    "IF Range_Err is Negative and Range_Err_Rate is Zero and Speed_Err is Negative, THEN Desired_Acceleration is Negative_Small";
    "IF Range_Err is Zero and Range_Err_Rate is Zero and Speed_Err is Negative, THEN Desired_Acceleration is Zero";
    "IF Speed_Err is Positive, THEN Desired_Acceleration is Negative_Small";
    %"IF Acceleration is Zero, THEN Desired_Acceleration is Zero";
    %"IF Acceleration is Positive_Small, THEN Desired_Acceleration is Negative_Small";
    %"IF Acceleration is Positive_Big, THEN Desired_Acceleration is Negative_Big";
    %"IF Acceleration is Negative_Big, THEN Desired_Acceleration is Positive_Big";
    %"IF Acceleration is Negative_Small, THEN Desired_Acceleration is Positive_Small";
    ];
fisr.Rules=fisrule(rules);