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

        self.measurement_list = []

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
        self.measurement_list = obstacleList

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
        x_est = state_past.x + d_x * math.sin(theta_) - d_y * math.cos(theta_)
        y_est = state_past.y + d_x * math.sin(theta_) + d_y * math.cos(theta_)
        theta_est = state_past.theta + d_theta
        state_est = state_vector(x_est, y_est, theta_est)

        # Covariance estimation
        cov_est = Gt * cov_past * Gt.transpose() + Wt * cov_motion * Wt.transpose()

    def state_measurement_update(self, state_est, cov_est, measurementList):
        
        

if __name__ == 'main':
    loc = localization()
    # loc.start()