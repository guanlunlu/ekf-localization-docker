; Auto-generated. Do not edit!


(cl:in-package astar_nav-srv)


;//! \htmlinclude astar_controller-request.msg.html

(cl:defclass <astar_controller-request> (roslisp-msg-protocol:ros-message)
  ((current_pose
    :reader current_pose
    :initarg :current_pose
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D))
   (goal_pose
    :reader goal_pose
    :initarg :goal_pose
    :type geometry_msgs-msg:Pose2D
    :initform (cl:make-instance 'geometry_msgs-msg:Pose2D)))
)

(cl:defclass astar_controller-request (<astar_controller-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <astar_controller-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'astar_controller-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name astar_nav-srv:<astar_controller-request> is deprecated: use astar_nav-srv:astar_controller-request instead.")))

(cl:ensure-generic-function 'current_pose-val :lambda-list '(m))
(cl:defmethod current_pose-val ((m <astar_controller-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader astar_nav-srv:current_pose-val is deprecated.  Use astar_nav-srv:current_pose instead.")
  (current_pose m))

(cl:ensure-generic-function 'goal_pose-val :lambda-list '(m))
(cl:defmethod goal_pose-val ((m <astar_controller-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader astar_nav-srv:goal_pose-val is deprecated.  Use astar_nav-srv:goal_pose instead.")
  (goal_pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <astar_controller-request>) ostream)
  "Serializes a message object of type '<astar_controller-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'current_pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal_pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <astar_controller-request>) istream)
  "Deserializes a message object of type '<astar_controller-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'current_pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal_pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<astar_controller-request>)))
  "Returns string type for a service object of type '<astar_controller-request>"
  "astar_nav/astar_controllerRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'astar_controller-request)))
  "Returns string type for a service object of type 'astar_controller-request"
  "astar_nav/astar_controllerRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<astar_controller-request>)))
  "Returns md5sum for a message object of type '<astar_controller-request>"
  "4b8dc54808bdbb73aea05acfc874e398")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'astar_controller-request)))
  "Returns md5sum for a message object of type 'astar_controller-request"
  "4b8dc54808bdbb73aea05acfc874e398")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<astar_controller-request>)))
  "Returns full string definition for message of type '<astar_controller-request>"
  (cl:format cl:nil "geometry_msgs/Pose2D current_pose~%geometry_msgs/Pose2D goal_pose~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'astar_controller-request)))
  "Returns full string definition for message of type 'astar_controller-request"
  (cl:format cl:nil "geometry_msgs/Pose2D current_pose~%geometry_msgs/Pose2D goal_pose~%~%================================================================================~%MSG: geometry_msgs/Pose2D~%# Deprecated~%# Please use the full 3D pose.~%~%# In general our recommendation is to use a full 3D representation of everything and for 2D specific applications make the appropriate projections into the plane for their calculations but optimally will preserve the 3D information during processing.~%~%# If we have parallel copies of 2D datatypes every UI and other pipeline will end up needing to have dual interfaces to plot everything. And you will end up with not being able to use 3D tools for 2D use cases even if they're completely valid, as you'd have to reimplement it with different inputs and outputs. It's not particularly hard to plot the 2D pose or compute the yaw error for the Pose message and there are already tools and libraries that can do this for you.~%~%~%# This expresses a position and orientation on a 2D manifold.~%~%float64 x~%float64 y~%float64 theta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <astar_controller-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'current_pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal_pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <astar_controller-request>))
  "Converts a ROS message object to a list"
  (cl:list 'astar_controller-request
    (cl:cons ':current_pose (current_pose msg))
    (cl:cons ':goal_pose (goal_pose msg))
))
;//! \htmlinclude astar_controller-response.msg.html

(cl:defclass <astar_controller-response> (roslisp-msg-protocol:ros-message)
  ((path
    :reader path
    :initarg :path
    :type nav_msgs-msg:Path
    :initform (cl:make-instance 'nav_msgs-msg:Path)))
)

(cl:defclass astar_controller-response (<astar_controller-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <astar_controller-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'astar_controller-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name astar_nav-srv:<astar_controller-response> is deprecated: use astar_nav-srv:astar_controller-response instead.")))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <astar_controller-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader astar_nav-srv:path-val is deprecated.  Use astar_nav-srv:path instead.")
  (path m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <astar_controller-response>) ostream)
  "Serializes a message object of type '<astar_controller-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'path) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <astar_controller-response>) istream)
  "Deserializes a message object of type '<astar_controller-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'path) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<astar_controller-response>)))
  "Returns string type for a service object of type '<astar_controller-response>"
  "astar_nav/astar_controllerResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'astar_controller-response)))
  "Returns string type for a service object of type 'astar_controller-response"
  "astar_nav/astar_controllerResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<astar_controller-response>)))
  "Returns md5sum for a message object of type '<astar_controller-response>"
  "4b8dc54808bdbb73aea05acfc874e398")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'astar_controller-response)))
  "Returns md5sum for a message object of type 'astar_controller-response"
  "4b8dc54808bdbb73aea05acfc874e398")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<astar_controller-response>)))
  "Returns full string definition for message of type '<astar_controller-response>"
  (cl:format cl:nil "nav_msgs/Path path~%~%================================================================================~%MSG: nav_msgs/Path~%#An array of poses that represents a Path for a robot to follow~%Header header~%geometry_msgs/PoseStamped[] poses~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'astar_controller-response)))
  "Returns full string definition for message of type 'astar_controller-response"
  (cl:format cl:nil "nav_msgs/Path path~%~%================================================================================~%MSG: nav_msgs/Path~%#An array of poses that represents a Path for a robot to follow~%Header header~%geometry_msgs/PoseStamped[] poses~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <astar_controller-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'path))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <astar_controller-response>))
  "Converts a ROS message object to a list"
  (cl:list 'astar_controller-response
    (cl:cons ':path (path msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'astar_controller)))
  'astar_controller-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'astar_controller)))
  'astar_controller-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'astar_controller)))
  "Returns string type for a service object of type '<astar_controller>"
  "astar_nav/astar_controller")