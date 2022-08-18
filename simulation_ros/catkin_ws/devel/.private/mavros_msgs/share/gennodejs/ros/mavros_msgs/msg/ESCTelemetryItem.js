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

class ESCTelemetryItem {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.temperature = null;
      this.voltage = null;
      this.current = null;
      this.totalcurrent = null;
      this.rpm = null;
      this.count = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('temperature')) {
        this.temperature = initObj.temperature
      }
      else {
        this.temperature = 0.0;
      }
      if (initObj.hasOwnProperty('voltage')) {
        this.voltage = initObj.voltage
      }
      else {
        this.voltage = 0.0;
      }
      if (initObj.hasOwnProperty('current')) {
        this.current = initObj.current
      }
      else {
        this.current = 0.0;
      }
      if (initObj.hasOwnProperty('totalcurrent')) {
        this.totalcurrent = initObj.totalcurrent
      }
      else {
        this.totalcurrent = 0.0;
      }
      if (initObj.hasOwnProperty('rpm')) {
        this.rpm = initObj.rpm
      }
      else {
        this.rpm = 0;
      }
      if (initObj.hasOwnProperty('count')) {
        this.count = initObj.count
      }
      else {
        this.count = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ESCTelemetryItem
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [temperature]
    bufferOffset = _serializer.float32(obj.temperature, buffer, bufferOffset);
    // Serialize message field [voltage]
    bufferOffset = _serializer.float32(obj.voltage, buffer, bufferOffset);
    // Serialize message field [current]
    bufferOffset = _serializer.float32(obj.current, buffer, bufferOffset);
    // Serialize message field [totalcurrent]
    bufferOffset = _serializer.float32(obj.totalcurrent, buffer, bufferOffset);
    // Serialize message field [rpm]
    bufferOffset = _serializer.int32(obj.rpm, buffer, bufferOffset);
    // Serialize message field [count]
    bufferOffset = _serializer.uint16(obj.count, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ESCTelemetryItem
    let len;
    let data = new ESCTelemetryItem(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [temperature]
    data.temperature = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [voltage]
    data.voltage = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [current]
    data.current = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [totalcurrent]
    data.totalcurrent = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rpm]
    data.rpm = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [count]
    data.count = _deserializer.uint16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 22;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mavros_msgs/ESCTelemetryItem';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a135c5d0c71a3bade75476291a42a6df';
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
    
    float32 temperature     # deg C
    float32 voltage         # V
    float32 current         # A
    float32 totalcurrent    # Ah
    int32 rpm               # -1/min
    uint16 count            # count of telemetry packets
    
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
    const resolved = new ESCTelemetryItem(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.temperature !== undefined) {
      resolved.temperature = msg.temperature;
    }
    else {
      resolved.temperature = 0.0
    }

    if (msg.voltage !== undefined) {
      resolved.voltage = msg.voltage;
    }
    else {
      resolved.voltage = 0.0
    }

    if (msg.current !== undefined) {
      resolved.current = msg.current;
    }
    else {
      resolved.current = 0.0
    }

    if (msg.totalcurrent !== undefined) {
      resolved.totalcurrent = msg.totalcurrent;
    }
    else {
      resolved.totalcurrent = 0.0
    }

    if (msg.rpm !== undefined) {
      resolved.rpm = msg.rpm;
    }
    else {
      resolved.rpm = 0
    }

    if (msg.count !== undefined) {
      resolved.count = msg.count;
    }
    else {
      resolved.count = 0
    }

    return resolved;
    }
};

module.exports = ESCTelemetryItem;
