function  X_output = Estimate(v,w,X_prev,SenseData)
I = eye(3);
%estimate
x_prev = X_prev(1, 1);
y_prev = X_prev(2, 1);
theta_prev = X_prev(3, 1);
theta = theta_prev;
mean_prev = X_prev(:, 1);
cov_prev = X_prev(:, 2:4);
%%actuating uncertainty
a1=0.05;
a2=0.05;
a3=0.05;
a4=0.05;
%%sensing uncertainty
Q=[
    0.02    0.00;
    0.00    0.02;
    ];
%landmark coordinates
LM_X = [-20 -20 -5  30   30 8];
LM_Y = [-25  0  25  -25  0  25];

Gt = [ 1, 0, -v*cos(theta)/w+v*cos(theta+w)/w;
           0, 1,  -v*sin(theta)/w+v*sin(theta+w)/w;
           0, 0, 1];
Vt = [ (-sin(theta)+sin(theta+w))/w, v*(sin(theta)-sin(theta+w))/(w^2)+v*(cos(theta+w))/w;
           (cos(theta)-cos(theta+w))/w, -v*(cos(theta)-cos(theta+w))/(w^2)+v*(sin(theta+w))/w;
           0, 1];
Mt = [ a1*v^2+a2*w^2, 0;
             0, a3*v^2+a4*w^2];
mean_delta = [ -v*sin(theta)/w+v*sin(theta+w)/w;
                              -v*cos(theta)/w-v*cos(theta+w)/w;
                              w];
mean_est = mean_prev + mean_delta;
cov_est = Gt * cov_prev * transpose(Gt) + Vt * Mt * transpose(Vt);
x_est = mean_est(1,1);
y_est = mean_est(2,1);
theta_est = mean_est(3,1);

%measurement correction
for lm_idx = 1:6
    if  SenseData(lm_idx, 1) ==1
        q_sqrt = SenseData(lm_idx, 2);
        q = q_sqrt ^2;
        phi = SenseData(lm_idx, 3);
        
        z = [ LM_X(1, lm_idx); LM_Y(1, lm_idx); 0];
        z_hat = [ q_sqrt; phi; 0];
        
        lm_robot = [q*cos(phi); q*sin(phi)];
        rot = [ cos(-theta_est), -sin(-theta_est);
                     sin(-theta_est), cos(-theta_est)];
        lm_xy = rot * lm_robot + [x_est; y_est];
        lm_x = lm_xy(1,1);
        lm_y = lm_xy(2,1);
        H = [ -(lm_x-x_est)/q_sqrt, -(lm_y-y_est)/q_sqrt, 0;
                   (lm_y-y_est)/q_sqrt, -(lm_x-x_est)/q_sqrt, -1;
                   0, 0, 0];
        S = H * cov_est * transpose(H) + Q;
        K = cov_est *  transpose(H) * inv(S);
        
        mean_est = mean_est + K(z - z_hat);
        cov_est = (I - K*H)*cov_est;
    end
    mean = mean_est;
    cov = cov_est;
    X_output = [mean, cov];
end