function  X_output = Estimate(v,w,X_prev,SenseData)
I = eye(3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%estimate
% X_prev = transpose(X_prev)
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
    0.02,    0.00, 0.00;
    0.00,   0.02, 0.00;
    0.00 , 0.00, 0.02];
%landmark coordinates
LM_X = [-20 -20 -5  30   30 8];
LM_Y = [-25  0  25  -25  0  25];
LM = [LM_X;LM_Y];

theta_t = thetaConversion(theta+w);
Gt = [ 1, 0, -v*cos(theta)/w+v*cos(theta_t)/w;
           0, 1,  -v*sin(theta)/w+v*sin(theta_t)/w;
           0, 0, 1];
       
Vt = [ (-sin(theta)+sin(theta_t))/w, v*(sin(theta)-sin(theta_t))/(w^2)+v*(cos(theta_t))/w;
           (cos(theta)-cos(theta_t))/w, -v*(cos(theta)-cos(theta_t))/(w^2)+v*(sin(theta_t))/w;
           0, 1];
       
Mt = [ a1*v^2+a2*w^2, 0;
             0, a3*v^2+a4*w^2];
         
mean_delta = [ -v*sin(theta)/w+v*sin(theta_t)/w;
                              v*cos(theta)/w-v*cos(theta_t)/w;
                              w];
mean_est = mean_prev + mean_delta;
cov_est = Gt * cov_prev * transpose(Gt) + Vt * Mt * transpose(Vt);

x_est = mean_est(1,1);
y_est = mean_est(2,1);
theta_est = thetaConversion(mean_est(3,1));
mean_est = [x_est; y_est; theta_est];

% visualization of estimate position
circle_draw([ x_est,  y_est],0.6,'red')
plotErrorEllipse([ x_est  y_est], cov_est(1:2,1:2), 0.3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%measurement update
[lm_num, col] = size(SenseData);
H_list = [0;0;0];
S_list = [0;0;0];
zhat_list = [0;0;0];
k_max = 0;
j_min = 0.00025;
update = 0;


for lm_idx = 1: lm_num
        %measurement data
        r_sense = SenseData(lm_idx, 2);
        phi_sense = thetaConversion(SenseData(lm_idx, 3));
        z = [ r_sense; phi_sense; 0];
        
        j_max = 0;
        j_list = [];
        
    for k = 1:6
        lm_x = LM_X(1, k);
        lm_y = LM_Y(1, k);
        
        %distance from landmark to estimate pose
        q = (lm_x - x_est)^2 + (lm_y - y_est)^2; 
        q_sqrt = sqrt(q);
        phi = thetaConversion( atan2(lm_y - y_est, lm_x - x_est) - theta_est);
        z_hat = [ q_sqrt; phi; 0];
        zhat_list = [zhat_list z_hat];
        
        H = [ -(lm_x-x_est)/q_sqrt, -(lm_y-y_est)/q_sqrt, 0;
                   (lm_y-y_est)/q, -(lm_x-x_est)/q, -1;
                   0, 0, 0];        
        H_list = [H_list H];

        S = H * cov_est * transpose(H) + Q;
        S_list = [S_list S];       
        
        j = exp(-0.5*transpose(z - z_hat)*inv(S)*(z - z_hat))* (det(2*pi*S))^(-0.5)
        % j_logodds = log10(j/1-j);
        j_list =  [j_list, j];
        
        if j > j_max
            j_max = j;
            k_max = k;
        end
    end
%     j_list
    j_list = sort(j_list)
    %update
    if k_max~=0
%         if j_list(1, 6) > 0.01 * j_list(1, 6)
        if j_max>j_min
            update = 1;
        else
             update = 0;
        end
    end
%     update
%     j_max
    if update == 1
        H_jmax = H_list(:, k_max*3-1: k_max*3+1);

        S_jmax = S_list(:, k_max*3-1: k_max*3+1);

        zhat_jmax = zhat_list(:, k_max+1);

        K = cov_est *  transpose(H_jmax) * inv(S_jmax);
        
        delta_z = z - zhat_jmax;
        delta_phi = thetaConversion(delta_z(2, 1));
        delta_r = delta_z(1, 1);
        delta_z = [delta_r; delta_phi; 0];
        
        mean_est = mean_est + K*(delta_z);
        temp = thetaConversion( mean_est(3, 1));
        mean_est = [ mean_est(1, 1); mean_est(2, 1); temp];

        cov_est = (I - K*H_jmax)*cov_est;
    end
end
    mean = mean_est;
    cov = cov_est;
    X_output = [mean, cov];
    
    if update == 1
        % visualization
        % if measurement updated, then draw  green circle
        circle_draw([ X_output(1,1),  X_output(2,1)],0.6,'green')
        plotErrorEllipse([X_output(1,1), X_output(2,1)], cov(1:2,1:2), 0.3);
    end
end