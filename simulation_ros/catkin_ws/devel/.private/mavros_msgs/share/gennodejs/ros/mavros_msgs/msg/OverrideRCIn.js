// Auto-generated. Do not edit!

// (in-package mavros_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class OverrideRCIn {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.channels = null;
    }
    else {
      if (initObj.hasOwnProperty('channels')) {
        this.channels = initObj.channels
      }
      else {
        this.channels = new Array(18).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type OverrideRCIn
    // Check that the constant length array field [channels] has the right length
    if (obj.channels.length !== 18) {
      throw new Error('Unable to serialize array field channels - length must be 18')
    }
    // Serialize message field [channels]
    bufferOffset = _arraySerializer.uint16(obj.channels, buffer, bufferOffset, 18);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type OverrideRCIn
    let len;
    let data = new OverrideRCIn(null);
    // Deserialize message field [channels]
    data.channels = _arrayDeserializer.uint16(buffer, bufferOffset, 18)
    return data;
  }

  static getMessageSize(object) {
    return 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mavros_msgs/OverrideRCIn';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fd1e1c08fa504ec32737c41f45223398';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Override RC Input
    # Currently MAVLink defines override for 18 channels
    
    # https://mavlink.io/en/messages/common.html#RC_CHANNELS_OVERRIDE
    
    uint16 CHAN_RELEASE=0
    uint16 CHAN_NOCHANGE=65535
    
    uint16[18] channels
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new OverrideRCIn(null);
    if (msg.channels !== undefined) {
      resolved.channels = msg.channels;
    }
    else {
      resolved.channels = new Array(18).fill(0)
    }

    return resolved;
    }
};

// Constants for message
OverrideRCIn.Constants = {
  CHAN_RELEASE: 0,
  CHAN_NOCHANGE: 65535,
}

module.exports = OverrideRCIn;
