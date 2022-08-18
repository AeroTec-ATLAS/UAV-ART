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

class Tunnel {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.target_system = null;
      this.target_component = null;
      this.payload_type = null;
      this.payload_length = null;
      this.payload = null;
    }
    else {
      if (initObj.hasOwnProperty('target_system')) {
        this.target_system = initObj.target_system
      }
      else {
        this.target_system = 0;
      }
      if (initObj.hasOwnProperty('target_component')) {
        this.target_component = initObj.target_component
      }
      else {
        this.target_component = 0;
      }
      if (initObj.hasOwnProperty('payload_type')) {
        this.payload_type = initObj.payload_type
      }
      else {
        this.payload_type = 0;
      }
      if (initObj.hasOwnProperty('payload_length')) {
        this.payload_length = initObj.payload_length
      }
      else {
        this.payload_length = 0;
      }
      if (initObj.hasOwnProperty('payload')) {
        this.payload = initObj.payload
      }
      else {
        this.payload = new Array(128).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Tunnel
    // Serialize message field [target_system]
    bufferOffset = _serializer.uint8(obj.target_system, buffer, bufferOffset);
    // Serialize message field [target_component]
    bufferOffset = _serializer.uint8(obj.target_component, buffer, bufferOffset);
    // Serialize message field [payload_type]
    bufferOffset = _serializer.uint16(obj.payload_type, buffer, bufferOffset);
    // Serialize message field [payload_length]
    bufferOffset = _serializer.uint8(obj.payload_length, buffer, bufferOffset);
    // Check that the constant length array field [payload] has the right length
    if (obj.payload.length !== 128) {
      throw new Error('Unable to serialize array field payload - length must be 128')
    }
    // Serialize message field [payload]
    bufferOffset = _arraySerializer.uint8(obj.payload, buffer, bufferOffset, 128);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Tunnel
    let len;
    let data = new Tunnel(null);
    // Deserialize message field [target_system]
    data.target_system = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [target_component]
    data.target_component = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [payload_type]
    data.payload_type = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [payload_length]
    data.payload_length = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [payload]
    data.payload = _arrayDeserializer.uint8(buffer, bufferOffset, 128)
    return data;
  }

  static getMessageSize(object) {
    return 133;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mavros_msgs/Tunnel';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6d8c215067d3b319bbb219c37c1ebc5d';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Tunnel
    #
    # https://mavlink.io/en/messages/common.html#TUNNEL
    
    uint8 target_system
    uint8 target_component
    uint16 payload_type
    uint8 payload_length
    uint8[128] payload
    
    # [[[cog:
    # from pymavlink.dialects.v20 import common
    #
    # def decl_enum(ename, pfx='', bsz=8):
    #     enum = sorted(common.enums[ename].items())
    #     enum.pop() # remove ENUM_END
    #
    #     cog.outl("# " + ename)
    #     for k, e in enum:
    #         sn = e.name[len(ename) + 1:]
    #         l = "uint{bsz} {pfx}{sn} = {k}".format(**locals())
    #         if e.description:
    #             l += ' ' * (40 - len(l)) + ' # ' + e.description
    #         cog.outl(l)
    #
    # decl_enum('MAV_TUNNEL_PAYLOAD_TYPE', 'PAYLOAD_TYPE_', 16)
    # ]]]
    # MAV_TUNNEL_PAYLOAD_TYPE
    uint16 PAYLOAD_TYPE_UNKNOWN = 0          # Encoding of payload unknown.
    uint16 PAYLOAD_TYPE_STORM32_RESERVED0 = 200 # Registered for STorM32 gimbal controller.
    uint16 PAYLOAD_TYPE_STORM32_RESERVED1 = 201 # Registered for STorM32 gimbal controller.
    uint16 PAYLOAD_TYPE_STORM32_RESERVED2 = 202 # Registered for STorM32 gimbal controller.
    uint16 PAYLOAD_TYPE_STORM32_RESERVED3 = 203 # Registered for STorM32 gimbal controller.
    uint16 PAYLOAD_TYPE_STORM32_RESERVED4 = 204 # Registered for STorM32 gimbal controller.
    uint16 PAYLOAD_TYPE_STORM32_RESERVED5 = 205 # Registered for STorM32 gimbal controller.
    uint16 PAYLOAD_TYPE_STORM32_RESERVED6 = 206 # Registered for STorM32 gimbal controller.
    uint16 PAYLOAD_TYPE_STORM32_RESERVED7 = 207 # Registered for STorM32 gimbal controller.
    uint16 PAYLOAD_TYPE_STORM32_RESERVED8 = 208 # Registered for STorM32 gimbal controller.
    uint16 PAYLOAD_TYPE_STORM32_RESERVED9 = 209 # Registered for STorM32 gimbal controller.
    # [[[end]]] (checksum: 3327b212af02c2d47d940cd6de049624)
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Tunnel(null);
    if (msg.target_system !== undefined) {
      resolved.target_system = msg.target_system;
    }
    else {
      resolved.target_system = 0
    }

    if (msg.target_component !== undefined) {
      resolved.target_component = msg.target_component;
    }
    else {
      resolved.target_component = 0
    }

    if (msg.payload_type !== undefined) {
      resolved.payload_type = msg.payload_type;
    }
    else {
      resolved.payload_type = 0
    }

    if (msg.payload_length !== undefined) {
      resolved.payload_length = msg.payload_length;
    }
    else {
      resolved.payload_length = 0
    }

    if (msg.payload !== undefined) {
      resolved.payload = msg.payload;
    }
    else {
      resolved.payload = new Array(128).fill(0)
    }

    return resolved;
    }
};

// Constants for message
Tunnel.Constants = {
  PAYLOAD_TYPE_UNKNOWN: 0,
  PAYLOAD_TYPE_STORM32_RESERVED0: 200,
  PAYLOAD_TYPE_STORM32_RESERVED1: 201,
  PAYLOAD_TYPE_STORM32_RESERVED2: 202,
  PAYLOAD_TYPE_STORM32_RESERVED3: 203,
  PAYLOAD_TYPE_STORM32_RESERVED4: 204,
  PAYLOAD_TYPE_STORM32_RESERVED5: 205,
  PAYLOAD_TYPE_STORM32_RESERVED6: 206,
  PAYLOAD_TYPE_STORM32_RESERVED7: 207,
  PAYLOAD_TYPE_STORM32_RESERVED8: 208,
  PAYLOAD_TYPE_STORM32_RESERVED9: 209,
}

module.exports = Tunnel;
