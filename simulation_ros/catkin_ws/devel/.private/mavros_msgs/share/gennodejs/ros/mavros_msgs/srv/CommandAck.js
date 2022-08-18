// Auto-generated. Do not edit!

// (in-package mavros_msgs.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class CommandAckRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.command = null;
      this.result = null;
      this.progress = null;
      this.result_param2 = null;
    }
    else {
      if (initObj.hasOwnProperty('command')) {
        this.command = initObj.command
      }
      else {
        this.command = 0;
      }
      if (initObj.hasOwnProperty('result')) {
        this.result = initObj.result
      }
      else {
        this.result = 0;
      }
      if (initObj.hasOwnProperty('progress')) {
        this.progress = initObj.progress
      }
      else {
        this.progress = 0;
      }
      if (initObj.hasOwnProperty('result_param2')) {
        this.result_param2 = initObj.result_param2
      }
      else {
        this.result_param2 = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CommandAckRequest
    // Serialize message field [command]
    bufferOffset = _serializer.uint16(obj.command, buffer, bufferOffset);
    // Serialize message field [result]
    bufferOffset = _serializer.uint8(obj.result, buffer, bufferOffset);
    // Serialize message field [progress]
    bufferOffset = _serializer.uint8(obj.progress, buffer, bufferOffset);
    // Serialize message field [result_param2]
    bufferOffset = _serializer.uint32(obj.result_param2, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CommandAckRequest
    let len;
    let data = new CommandAckRequest(null);
    // Deserialize message field [command]
    data.command = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [result]
    data.result = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [progress]
    data.progress = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [result_param2]
    data.result_param2 = _deserializer.uint32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'mavros_msgs/CommandAckRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1972b10ca14298d11f768e548d4d9e68';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Generic COMMAND_ACK
    
    uint16 command
    uint8 result
    uint8 progress
    uint32 result_param2
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CommandAckRequest(null);
    if (msg.command !== undefined) {
      resolved.command = msg.command;
    }
    else {
      resolved.command = 0
    }

    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = 0
    }

    if (msg.progress !== undefined) {
      resolved.progress = msg.progress;
    }
    else {
      resolved.progress = 0
    }

    if (msg.result_param2 !== undefined) {
      resolved.result_param2 = msg.result_param2;
    }
    else {
      resolved.result_param2 = 0
    }

    return resolved;
    }
};

class CommandAckResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.result = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('result')) {
        this.result = initObj.result
      }
      else {
        this.result = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CommandAckResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [result]
    bufferOffset = _serializer.uint8(obj.result, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CommandAckResponse
    let len;
    let data = new CommandAckResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [result]
    data.result = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 2;
  }

  static datatype() {
    // Returns string type for a service object
    return 'mavros_msgs/CommandAckResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '1cd894375e4e3d2861d2222772894fdb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
    # raw result returned by COMMAND_ACK
    uint8 result
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CommandAckResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.result !== undefined) {
      resolved.result = msg.result;
    }
    else {
      resolved.result = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: CommandAckRequest,
  Response: CommandAckResponse,
  md5sum() { return 'a3d0814a86c597ac57373d872df6d1d3'; },
  datatype() { return 'mavros_msgs/CommandAck'; }
};
