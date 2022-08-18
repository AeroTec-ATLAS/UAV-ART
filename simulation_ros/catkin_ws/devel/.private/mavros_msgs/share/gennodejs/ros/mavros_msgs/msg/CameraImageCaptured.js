// Auto-generated. Do not edit!

// (in-package mavros_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');
let geographic_msgs = _finder('geographic_msgs');

//-----------------------------------------------------------

class CameraImageCaptured {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.orientation = null;
      this.geo = null;
      this.relative_alt = null;
      this.image_index = null;
      this.capture_result = null;
      this.file_url = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('orientation')) {
        this.orientation = initObj.orientation
      }
      else {
        this.orientation = new geometry_msgs.msg.Quaternion();
      }
      if (initObj.hasOwnProperty('geo')) {
        this.geo = initObj.geo
      }
      else {
        this.geo = new geographic_msgs.msg.GeoPoint();
      }
      if (initObj.hasOwnProperty('relative_alt')) {
        this.relative_alt = initObj.relative_alt
      }
      else {
        this.relative_alt = 0.0;
      }
      if (initObj.hasOwnProperty('image_index')) {
        this.image_index = initObj.image_index
      }
      else {
        this.image_index = 0;
      }
      if (initObj.hasOwnProperty('capture_result')) {
        this.capture_result = initObj.capture_result
      }
      else {
        this.capture_result = 0;
      }
      if (initObj.hasOwnProperty('file_url')) {
        this.file_url = initObj.file_url
      }
      else {
        this.file_url = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type CameraImageCaptured
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [orientation]
    bufferOffset = geometry_msgs.msg.Quaternion.serialize(obj.orientation, buffer, bufferOffset);
    // Serialize message field [geo]
    bufferOffset = geographic_msgs.msg.GeoPoint.serialize(obj.geo, buffer, bufferOffset);
    // Serialize message field [relative_alt]
    bufferOffset = _serializer.float32(obj.relative_alt, buffer, bufferOffset);
    // Serialize message field [image_index]
    bufferOffset = _serializer.int32(obj.image_index, buffer, bufferOffset);
    // Serialize message field [capture_result]
    bufferOffset = _serializer.int8(obj.capture_result, buffer, bufferOffset);
    // Serialize message field [file_url]
    bufferOffset = _serializer.string(obj.file_url, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type CameraImageCaptured
    let len;
    let data = new CameraImageCaptured(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [orientation]
    data.orientation = geometry_msgs.msg.Quaternion.deserialize(buffer, bufferOffset);
    // Deserialize message field [geo]
    data.geo = geographic_msgs.msg.GeoPoint.deserialize(buffer, bufferOffset);
    // Deserialize message field [relative_alt]
    data.relative_alt = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [image_index]
    data.image_index = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [capture_result]
    data.capture_result = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [file_url]
    data.file_url = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += object.file_url.length;
    return length + 69;
  }

  static datatype() {
    // Returns string type for a message object
    return 'mavros_msgs/CameraImageCaptured';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9559d135fc7e5e91d3f1b819ebcd7556';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # MAVLink message: CAMERA_IMAGE_CAPTURED
    # https://mavlink.io/en/messages/common.html#CAMERA_IMAGE_CAPTURED
    
    std_msgs/Header header
    
    geometry_msgs/Quaternion orientation	# Quaternion of camera orientation (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
    geographic_msgs/GeoPoint geo
    float32 relative_alt	# mm	Altitude above ground
    int32 image_index # Zero based index of this image (i.e. a new image will have index CAMERA_CAPTURE_STATUS.image count -1)
    int8 capture_result # Boolean indicating success (1) or failure (0) while capturing this image.
    string file_url #URL of image taken. Either local storage or http://foo.jpg if camera provides an HTTP interface.
    
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
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    ================================================================================
    MSG: geographic_msgs/GeoPoint
    # Geographic point, using the WGS 84 reference ellipsoid.
    
    # Latitude [degrees]. Positive is north of equator; negative is south
    # (-90 <= latitude <= +90).
    float64 latitude
    
    # Longitude [degrees]. Positive is east of prime meridian; negative is
    # west (-180 <= longitude <= +180). At the poles, latitude is -90 or
    # +90, and longitude is irrelevant, but must be in range.
    float64 longitude
    
    # Altitude [m]. Positive is above the WGS 84 ellipsoid (NaN if unspecified).
    float64 altitude
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new CameraImageCaptured(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.orientation !== undefined) {
      resolved.orientation = geometry_msgs.msg.Quaternion.Resolve(msg.orientation)
    }
    else {
      resolved.orientation = new geometry_msgs.msg.Quaternion()
    }

    if (msg.geo !== undefined) {
      resolved.geo = geographic_msgs.msg.GeoPoint.Resolve(msg.geo)
    }
    else {
      resolved.geo = new geographic_msgs.msg.GeoPoint()
    }

    if (msg.relative_alt !== undefined) {
      resolved.relative_alt = msg.relative_alt;
    }
    else {
      resolved.relative_alt = 0.0
    }

    if (msg.image_index !== undefined) {
      resolved.image_index = msg.image_index;
    }
    else {
      resolved.image_index = 0
    }

    if (msg.capture_result !== undefined) {
      resolved.capture_result = msg.capture_result;
    }
    else {
      resolved.capture_result = 0
    }

    if (msg.file_url !== undefined) {
      resolved.file_url = msg.file_url;
    }
    else {
      resolved.file_url = ''
    }

    return resolved;
    }
};

module.exports = CameraImageCaptured;
