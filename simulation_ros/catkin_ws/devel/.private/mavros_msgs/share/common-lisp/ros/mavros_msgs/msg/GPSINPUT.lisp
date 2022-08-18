; Auto-generated. Do not edit!


(cl:in-package mavros_msgs-msg)


;//! \htmlinclude GPSINPUT.msg.html

(cl:defclass <GPSINPUT> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (fix_type
    :reader fix_type
    :initarg :fix_type
    :type cl:fixnum
    :initform 0)
   (gps_id
    :reader gps_id
    :initarg :gps_id
    :type cl:fixnum
    :initform 0)
   (ignore_flags
    :reader ignore_flags
    :initarg :ignore_flags
    :type cl:fixnum
    :initform 0)
   (time_week_ms
    :reader time_week_ms
    :initarg :time_week_ms
    :type cl:integer
    :initform 0)
   (time_week
    :reader time_week
    :initarg :time_week
    :type cl:fixnum
    :initform 0)
   (lat
    :reader lat
    :initarg :lat
    :type cl:integer
    :initform 0)
   (lon
    :reader lon
    :initarg :lon
    :type cl:integer
    :initform 0)
   (alt
    :reader alt
    :initarg :alt
    :type cl:float
    :initform 0.0)
   (hdop
    :reader hdop
    :initarg :hdop
    :type cl:float
    :initform 0.0)
   (vdop
    :reader vdop
    :initarg :vdop
    :type cl:float
    :initform 0.0)
   (vn
    :reader vn
    :initarg :vn
    :type cl:float
    :initform 0.0)
   (ve
    :reader ve
    :initarg :ve
    :type cl:float
    :initform 0.0)
   (vd
    :reader vd
    :initarg :vd
    :type cl:float
    :initform 0.0)
   (speed_accuracy
    :reader speed_accuracy
    :initarg :speed_accuracy
    :type cl:float
    :initform 0.0)
   (horiz_accuracy
    :reader horiz_accuracy
    :initarg :horiz_accuracy
    :type cl:float
    :initform 0.0)
   (vert_accuracy
    :reader vert_accuracy
    :initarg :vert_accuracy
    :type cl:float
    :initform 0.0)
   (satellites_visible
    :reader satellites_visible
    :initarg :satellites_visible
    :type cl:fixnum
    :initform 0)
   (yaw
    :reader yaw
    :initarg :yaw
    :type cl:fixnum
    :initform 0))
)

(cl:defclass GPSINPUT (<GPSINPUT>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GPSINPUT>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GPSINPUT)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name mavros_msgs-msg:<GPSINPUT> is deprecated: use mavros_msgs-msg:GPSINPUT instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:header-val is deprecated.  Use mavros_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'fix_type-val :lambda-list '(m))
(cl:defmethod fix_type-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:fix_type-val is deprecated.  Use mavros_msgs-msg:fix_type instead.")
  (fix_type m))

(cl:ensure-generic-function 'gps_id-val :lambda-list '(m))
(cl:defmethod gps_id-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:gps_id-val is deprecated.  Use mavros_msgs-msg:gps_id instead.")
  (gps_id m))

(cl:ensure-generic-function 'ignore_flags-val :lambda-list '(m))
(cl:defmethod ignore_flags-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:ignore_flags-val is deprecated.  Use mavros_msgs-msg:ignore_flags instead.")
  (ignore_flags m))

(cl:ensure-generic-function 'time_week_ms-val :lambda-list '(m))
(cl:defmethod time_week_ms-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:time_week_ms-val is deprecated.  Use mavros_msgs-msg:time_week_ms instead.")
  (time_week_ms m))

(cl:ensure-generic-function 'time_week-val :lambda-list '(m))
(cl:defmethod time_week-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:time_week-val is deprecated.  Use mavros_msgs-msg:time_week instead.")
  (time_week m))

(cl:ensure-generic-function 'lat-val :lambda-list '(m))
(cl:defmethod lat-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:lat-val is deprecated.  Use mavros_msgs-msg:lat instead.")
  (lat m))

(cl:ensure-generic-function 'lon-val :lambda-list '(m))
(cl:defmethod lon-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:lon-val is deprecated.  Use mavros_msgs-msg:lon instead.")
  (lon m))

(cl:ensure-generic-function 'alt-val :lambda-list '(m))
(cl:defmethod alt-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:alt-val is deprecated.  Use mavros_msgs-msg:alt instead.")
  (alt m))

(cl:ensure-generic-function 'hdop-val :lambda-list '(m))
(cl:defmethod hdop-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:hdop-val is deprecated.  Use mavros_msgs-msg:hdop instead.")
  (hdop m))

(cl:ensure-generic-function 'vdop-val :lambda-list '(m))
(cl:defmethod vdop-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:vdop-val is deprecated.  Use mavros_msgs-msg:vdop instead.")
  (vdop m))

(cl:ensure-generic-function 'vn-val :lambda-list '(m))
(cl:defmethod vn-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:vn-val is deprecated.  Use mavros_msgs-msg:vn instead.")
  (vn m))

(cl:ensure-generic-function 've-val :lambda-list '(m))
(cl:defmethod ve-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:ve-val is deprecated.  Use mavros_msgs-msg:ve instead.")
  (ve m))

(cl:ensure-generic-function 'vd-val :lambda-list '(m))
(cl:defmethod vd-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:vd-val is deprecated.  Use mavros_msgs-msg:vd instead.")
  (vd m))

(cl:ensure-generic-function 'speed_accuracy-val :lambda-list '(m))
(cl:defmethod speed_accuracy-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:speed_accuracy-val is deprecated.  Use mavros_msgs-msg:speed_accuracy instead.")
  (speed_accuracy m))

(cl:ensure-generic-function 'horiz_accuracy-val :lambda-list '(m))
(cl:defmethod horiz_accuracy-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:horiz_accuracy-val is deprecated.  Use mavros_msgs-msg:horiz_accuracy instead.")
  (horiz_accuracy m))

(cl:ensure-generic-function 'vert_accuracy-val :lambda-list '(m))
(cl:defmethod vert_accuracy-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:vert_accuracy-val is deprecated.  Use mavros_msgs-msg:vert_accuracy instead.")
  (vert_accuracy m))

(cl:ensure-generic-function 'satellites_visible-val :lambda-list '(m))
(cl:defmethod satellites_visible-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:satellites_visible-val is deprecated.  Use mavros_msgs-msg:satellites_visible instead.")
  (satellites_visible m))

(cl:ensure-generic-function 'yaw-val :lambda-list '(m))
(cl:defmethod yaw-val ((m <GPSINPUT>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader mavros_msgs-msg:yaw-val is deprecated.  Use mavros_msgs-msg:yaw instead.")
  (yaw m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<GPSINPUT>)))
    "Constants for message type '<GPSINPUT>"
  '((:GPS_FIX_TYPE_NO_GPS . 0)
    (:GPS_FIX_TYPE_NO_FIX . 1)
    (:GPS_FIX_TYPE_2D_FIX . 2)
    (:GPS_FIX_TYPE_3D_FIX . 3)
    (:GPS_FIX_TYPE_DGPS . 4)
    (:GPS_FIX_TYPE_RTK_FLOATR . 5)
    (:GPS_FIX_TYPE_RTK_FIXEDR . 6)
    (:GPS_FIX_TYPE_STATIC . 7)
    (:GPS_FIX_TYPE_PPP . 8))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'GPSINPUT)))
    "Constants for message type 'GPSINPUT"
  '((:GPS_FIX_TYPE_NO_GPS . 0)
    (:GPS_FIX_TYPE_NO_FIX . 1)
    (:GPS_FIX_TYPE_2D_FIX . 2)
    (:GPS_FIX_TYPE_3D_FIX . 3)
    (:GPS_FIX_TYPE_DGPS . 4)
    (:GPS_FIX_TYPE_RTK_FLOATR . 5)
    (:GPS_FIX_TYPE_RTK_FIXEDR . 6)
    (:GPS_FIX_TYPE_STATIC . 7)
    (:GPS_FIX_TYPE_PPP . 8))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GPSINPUT>) ostream)
  "Serializes a message object of type '<GPSINPUT>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fix_type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ignore_flags)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ignore_flags)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'time_week_ms)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'time_week_ms)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'time_week_ms)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'time_week_ms)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'time_week)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'time_week)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'lat)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'lon)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'alt))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'hdop))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vdop))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vn))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 've))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed_accuracy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'horiz_accuracy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vert_accuracy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'satellites_visible)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'yaw)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'yaw)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GPSINPUT>) istream)
  "Deserializes a message object of type '<GPSINPUT>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'fix_type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ignore_flags)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ignore_flags)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'time_week_ms)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'time_week_ms)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'time_week_ms)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'time_week_ms)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'time_week)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'time_week)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lat) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lon) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'alt) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'hdop) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vdop) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vn) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 've) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed_accuracy) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'horiz_accuracy) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vert_accuracy) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'satellites_visible)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'yaw)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'yaw)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GPSINPUT>)))
  "Returns string type for a message object of type '<GPSINPUT>"
  "mavros_msgs/GPSINPUT")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GPSINPUT)))
  "Returns string type for a message object of type 'GPSINPUT"
  "mavros_msgs/GPSINPUT")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GPSINPUT>)))
  "Returns md5sum for a message object of type '<GPSINPUT>"
  "928ef4ffec7b9af7c6e4748f0542b6a0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GPSINPUT)))
  "Returns md5sum for a message object of type 'GPSINPUT"
  "928ef4ffec7b9af7c6e4748f0542b6a0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GPSINPUT>)))
  "Returns full string definition for message of type '<GPSINPUT>"
  (cl:format cl:nil "# FCU GPS INPUT message for the gps_input plugin~%# <a href=\"https://mavlink.io/en/messages/common.html#GPS_INPUT\">mavlink GPS_INPUT message</a>.~%~%std_msgs/Header header~%## GPS_FIX_TYPE enum~%uint8 GPS_FIX_TYPE_NO_GPS     = 0    # No GPS connected~%uint8 GPS_FIX_TYPE_NO_FIX     = 1    # No position information, GPS is connected~%uint8 GPS_FIX_TYPE_2D_FIX     = 2    # 2D position~%uint8 GPS_FIX_TYPE_3D_FIX     = 3    # 3D position~%uint8 GPS_FIX_TYPE_DGPS       = 4    # DGPS/SBAS aided 3D position~%uint8 GPS_FIX_TYPE_RTK_FLOATR = 5    # TK float, 3D position~%uint8 GPS_FIX_TYPE_RTK_FIXEDR = 6    # TK Fixed, 3D position~%uint8 GPS_FIX_TYPE_STATIC     = 7    # Static fixed, typically used for base stations~%uint8 GPS_FIX_TYPE_PPP        = 8    # PPP, 3D position~%uint8 fix_type      # [GPS_FIX_TYPE] GPS fix type~%~%uint8 gps_id        # ID of the GPS for multiple GPS inputs~%uint16 ignore_flags # Bitmap indicating which GPS input flags fields to ignore. All other fields must be provided.~%~%uint32 time_week_ms # [ms] GPS time (from start of GPS week)~%uint16 time_week    # GPS week number~%int32 lat           # [degE7] Latitude (WGS84, EGM96 ellipsoid)~%int32 lon           # [degE7] Longitude (WGS84, EGM96 ellipsoid)~%float32 alt         # [m] Altitude (MSL). Positive for up.~%~%float32 hdop        # [m] GPS HDOP horizontal dilution of position.~%float32 vdop        # [m] GPS VDOP vertical dilution of position~%float32 vn          # [m/s] GPS velocity in NORTH direction in earth-fixed NED frame~%float32 ve          # [m/s] GPS velocity in EAST direction in earth-fixed NED frame~%float32 vd          # [m/s] GPS velocity in DOWN direction in earth-fixed NED frame~%~%float32 speed_accuracy # [m/s] GPS speed accuracy~%float32 horiz_accuracy # [m] GPS horizontal accuracy~%float32 vert_accuracy  # [m] GPS vertical accuracy~%~%uint8 satellites_visible # Number of satellites visible. If unknown, set to 255~%uint16 yaw          # [cdeg] Yaw in earth frame from north.~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GPSINPUT)))
  "Returns full string definition for message of type 'GPSINPUT"
  (cl:format cl:nil "# FCU GPS INPUT message for the gps_input plugin~%# <a href=\"https://mavlink.io/en/messages/common.html#GPS_INPUT\">mavlink GPS_INPUT message</a>.~%~%std_msgs/Header header~%## GPS_FIX_TYPE enum~%uint8 GPS_FIX_TYPE_NO_GPS     = 0    # No GPS connected~%uint8 GPS_FIX_TYPE_NO_FIX     = 1    # No position information, GPS is connected~%uint8 GPS_FIX_TYPE_2D_FIX     = 2    # 2D position~%uint8 GPS_FIX_TYPE_3D_FIX     = 3    # 3D position~%uint8 GPS_FIX_TYPE_DGPS       = 4    # DGPS/SBAS aided 3D position~%uint8 GPS_FIX_TYPE_RTK_FLOATR = 5    # TK float, 3D position~%uint8 GPS_FIX_TYPE_RTK_FIXEDR = 6    # TK Fixed, 3D position~%uint8 GPS_FIX_TYPE_STATIC     = 7    # Static fixed, typically used for base stations~%uint8 GPS_FIX_TYPE_PPP        = 8    # PPP, 3D position~%uint8 fix_type      # [GPS_FIX_TYPE] GPS fix type~%~%uint8 gps_id        # ID of the GPS for multiple GPS inputs~%uint16 ignore_flags # Bitmap indicating which GPS input flags fields to ignore. All other fields must be provided.~%~%uint32 time_week_ms # [ms] GPS time (from start of GPS week)~%uint16 time_week    # GPS week number~%int32 lat           # [degE7] Latitude (WGS84, EGM96 ellipsoid)~%int32 lon           # [degE7] Longitude (WGS84, EGM96 ellipsoid)~%float32 alt         # [m] Altitude (MSL). Positive for up.~%~%float32 hdop        # [m] GPS HDOP horizontal dilution of position.~%float32 vdop        # [m] GPS VDOP vertical dilution of position~%float32 vn          # [m/s] GPS velocity in NORTH direction in earth-fixed NED frame~%float32 ve          # [m/s] GPS velocity in EAST direction in earth-fixed NED frame~%float32 vd          # [m/s] GPS velocity in DOWN direction in earth-fixed NED frame~%~%float32 speed_accuracy # [m/s] GPS speed accuracy~%float32 horiz_accuracy # [m] GPS horizontal accuracy~%float32 vert_accuracy  # [m] GPS vertical accuracy~%~%uint8 satellites_visible # Number of satellites visible. If unknown, set to 255~%uint16 yaw          # [cdeg] Yaw in earth frame from north.~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GPSINPUT>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     2
     4
     2
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     1
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GPSINPUT>))
  "Converts a ROS message object to a list"
  (cl:list 'GPSINPUT
    (cl:cons ':header (header msg))
    (cl:cons ':fix_type (fix_type msg))
    (cl:cons ':gps_id (gps_id msg))
    (cl:cons ':ignore_flags (ignore_flags msg))
    (cl:cons ':time_week_ms (time_week_ms msg))
    (cl:cons ':time_week (time_week msg))
    (cl:cons ':lat (lat msg))
    (cl:cons ':lon (lon msg))
    (cl:cons ':alt (alt msg))
    (cl:cons ':hdop (hdop msg))
    (cl:cons ':vdop (vdop msg))
    (cl:cons ':vn (vn msg))
    (cl:cons ':ve (ve msg))
    (cl:cons ':vd (vd msg))
    (cl:cons ':speed_accuracy (speed_accuracy msg))
    (cl:cons ':horiz_accuracy (horiz_accuracy msg))
    (cl:cons ':vert_accuracy (vert_accuracy msg))
    (cl:cons ':satellites_visible (satellites_visible msg))
    (cl:cons ':yaw (yaw msg))
))
