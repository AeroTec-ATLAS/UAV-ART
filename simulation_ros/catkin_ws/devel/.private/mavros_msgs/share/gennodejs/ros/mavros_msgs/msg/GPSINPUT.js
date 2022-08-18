// Auto-generated. Do not edit!

// (in-package mavros_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class GPSINPUT {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.fix_type = null;
      this.gps_id = null;
      this.ignore_flags = null;
      this.time_week_ms = null;
      this.time_week = null;
      this.lat = null;
      this.lon = null;
      this.alt = null;
      this.hdop = null;
      this.vdop = null;
      this.vn = null;
      this.ve = null;
      this.vd = null;
      this.speed_accuracy = null;
      this.horiz_accuracy = null;
      this.vert_accuracy = null;
      this.satellites_visible = null;
      this.yaw = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('fix_type')) {
        this.fix_type = initObj.fix_type
      }
      else {
        this.fix_type = 0;
      }
      if (initObj.hasOwnProperty('gps_id')) {
        this.gps_id = initObj.gps_id
      }
      else {
        this.gps_id = 0;
      }
      if (initObj.hasOwnProperty('ignore_flags')) {
        this.ignore_flags = initObj.ignore_flags
      }
      else {
        this.ignore_flags = 0;
      }
      if (initObj.hasOwnProperty('time_week_ms')) {
        this.time_week_ms = initObj.time_week_ms
      }
      else {
        this.time_week_ms = 0;
      }
      if (initObj.hasOwnProperty('time_week')) {
        this.time_week = initObj.time_week
      }
      else {
        this.time_week = 0;
      }
      if (initObj.hasOwnProperty('lat')) {
        this.lat = initObj.lat
      }
      else {
        this.lat = 0;
      }
      if (initObj.hasOwnProperty('lon')) {
        this.lon = initObj.lon
      }
      else {
        this.lon = 0;
      }
      if (initObj.hasOwnProperty('alt')) {
        this.alt = initObj.alt
      }
      else {
        this.alt = 0.0;
      }
      if (initObj.hasOwnProperty('hdop')) {
        this.hdop = initObj.hdop
      }
      else {
        this.hdop = 0.0;
      }
      if (initObj.hasOwnProperty('vdop')) {
        this.vdop = initObj.vdop
      }
      else {
        this.vdop = 0.0;
      }
      if (initObj.hasOwnProperty('vn')) {
        this.vn = initObj.vn
      }
      else {
        this.vn = 0.0;
      }
      if (initObj.hasOwnProperty('ve')) {
        this.ve = initObj.ve
      }
      else {
        this.ve = 0.0;
      }
      if (initObj.hasOwnProperty('vd')) {
        this.vd = initObj.vd
      }
      else {
        this.vd = 0.0;
      }
      if (initObj.hasOwnProperty('speed_accuracy')) {
        this.speed_accuracy = initObj.speed_accuracy
      }
      else {
        this.speed_accuracy = 0.0;
      }
      if (initObj.hasOwnProperty('horiz_accuracy')) {
        this.horiz_accuracy = initObj.horiz_accuracy
      }
      else {
        this.horiz_accuracy = 0.0;
      }
      if (initObj.hasOwnProperty('vert_accuracy')) {
        this.vert_accuracy = initObj.vert_accuracy
      }
      else {
        this.vert_accuracy = 0.0;
      }
      if (initObj.hasOwnProperty('satellites_visible')) {
        this.satellites_visible = initObj.satellites_visible
      }
      else {
        this.satellites_visible = 0;
      }
      if (initObj.hasOwnProperty('yaw')) {
        this.yaw = initObj.yaw
      }
      else {
        this.yaw = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GPSINPUT
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [fix_type]
    bufferOffset = _serializer.uint8(obj.fix_type, buffer, bufferOffset);
    // Serialize message field [gps_id]
    bufferOffset = _serializer.uint8(obj.gps_id, buffer, bufferOffset);
    // Serialize message field [ignore_flags]
    bufferOffset = _serializer.uint16(obj.ignore_flags, buffer, bufferOffset);
    // Serialize message field [time_week_ms]
    bufferOffset = _serializer.uint32(obj.time_week_ms, buffer, bufferOffset);
    // Serialize message field [time_week]
    bufferOffset = _serializer.uint16(obj.time_week, buffer, bufferOffset);
    // Serialize message field [lat]
    bufferOffset = _serializer.int32(obj.lat, buffer, bufferOffset);
    // Serialize message field [lon]
    bufferOffset = _serializer.int32(obj.lon, buffer, bufferOffset);
    // Serialize message field [alt]
    bufferOffset = _serializer.float32(obj.alt, buffer, bufferOffset);
    // Serialize message field [hdop]
    bufferOffset = _serializer.float32(obj.hdop, buffer, bufferOffset);
    // Serialize message field [vdop]
    bufferOffset = _serializer.float32(obj.vdop, buffer, bufferOffset);
    // Serialize message field [vn]
    bufferOffset = _serializer.float32(obj.vn, buffer, bufferOffset);
    // Serialize message field [ve]
    bufferOffset = _serializer.float32(obj.ve, buffer, bufferOffset);
    // Serialize message field [vd]
    bufferOffset = _serializer.float32(obj.vd, buffer, bufferOffset);
    // Serialize message field [speed_accuracy]
    bufferOffset = _serializer.float32(obj.speed_accuracy, buffer, bufferOffset);
    // Serialize message field [horiz_accuracy]
    bufferOffset = _serializer.float32(obj.horiz_accuracy, buffer, bufferOffset);
    // Serialize message field [vert_accuracy]
    bufferOffset = _serializer.float32(obj.vert_accuracy, buffer, bufferOffset);
    // Serialize message field [satellites_visible]
    bufferOffset = _serializer.uint8(obj.satellites_visible, buffer, bufferOffset);
    // Serialize message field [yaw]
    bufferOffset = _serializer.uint16(obj.yaw, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GPSINPUT
    let len;
    let data = new GPSINPUT(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [fix_type]
    data.fix_type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [gps_id]
    data.gps_id = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [ignore_flags]
    data.ignore_flags = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [time_week_ms]
    data.time_week_ms = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [time_week]
    data.time_week = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [lat]
    data.lat = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [lon]
    data.lon = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [alt]
    data.alt = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [hdop]
    data.hdop = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vdop]
    data.vdop = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vn]
    data.vn = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ve]
    data.ve = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vd]
    data.vd = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [speed_accuracy]
    data.speed_accuracy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [horiz_accuracy]
    data.horiz_accuracy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [vert_accuracy]
    data.vert_accuracy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [satellites_visible]
    data.satellites_visible = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [yaw]
    data.yaw = _deserializer.uint16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 57;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mavros_msgs/GPSINPUT';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '928ef4ffec7b9af7c6e4748f0542b6a0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # FCU GPS INPUT message for the gps_input plugin
    # <a href="https://mavlink.io/en/messages/common.html#GPS_INPUT">mavlink GPS_INPUT message</a>.
    
    std_msgs/Header header
    ## GPS_FIX_TYPE enum
    uint8 GPS_FIX_TYPE_NO_GPS     = 0    # No GPS connected
    uint8 GPS_FIX_TYPE_NO_FIX     = 1    # No position information, GPS is connected
    uint8 GPS_FIX_TYPE_2D_FIX     = 2    # 2D position
    uint8 GPS_FIX_TYPE_3D_FIX     = 3    # 3D position
    uint8 GPS_FIX_TYPE_DGPS       = 4    # DGPS/SBAS aided 3D position
    uint8 GPS_FIX_TYPE_RTK_FLOATR = 5    # TK float, 3D position
    uint8 GPS_FIX_TYPE_RTK_FIXEDR = 6    # TK Fixed, 3D position
    uint8 GPS_FIX_TYPE_STATIC     = 7    # Static fixed, typically used for base stations
    uint8 GPS_FIX_TYPE_PPP        = 8    # PPP, 3D position
    uint8 fix_type      # [GPS_FIX_TYPE] GPS fix type
    
    uint8 gps_id        # ID of the GPS for multiple GPS inputs
    uint16 ignore_flags # Bitmap indicating which GPS input flags fields to ignore. All other fields must be provided.
    
    uint32 time_week_ms # [ms] GPS time (from start of GPS week)
    uint16 time_week    # GPS week number
    int32 lat           # [degE7] Latitude (WGS84, EGM96 ellipsoid)
    int32 lon           # [degE7] Longitude (WGS84, EGM96 ellipsoid)
    float32 alt         # [m] Altitude (MSL). Positive for up.
    
    float32 hdop        # [m] GPS HDOP horizontal dilution of position.
    float32 vdop        # [m] GPS VDOP vertical dilution of position
    float32 vn          # [m/s] GPS velocity in NORTH direction in earth-fixed NED frame
    float32 ve          # [m/s] GPS velocity in EAST direction in earth-fixed NED frame
    float32 vd          # [m/s] GPS velocity in DOWN direction in earth-fixed NED frame
    
    float32 speed_accuracy # [m/s] GPS speed accuracy
    float32 horiz_accuracy # [m] GPS horizontal accuracy
    float32 vert_accuracy  # [m] GPS vertical accuracy
    
    uint8 satellites_visible # Number of satellites visible. If unknown, set to 255
    uint16 yaw          # [cdeg] Yaw in earth frame from north.
    
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GPSINPUT(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.fix_type !== undefined) {
      resolved.fix_type = msg.fix_type;
    }
    else {
      resolved.fix_type = 0
    }

    if (msg.gps_id !== undefined) {
      resolved.gps_id = msg.gps_id;
    }
    else {
      resolved.gps_id = 0
    }

    if (msg.ignore_flags !== undefined) {
      resolved.ignore_flags = msg.ignore_flags;
    }
    else {
      resolved.ignore_flags = 0
    }

    if (msg.time_week_ms !== undefined) {
      resolved.time_week_ms = msg.time_week_ms;
    }
    else {
      resolved.time_week_ms = 0
    }

    if (msg.time_week !== undefined) {
      resolved.time_week = msg.time_week;
    }
    else {
      resolved.time_week = 0
    }

    if (msg.lat !== undefined) {
      resolved.lat = msg.lat;
    }
    else {
      resolved.lat = 0
    }

    if (msg.lon !== undefined) {
      resolved.lon = msg.lon;
    }
    else {
      resolved.lon = 0
    }

    if (msg.alt !== undefined) {
      resolved.alt = msg.alt;
    }
    else {
      resolved.alt = 0.0
    }

    if (msg.hdop !== undefined) {
      resolved.hdop = msg.hdop;
    }
    else {
      resolved.hdop = 0.0
    }

    if (msg.vdop !== undefined) {
      resolved.vdop = msg.vdop;
    }
    else {
      resolved.vdop = 0.0
    }

    if (msg.vn !== undefined) {
      resolved.vn = msg.vn;
    }
    else {
      resolved.vn = 0.0
    }

    if (msg.ve !== undefined) {
      resolved.ve = msg.ve;
    }
    else {
      resolved.ve = 0.0
    }

    if (msg.vd !== undefined) {
      resolved.vd = msg.vd;
    }
    else {
      resolved.vd = 0.0
    }

    if (msg.speed_accuracy !== undefined) {
      resolved.speed_accuracy = msg.speed_accuracy;
    }
    else {
      resolved.speed_accuracy = 0.0
    }

    if (msg.horiz_accuracy !== undefined) {
      resolved.horiz_accuracy = msg.horiz_accuracy;
    }
    else {
      resolved.horiz_accuracy = 0.0
    }

    if (msg.vert_accuracy !== undefined) {
      resolved.vert_accuracy = msg.vert_accuracy;
    }
    else {
      resolved.vert_accuracy = 0.0
    }

    if (msg.satellites_visible !== undefined) {
      resolved.satellites_visible = msg.satellites_visible;
    }
    else {
      resolved.satellites_visible = 0
    }

    if (msg.yaw !== undefined) {
      resolved.yaw = msg.yaw;
    }
    else {
      resolved.yaw = 0
    }

    return resolved;
    }
};

// Constants for message
GPSINPUT.Constants = {
  GPS_FIX_TYPE_NO_GPS: 0,
  GPS_FIX_TYPE_NO_FIX: 1,
  GPS_FIX_TYPE_2D_FIX: 2,
  GPS_FIX_TYPE_3D_FIX: 3,
  GPS_FIX_TYPE_DGPS: 4,
  GPS_FIX_TYPE_RTK_FLOATR: 5,
  GPS_FIX_TYPE_RTK_FIXEDR: 6,
  GPS_FIX_TYPE_STATIC: 7,
  GPS_FIX_TYPE_PPP: 8,
}

module.exports = GPSINPUT;
