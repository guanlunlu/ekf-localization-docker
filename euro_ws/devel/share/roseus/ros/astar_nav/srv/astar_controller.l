;; Auto-generated. Do not edit!


(when (boundp 'astar_nav::astar_controller)
  (if (not (find-package "ASTAR_NAV"))
    (make-package "ASTAR_NAV"))
  (shadow 'astar_controller (find-package "ASTAR_NAV")))
(unless (find-package "ASTAR_NAV::ASTAR_CONTROLLER")
  (make-package "ASTAR_NAV::ASTAR_CONTROLLER"))
(unless (find-package "ASTAR_NAV::ASTAR_CONTROLLERREQUEST")
  (make-package "ASTAR_NAV::ASTAR_CONTROLLERREQUEST"))
(unless (find-package "ASTAR_NAV::ASTAR_CONTROLLERRESPONSE")
  (make-package "ASTAR_NAV::ASTAR_CONTROLLERRESPONSE"))

(in-package "ROS")

(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(if (not (find-package "NAV_MSGS"))
  (ros::roseus-add-msgs "nav_msgs"))


(defclass astar_nav::astar_controllerRequest
  :super ros::object
  :slots (_current_pose _goal_pose ))

(defmethod astar_nav::astar_controllerRequest
  (:init
   (&key
    ((:current_pose __current_pose) (instance geometry_msgs::Pose2D :init))
    ((:goal_pose __goal_pose) (instance geometry_msgs::Pose2D :init))
    )
   (send-super :init)
   (setq _current_pose __current_pose)
   (setq _goal_pose __goal_pose)
   self)
  (:current_pose
   (&rest __current_pose)
   (if (keywordp (car __current_pose))
       (send* _current_pose __current_pose)
     (progn
       (if __current_pose (setq _current_pose (car __current_pose)))
       _current_pose)))
  (:goal_pose
   (&rest __goal_pose)
   (if (keywordp (car __goal_pose))
       (send* _goal_pose __goal_pose)
     (progn
       (if __goal_pose (setq _goal_pose (car __goal_pose)))
       _goal_pose)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose2D _current_pose
    (send _current_pose :serialization-length)
    ;; geometry_msgs/Pose2D _goal_pose
    (send _goal_pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose2D _current_pose
       (send _current_pose :serialize s)
     ;; geometry_msgs/Pose2D _goal_pose
       (send _goal_pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose2D _current_pose
     (send _current_pose :deserialize buf ptr-) (incf ptr- (send _current_pose :serialization-length))
   ;; geometry_msgs/Pose2D _goal_pose
     (send _goal_pose :deserialize buf ptr-) (incf ptr- (send _goal_pose :serialization-length))
   ;;
   self)
  )

(defclass astar_nav::astar_controllerResponse
  :super ros::object
  :slots (_path ))

(defmethod astar_nav::astar_controllerResponse
  (:init
   (&key
    ((:path __path) (instance nav_msgs::Path :init))
    )
   (send-super :init)
   (setq _path __path)
   self)
  (:path
   (&rest __path)
   (if (keywordp (car __path))
       (send* _path __path)
     (progn
       (if __path (setq _path (car __path)))
       _path)))
  (:serialization-length
   ()
   (+
    ;; nav_msgs/Path _path
    (send _path :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; nav_msgs/Path _path
       (send _path :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; nav_msgs/Path _path
     (send _path :deserialize buf ptr-) (incf ptr- (send _path :serialization-length))
   ;;
   self)
  )

(defclass astar_nav::astar_controller
  :super ros::object
  :slots ())

(setf (get astar_nav::astar_controller :md5sum-) "4b8dc54808bdbb73aea05acfc874e398")
(setf (get astar_nav::astar_controller :datatype-) "astar_nav/astar_controller")
(setf (get astar_nav::astar_controller :request) astar_nav::astar_controllerRequest)
(setf (get astar_nav::astar_controller :response) astar_nav::astar_controllerResponse)

(defmethod astar_nav::astar_controllerRequest
  (:response () (instance astar_nav::astar_controllerResponse :init)))

(setf (get astar_nav::astar_controllerRequest :md5sum-) "4b8dc54808bdbb73aea05acfc874e398")
(setf (get astar_nav::astar_controllerRequest :datatype-) "astar_nav/astar_controllerRequest")
(setf (get astar_nav::astar_controllerRequest :definition-)
      "geometry_msgs/Pose2D current_pose
geometry_msgs/Pose2D goal_pose

================================================================================
MSG: geometry_msgs/Pose2D
# Deprecated
# Please use the full 3D pose.

# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.

# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.


# This expresses a position and orientation on a 2D manifold.

float64 x
float64 y
float64 theta
---
nav_msgs/Path path

================================================================================
MSG: nav_msgs/Path
#An array of poses that represents a Path for a robot to follow
Header header
geometry_msgs/PoseStamped[] poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
")

(setf (get astar_nav::astar_controllerResponse :md5sum-) "4b8dc54808bdbb73aea05acfc874e398")
(setf (get astar_nav::astar_controllerResponse :datatype-) "astar_nav/astar_controllerResponse")
(setf (get astar_nav::astar_controllerResponse :definition-)
      "geometry_msgs/Pose2D current_pose
geometry_msgs/Pose2D goal_pose

================================================================================
MSG: geometry_msgs/Pose2D
# Deprecated
# Please use the full 3D pose.

# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.

# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.


# This expresses a position and orientation on a 2D manifold.

float64 x
float64 y
float64 theta
---
nav_msgs/Path path

================================================================================
MSG: nav_msgs/Path
#An array of poses that represents a Path for a robot to follow
Header header
geometry_msgs/PoseStamped[] poses

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
")



(provide :astar_nav/astar_controller "4b8dc54808bdbb73aea05acfc874e398")


