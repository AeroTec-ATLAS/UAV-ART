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

class TerrainReport {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.latitude = null;
      this.longitude = null;
      this.spacing = null;
      this.terrain_height = null;
      this.current_height = null;
      this.pending = null;
      this.loaded = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('latitude')) {
        this.latitude = initObj.latitude
      }
      else {
        this.latitude = 0.0;
      }
      if (initObj.hasOwnProperty('longitude')) {
        this.longitude = initObj.longitude
      }
      else {
        this.longitude = 0.0;
      }
      if (initObj.hasOwnProperty('spacing')) {
        this.spacing = initObj.spacing
      }
      else {
        this.spacing = 0;
      }
      if (initObj.hasOwnProperty('terrain_height')) {
        this.terrain_height = initObj.terrain_height
      }
      else {
        this.terrain_height = 0.0;
      }
      if (initObj.hasOwnProperty('current_height')) {
        this.current_height = initObj.current_height
      }
      else {
        this.current_height = 0.0;
      }
      if (initObj.hasOwnProperty('pending')) {
        this.pending = initObj.pending
      }
      else {
        this.pending = 0;
      }
      if (initObj.hasOwnProperty('loaded')) {
        this.loaded = initObj.loaded
      }
      else {
        this.loaded = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TerrainReport
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [latitude]
    bufferOffset = _serializer.float64(obj.latitude, buffer, bufferOffset);
    // Serialize message field [longitude]
    bufferOffset = _serializer.float64(obj.longitude, buffer, bufferOffset);
    // Serialize message field [spacing]
    bufferOffset = _serializer.uint16(obj.spacing, buffer, bufferOffset);
    // Serialize message field [terrain_height]
    bufferOffset = _serializer.float32(obj.terrain_height, buffer, bufferOffset);
    // Serialize message field [current_height]
    bufferOffset = _serializer.float32(obj.current_height, buffer, bufferOffset);
    // Serialize message field [pending]
    bufferOffset = _serializer.uint16(obj.pending, buffer, bufferOffset);
    // Serialize message field [loaded]
    bufferOffset = _serializer.uint16(obj.loaded, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TerrainReport
    let len;
    let data = new TerrainReport(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [latitude]
    data.latitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [longitude]
    data.longitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [spacing]
    data.spacing = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [terrain_height]
    data.terrain_height = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [current_height]
    data.current_height = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pending]
    data.pending = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [loaded]
    data.loaded = _deserializer.uint16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 30;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mavros_msgs/TerrainReport';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'f658be3a775aa38d678b427733ae0139';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Message for TERRAIN_REPORT
    # https://mavlink.io/en/messages/common.html#TERRAIN_REPORT
    
    std_msgs/Header header
    
    float64 latitude
    float64 longitude
    uint16 spacing
    float32 terrain_height # in meters, terrain height
    float32 current_height # in meters, vehicle height above terrain
    uint16 pending
    uint16 loaded 
    
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
    const resolved = new TerrainReport(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.latitude !== undefined) {
      resolved.latitude = msg.latitude;
    }
    else {
      resolved.latitude = 0.0
    }

    if (msg.longitude !== undefined) {
      resolved.longitude = msg.longitude;
    }
    else {
      resolved.longitude = 0.0
    }

    if (msg.spacing !== undefined) {
      resolved.spacing = msg.spacing;
    }
    else {
      resolved.spacing = 0
    }

    if (msg.terrain_height !== undefined) {
      resolved.terrain_height = msg.terrain_height;
    }
    else {
      resolved.terrain_height = 0.0
    }

    if (msg.current_height !== undefined) {
      resolved.current_height = msg.current_height;
    }
    else {
      resolved.current_height = 0.0
    }

    if (msg.pending !== undefined) {
      resolved.pending = msg.pending;
    }
    else {
      resolved.pending = 0
    }

    if (msg.loaded !== undefined) {
      resolved.loaded = msg.loaded;
    }
    else {
      resolved.loaded = 0
    }

    return resolved;
    }
};

module.exports = TerrainReport;
