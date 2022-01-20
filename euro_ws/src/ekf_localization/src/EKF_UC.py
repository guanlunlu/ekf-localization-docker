#usr/bin/env python3
import rospy
import math
import numpy as np
from geometry_msgs.msg import Twist
from obstacle_detector.msg import Obstacles

class state_vector:
    def __init__(self, x, y, theta):
        self.x = x
        self.y = y
        self.theta = theta

class localization:
    def __init__(self) -> None:
        self.motion_sub = rospy.Subscriber("cmd_vel", Twist(), self.motionCallback)
        self.measurement_sub = rospy.Subscriber("raw_obstacles", Obstacles, self.measurementCallback)

        self.control_frequency = 50
        self.d_t = 1/self.control_frequency

        self.State_past = state_vector(0,0,0)
        self.State_now = state_vector(0,0,0)

        self.Model_const = np.mat([0.2, 0, 0],
                                     [0, 0.2, 0],
                                     [0, 0, 0.2])

        self.Cov_past = np.mat([0.1, 0, 0],
                                  [0, 0.1, 0],
                                  [0, 0, 0.1])

        self.Cov_now = np.mat([0.1, 0, 0],
                                 [0, 0.1, 0],
                                 [0, 0, 0.1])

        self.observed_features = []
        self.landmark1 = state_vector(1, -0.092, 0)
        self.landmark2 = state_vector(0.055, 3.1, 0)
        self.landmark3 = state_vector(1.953, 3.1, 0)
        self.landmark_list = [self.landmark1, self.landmark2, self.landmark3]


    def motionCallback(self, data):
        Vx_t = data.linear.x
        Vy_t = data.linear.y
        Vw_t = data.angular.z
        # Motion model input
        U_t = state_vector(Vx_t, Vy_t, Vw_t)
        self.state_prediction(self.State_past, self.Cov_past, U_t)

    def measurementCallback(self, data):
        obstacleList = []
        for i in data.circles:
            obstacleList.append(state_vector(i.center.x, i.center.y, 0))
        self.observed_features = obstacleList

    def state_prediction(self, state_past, cov_past, U_t):
        d_x = self.d_t * U_t.x
        d_y = self.d_t * U_t.y
        d_theta = self.d_t * U_t.theta
        theta_ = state_past.theta + d_theta/2

        # Jacobian matrix for Ekf linearization
        Gt = np.mat([1, 0, -d_x * math.sin(theta_) - d_y * math.cos(theta_)],
                       [0, 1, d_x * math.cos(theta_) - d_y * math.sin(theta_)],
                       [0, 0, 1])
        
        Wt = np.mat([math.cos(theta_), -math.sin(theta_), -d_x * math.sin(theta_)/2 - d_y * math.cos(theta_)/2],
                       [math.sin(theta_), math.cos(theta_), d_x * math.cos(theta_)/2 - d_y * math.sin(theta_)/2],
                       [0, 0, 1])

        # Calculate model covariance
        stdev_vec = np.matmul(self.Model_const, np.mat([d_x, d_y, d_theta]))
        var_x = stdev_vec[0,0] * stdev_vec[0,0]
        var_y = stdev_vec[1,0] * stdev_vec[1,0]
        var_theta = stdev_vec[2,0] * stdev_vec[2,0]
        
        cov_motion = np.mat([var_x, 0, 0],
                            [0, var_y, 0],
                            [0, 0, var_theta])
        
        # Mean estimation
        x_pre = state_past.x + d_x * math.sin(theta_) - d_y * math.cos(theta_)
        y_pre = state_past.y + d_x * math.sin(theta_) + d_y * math.cos(theta_)
        theta_pre = state_past.theta + d_theta
        state_pre = state_vector(x_pre, y_pre, theta_pre)

        # Covariance estimationee
        cov_pre = Gt * cov_past * Gt.transpose() + Wt * cov_motion * Wt.transpose()
        self.measurement_update(state_pre, cov_pre, self.observed_features)

    def state_measurement_update(self, state_pre, cov_pre, measurementList):
        for obs in self.observed_features:
            r_sense = self.distance(obs, state_vector(0,0,0))
            phi_sense = math.atan2(obs.y, obs.x)
            z = np.mat([[r_sense], [phi_sense], [0]])

            for lm in self.landmark_list:
                q_sqrt = self.distance(lm, state_pre)
                q = q_sqrt * q_sqrt
                phi = self.theta_convert(math.atan2(lm.y - state_pre.y, lm.x - state_pre.x) - state_pre.theta)
                z_hat = np.mat([[q_sqrt], [phi_sense], [0]])

                 

    def distance(self, p1, p2):
        d_x = p1.x - p2.x
        d_y = p1.y - p2.y
        return math.sqrt(d_x * d_x + d_y * d_y)
    
    def theta_convert(self, input):
        # convert rad domain to [-pi, pi]
        if input >=0:
            input = math.fmod(input, 2*pi)
            if input > pi:
                input -= 2*pi
                output = input
            else:
                output = input
        else:
            input *= -1
            input = math.fmod(input, 2*pi)
            if input > pi:
                input -= 2*pi
                output = input*-1
            else:
                output = input*-1
        return output

if __name__ == 'main':
    loc = localization()
    # loc.start()