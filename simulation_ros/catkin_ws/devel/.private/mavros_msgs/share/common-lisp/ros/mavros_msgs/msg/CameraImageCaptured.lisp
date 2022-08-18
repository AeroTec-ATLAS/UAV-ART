; Auto-generated. Do not edit!


(cl:in-package mavros_msgs-msg)


;//! \htmlinclude CameraImageCaptured.msg.html

(cl:defclass <CameraImageCaptured> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (orientation
    :reader orientation
    :initarg :orientation
    :type geometry_msgs-msg:Quaternion
    :initform (cl:make-instance 'geometry_msgs-msg:Quaternion))
   (geo
    :reader geo
    :initarg :geo
    :type geographic_msgs-msg:GeoPoint
    :initform (cl:make-instance 'geographic_msgs-msg:GeoPoint))
   (relative_alt
    :reader relative_alt
    :initarg :relative_alt
    :type cl:float
    :initform 0.0)
   (image_index
    :reader image_index
    :initarg :image_index
    :type cl:integer
    :initform 0)
   (capture_result
    :reader capture_result
    :initarg :capture_result
    :type cl:fixnum
    :initform 0)
   (file_url
    :reader file_url
    :initarg :file_url
    :type cl:string
    :initform ""))
)

(cl:defclass CameraImageCaptured (<CameraImageCaptured>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CameraImageCaptured>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CameraImageCaptured)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mavros_msgs-msg:<CameraImageCaptured> is deprecated: use mavros_msgs-msg:CameraImageCaptured instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CameraImageCaptured>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:header-val is deprecated.  Use mavros_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'orientation-val :lambda-list '(m))
(cl:defmethod orientation-val ((m <CameraImageCaptured>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:orientation-val is deprecated.  Use mavros_msgs-msg:orientation instead.")
  (orientation m))

(cl:ensure-generic-function 'geo-val :lambda-list '(m))
(cl:defmethod geo-val ((m <CameraImageCaptured>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:geo-val is deprecated.  Use mavros_msgs-msg:geo instead.")
  (geo m))

(cl:ensure-generic-function 'relative_alt-val :lambda-list '(m))
(cl:defmethod relative_alt-val ((m <CameraImageCaptured>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:relative_alt-val is deprecated.  Use mavros_msgs-msg:relative_alt instead.")
  (relative_alt m))

(cl:ensure-generic-function 'image_index-val :lambda-list '(m))
(cl:defmethod image_index-val ((m <CameraImageCaptured>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:image_index-val is deprecated.  Use mavros_msgs-msg:image_index instead.")
  (image_index m))

(cl:ensure-generic-function 'capture_result-val :lambda-list '(m))
(cl:defmethod capture_result-val ((m <CameraImageCaptured>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:capture_result-val is deprecated.  Use mavros_msgs-msg:capture_result instead.")
  (capture_result m))

(cl:ensure-generic-function 'file_url-val :lambda-list '(m))
(cl:defmethod file_url-val ((m <CameraImageCaptured>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:file_url-val is deprecated.  Use mavros_msgs-msg:file_url instead.")
  (file_url m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CameraImageCaptured>) ostream)
  "Serializes a message object of type '<CameraImageCaptured>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orientation) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'geo) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'relative_alt))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'image_index)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'capture_result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'file_url))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'file_url))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CameraImageCaptured>) istream)
  "Deserializes a message object of type '<CameraImageCaptured>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orientation) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'geo) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'relative_alt) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'image_index) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'capture_result) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'file_url) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'file_url) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CameraImageCaptured>)))
  "Returns string type for a message object of type '<CameraImageCaptured>"
  "mavros_msgs/CameraImageCaptured")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CameraImageCaptured)))
  "Returns string type for a message object of type 'CameraImageCaptured"
  "mavros_msgs/CameraImageCaptured")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CameraImageCaptured>)))
  "Returns md5sum for a message object of type '<CameraImageCaptured>"
  "9559d135fc7e5e91d3f1b819ebcd7556")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CameraImageCaptured)))
  "Returns md5sum for a message object of type 'CameraImageCaptured"
  "9559d135fc7e5e91d3f1b819ebcd7556")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CameraImageCaptured>)))
  "Returns full string definition for message of type '<CameraImageCaptured>"
  (cl:format cl:nil "# MAVLink message: CAMERA_IMAGE_CAPTURED~%# https://mavlink.io/en/messages/common.html#CAMERA_IMAGE_CAPTURED~%~%std_msgs/Header header~%~%geometry_msgs/Quaternion orientation	# Quaternion of camera orientation (w, x, y, z order, zero-rotation is 1, 0, 0, 0)~%geographic_msgs/GeoPoint geo~%float32 relative_alt	# mm	Altitude above ground~%int32 image_index # Zero based index of this image (i.e. a new image will have index CAMERA_CAPTURE_STATUS.image count -1)~%int8 capture_result # Boolean indicating success (1) or failure (0) while capturing this image.~%string file_url #URL of image taken. Either local storage or http://foo.jpg if camera provides an HTTP interface.~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geographic_msgs/GeoPoint~%# Geographic point, using the WGS 84 reference ellipsoid.~%~%# Latitude [degrees]. Positive is north of equator; negative is south~%# (-90 <= latitude <= +90).~%float64 latitude~%~%# Longitude [degrees]. Positive is east of prime meridian; negative is~%# west (-180 <= longitude <= +180). At the poles, latitude is -90 or~%# +90, and longitude is irrelevant, but must be in range.~%float64 longitude~%~%# Altitude [m]. Positive is above the WGS 84 ellipsoid (NaN if unspecified).~%float64 altitude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CameraImageCaptured)))
  "Returns full string definition for message of type 'CameraImageCaptured"
  (cl:format cl:nil "# MAVLink message: CAMERA_IMAGE_CAPTURED~%# https://mavlink.io/en/messages/common.html#CAMERA_IMAGE_CAPTURED~%~%std_msgs/Header header~%~%geometry_msgs/Quaternion orientation	# Quaternion of camera orientation (w, x, y, z order, zero-rotation is 1, 0, 0, 0)~%geographic_msgs/GeoPoint geo~%float32 relative_alt	# mm	Altitude above ground~%int32 image_index # Zero based index of this image (i.e. a new image will have index CAMERA_CAPTURE_STATUS.image count -1)~%int8 capture_result # Boolean indicating success (1) or failure (0) while capturing this image.~%string file_url #URL of image taken. Either local storage or http://foo.jpg if camera provides an HTTP interface.~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geographic_msgs/GeoPoint~%# Geographic point, using the WGS 84 reference ellipsoid.~%~%# Latitude [degrees]. Positive is north of equator; negative is south~%# (-90 <= latitude <= +90).~%float64 latitude~%~%# Longitude [degrees]. Positive is east of prime meridian; negative is~%# west (-180 <= longitude <= +180). At the poles, latitude is -90 or~%# +90, and longitude is irrelevant, but must be in range.~%float64 longitude~%~%# Altitude [m]. Positive is above the WGS 84 ellipsoid (NaN if unspecified).~%float64 altitude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CameraImageCaptured>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orientation))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'geo))
     4
     4
     1
     4 (cl:length (cl:slot-value msg 'file_url))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CameraImageCaptured>))
  "Converts a ROS message object to a list"
  (cl:list 'CameraImageCaptured
    (cl:cons ':header (header msg))
    (cl:cons ':orientation (orientation msg))
    (cl:cons ':geo (geo msg))
    (cl:cons ':relative_alt (relative_alt msg))
    (cl:cons ':image_index (image_index msg))
    (cl:cons ':capture_result (capture_result msg))
    (cl:cons ':file_url (file_url msg))
))
