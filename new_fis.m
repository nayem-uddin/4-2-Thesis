fis = mamfis;
%n=negative,z=zero,p=positive
fis = addInput(fis,[-1 1],'Name','Range_Err');
fis = addMF(fis,'Range_Err','trapmf',[-1 -1 -0.3 0],'Name','Negative');
fis = addMF(fis,'Range_Err','trimf',[-0.3 0 0.3],'Name','Zero');
fis = addMF(fis,'Range_Err','trapmf',[0 0.3 1 1],'Name','Positive');

fis = addInput(fis,[-1 1],'Name','Range_Err_Rate');
fis = addMF(fis,'Range_Err_Rate','trapmf',[-1 -1 -0.3 0],'Name','Negative');
fis = addMF(fis,'Range_Err_Rate','trimf',[-0.3 0 0.3],'Name','Zero');
fis = addMF(fis,'Range_Err_Rate','trapmf',[0 0.3 1 1],'Name','Positive');

fis = addInput(fis,[-1 1],'Name','Speed_Err');
fis = addMF(fis,'Speed_Err','trapmf',[-1 -1 -0.2 0],'Name','Negative');
fis = addMF(fis,'Speed_Err','trimf',[-0.2 0 0.2],'Name','Zero');
fis = addMF(fis,'Speed_Err','trapmf',[0 0.2 1 1],'Name','Positive');

fis = addInput(fis,[-1 1],'Name','Acceleration');
fis = addMF(fis,'Acceleration','trapmf',[-1 -1 -0.4 -0.2],'Name','Negative_Big');
fis = addMF(fis,'Acceleration','trimf',[-0.4 -0.2 0],'Name','Negative_Small');
fis = addMF(fis,'Acceleration','trimf',[-0.2 0 0.2],'Name','Zero');
fis = addMF(fis,'Acceleration','trimf',[0 0.2 0.4],'Name','Positive_Small');
fis = addMF(fis,'Acceleration','trapmf',[0.2 0.4 1 1],'Name','Positive_Big');

fis = addOutput(fis,[-1 1],'Name','Desired_Acceleration');
fis = addMF(fis,'Desired_Acceleration','trapmf',[-1 -1 -0.4 -0.2],'Name','Negative_Big');
fis = addMF(fis,'Desired_Acceleration','trimf',[-0.4 -0.2 0],'Name','Negative_Small');
fis = addMF(fis,'Desired_Acceleration','trimf',[-0.2 0 0.2],'Name','Zero');
fis = addMF(fis,'Desired_Acceleration','trimf',[0 0.2 0.4],'Name','Positive_Small');
fis = addMF(fis,'Desired_Acceleration','trapmf',[0.2 0.4 1 1],'Name','Positive_Big');

rules=[
    "IF Range_Err is Negative and Range_Err_Rate is Negative and Speed_Err is Negative, THEN Desired_Acceleration is Negative_Big";
    "IF Range_Err is Zero and Range_Err_Rate is Negative and Speed_Err is Negative, THEN Desired_Acceleration is Negative_Small";
    "IF Range_Err is Negative and Range_Err_Rate is Zero and Speed_Err is Negative, THEN Desired_Acceleration is Negative_Small";
    "IF Range_Err is Zero and Range_Err_Rate is Zero and Speed_Err is Negative, THEN Desired_Acceleration is Zero";
    "IF Range_Err is Positive and Range_Err_Rate is Zero and Speed_Err is Negative, THEN Desired_Acceleration is Positive_Small";
    "IF Range_Err is Zero and Range_Err_Rate is Positive and Speed_Err is Negative, THEN Desired_Acceleration is Positive_Small";
    "IF Range_Err is Positive and Range_Err_Rate is Negative and Speed_Err is Negative, THEN Desired_Acceleration is Positive_Big";
    "IF Speed_Err is Positive, THEN Desired_Acceleration is Negative_Small";
    "IF Speed_Err is Positive and Range_Err is Positive, THEN Desired_Acceleration is Positive_Small";
    
    "IF Acceleration is Negative_Big, THEN Desired_Acceleration is Positive_Big";
    "IF Acceleration is Negative_Small, THEN Desired_Acceleration is Positive_Small";
    "IF Acceleration is Zero, THEN Desired_Acceleration is Zero";
    "IF Acceleration is Positive_Small, THEN Desired_Acceleration is Negative_Small";
    "IF Acceleration is Positive_Big, THEN Desired_Acceleration is Negative_Big";
    
    ];
fis.Rules=fisrule(rules);