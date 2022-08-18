// Auto-generated. Do not edit!

// (in-package mavros_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ESCTelemetryItem = require('./ESCTelemetryItem.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ESCTelemetry {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.esc_telemetry = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('esc_telemetry')) {
        this.esc_telemetry = initObj.esc_telemetry
      }
      else {
        this.esc_telemetry = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ESCTelemetry
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [esc_telemetry]
    // Serialize the length for message field [esc_telemetry]
    bufferOffset = _serializer.uint32(obj.esc_telemetry.length, buffer, bufferOffset);
    obj.esc_telemetry.forEach((val) => {
      bufferOffset = ESCTelemetryItem.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ESCTelemetry
    let len;
    let data = new ESCTelemetry(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [esc_telemetry]
    // Deserialize array length for message field [esc_telemetry]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.esc_telemetry = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.esc_telemetry[i] = ESCTelemetryItem.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.esc_telemetry.forEach((val) => {
      length += ESCTelemetryItem.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mavros_msgs/ESCTelemetry';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7b1fb252ca6aa175fe8dd23d029b3362';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # APM ESC Telemetry as returned by BLHeli
    #
    # See:
    # https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_1_TO_4
    # https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_5_TO_8
    # https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_9_TO_12
    
    std_msgs/Header header
    
    mavros_msgs/ESCTelemetryItem[] esc_telemetry
    
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
    MSG: mavros_msgs/ESCTelemetryItem
    # APM ESC Telemetry as returned by BLHeli
    #
    # See:
    # https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_1_TO_4
    # https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_5_TO_8
    # https://mavlink.io/en/messages/ardupilotmega.html#ESC_TELEMETRY_9_TO_12
    
    std_msgs/Header header
    
    float32 temperature     # deg C
    float32 voltage         # V
    float32 current         # A
    float32 totalcurrent    # Ah
    int32 rpm               # -1/min
    uint16 count            # count of telemetry packets
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ESCTelemetry(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.esc_telemetry !== undefined) {
      resolved.esc_telemetry = new Array(msg.esc_telemetry.length);
      for (let i = 0; i < resolved.esc_telemetry.length; ++i) {
        resolved.esc_telemetry[i] = ESCTelemetryItem.Resolve(msg.esc_telemetry[i]);
      }
    }
    else {
      resolved.esc_telemetry = []
    }

    return resolved;
    }
};

module.exports = ESCTelemetry;
