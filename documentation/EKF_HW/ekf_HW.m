% An example of EKF localizing based on work of "Ayush Dewan"
% Modified by PooPoo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Do not move code below %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear
clear figure
v = 0;
w = 0;
del_t = 1;
% Stochastic uncertainty gain
c1=0.05;
c2=0.05;
c3=0.05;
c4=0.05;
Q=[
    0.02    0.00;
    0.00    0.02;
    ];
% Land marks position
LM_X = [-20 -20 -5  30   30 8];
LM_Y = [-25  0  25  -25  0  25];
LM_c = length(LM_X);
LM = [LM_X;LM_Y];
axis ([-70 70 -70 70]);
hold on;
for i = 1:length(LM_X)
    scatter(LM_X(i), LM_Y(i), [], 'd');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Do not move code above %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cart initial position
x_p = 2.5;
y_p = -20;
phi_p = 0;          % Point Y initially
previous_pose = [x_p;y_p;phi_p];
X = previous_pose;
X_predicted = X;    % You can only access "actual state" here initially 
init_cov = [0.2, 0, 0; 0, 0.2, 0; 0, 0,0.2];
X_predicted = [X_predicted, init_cov];
          
while 1
    % If navigation
    % [v,w] = navigation();

    % Move in Circle without hesitate
    v = 1.0;
    w = 0.04;
    
    % Physical actual output
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Do not move code below %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    X = VehicleModel(v,w,previous_pose);
    previous_pose = X;
%     SenseData = SensorModel(X,LM);
    SenseData = SensorModelUC(X,LM);
    % or SensorModelUC(X,LM);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Do not move code above %%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Do state estimation (EKF for this HW)
%      X_predicted = Estimate(v,w,X_predicted,SenseData);
     X_predicted = EstimateUC(v,w,X_predicted,SenseData);
     cov = X_predicted(1:2, 2:3);
     mean = X_predicted(:, 1);
     x = mean(1, 1);
     y = mean(2, 1);
   
    % Visualize your result
     circle_draw([X(1,1), X(2,1)],0.6,'blue')
     pause(0.1);
    
end