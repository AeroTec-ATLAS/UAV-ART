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

class NavControllerOutput {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.nav_roll = null;
      this.nav_pitch = null;
      this.nav_bearing = null;
      this.target_bearing = null;
      this.wp_dist = null;
      this.alt_error = null;
      this.aspd_error = null;
      this.xtrack_error = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('nav_roll')) {
        this.nav_roll = initObj.nav_roll
      }
      else {
        this.nav_roll = 0.0;
      }
      if (initObj.hasOwnProperty('nav_pitch')) {
        this.nav_pitch = initObj.nav_pitch
      }
      else {
        this.nav_pitch = 0.0;
      }
      if (initObj.hasOwnProperty('nav_bearing')) {
        this.nav_bearing = initObj.nav_bearing
      }
      else {
        this.nav_bearing = 0;
      }
      if (initObj.hasOwnProperty('target_bearing')) {
        this.target_bearing = initObj.target_bearing
      }
      else {
        this.target_bearing = 0;
      }
      if (initObj.hasOwnProperty('wp_dist')) {
        this.wp_dist = initObj.wp_dist
      }
      else {
        this.wp_dist = 0;
      }
      if (initObj.hasOwnProperty('alt_error')) {
        this.alt_error = initObj.alt_error
      }
      else {
        this.alt_error = 0.0;
      }
      if (initObj.hasOwnProperty('aspd_error')) {
        this.aspd_error = initObj.aspd_error
      }
      else {
        this.aspd_error = 0.0;
      }
      if (initObj.hasOwnProperty('xtrack_error')) {
        this.xtrack_error = initObj.xtrack_error
      }
      else {
        this.xtrack_error = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type NavControllerOutput
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [nav_roll]
    bufferOffset = _serializer.float32(obj.nav_roll, buffer, bufferOffset);
    // Serialize message field [nav_pitch]
    bufferOffset = _serializer.float32(obj.nav_pitch, buffer, bufferOffset);
    // Serialize message field [nav_bearing]
    bufferOffset = _serializer.int16(obj.nav_bearing, buffer, bufferOffset);
    // Serialize message field [target_bearing]
    bufferOffset = _serializer.int16(obj.target_bearing, buffer, bufferOffset);
    // Serialize message field [wp_dist]
    bufferOffset = _serializer.uint16(obj.wp_dist, buffer, bufferOffset);
    // Serialize message field [alt_error]
    bufferOffset = _serializer.float32(obj.alt_error, buffer, bufferOffset);
    // Serialize message field [aspd_error]
    bufferOffset = _serializer.float32(obj.aspd_error, buffer, bufferOffset);
    // Serialize message field [xtrack_error]
    bufferOffset = _serializer.float32(obj.xtrack_error, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type NavControllerOutput
    let len;
    let data = new NavControllerOutput(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [nav_roll]
    data.nav_roll = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [nav_pitch]
    data.nav_pitch = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [nav_bearing]
    data.nav_bearing = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [target_bearing]
    data.target_bearing = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [wp_dist]
    data.wp_dist = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [alt_error]
    data.alt_error = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [aspd_error]
    data.aspd_error = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [xtrack_error]
    data.xtrack_error = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 26;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mavros_msgs/NavControllerOutput';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f6340c9bb79e3ac2a6142ce592e66756';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # https://mavlink.io/en/messages/common.html#NAV_CONTROLLER_OUTPUT
    
    std_msgs/Header header
    
    float32 nav_roll            # Current desired roll
    float32 nav_pitch           # Current desired pitch
    int16 nav_bearing           # Current desired heading
    int16 target_bearing        # Bearing to current waypoint/target
    uint16 wp_dist              # Distance to active waypoint
    float32 alt_error           # Current altitude error
    float32 aspd_error          # Current airspeed error
    float32 xtrack_error        # Current crosstrack error on x-y plane
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
    const resolved = new NavControllerOutput(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.nav_roll !== undefined) {
      resolved.nav_roll = msg.nav_roll;
    }
    else {
      resolved.nav_roll = 0.0
    }

    if (msg.nav_pitch !== undefined) {
      resolved.nav_pitch = msg.nav_pitch;
    }
    else {
      resolved.nav_pitch = 0.0
    }

    if (msg.nav_bearing !== undefined) {
      resolved.nav_bearing = msg.nav_bearing;
    }
    else {
      resolved.nav_bearing = 0
    }

    if (msg.target_bearing !== undefined) {
      resolved.target_bearing = msg.target_bearing;
    }
    else {
      resolved.target_bearing = 0
    }

    if (msg.wp_dist !== undefined) {
      resolved.wp_dist = msg.wp_dist;
    }
    else {
      resolved.wp_dist = 0
    }

    if (msg.alt_error !== undefined) {
      resolved.alt_error = msg.alt_error;
    }
    else {
      resolved.alt_error = 0.0
    }

    if (msg.aspd_error !== undefined) {
      resolved.aspd_error = msg.aspd_error;
    }
    else {
      resolved.aspd_error = 0.0
    }

    if (msg.xtrack_error !== undefined) {
      resolved.xtrack_error = msg.xtrack_error;
    }
    else {
      resolved.xtrack_error = 0.0
    }

    return resolved;
    }
};

module.exports = NavControllerOutput;
