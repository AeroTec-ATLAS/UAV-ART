// MESSAGE STORM32_GIMBAL_DEVICE_CONTROL support class

#pragma once

namespace mavlink {
namespace storm32 {
namespace msg {

/**
 * @brief STORM32_GIMBAL_DEVICE_CONTROL message
 *
 * Message to a gimbal device to control its attitude. This message is to be sent from the gimbal manager to the gimbal device. Angles and rates can be set to NaN according to use case.
 */
struct STORM32_GIMBAL_DEVICE_CONTROL : mavlink::Message {
    static constexpr msgid_t MSG_ID = 60002;
    static constexpr size_t LENGTH = 32;
    static constexpr size_t MIN_LENGTH = 32;
    static constexpr uint8_t CRC_EXTRA = 69;
    static constexpr auto NAME = "STORM32_GIMBAL_DEVICE_CONTROL";


    uint8_t target_system; /*<  System ID */
    uint8_t target_component; /*<  Component ID */
    uint16_t flags; /*<  Gimbal device flags (UINT16_MAX to be ignored). */
    std::array<float, 4> q; /*<  Quaternion components, w, x, y, z (1 0 0 0 is the null-rotation, the frame is determined by the STORM32_GIMBAL_DEVICE_FLAGS_YAW_ABSOLUTE flag, NaN to be ignored). */
    float angular_velocity_x; /*< [rad/s] X component of angular velocity (positive: roll to the right, NaN to be ignored). */
    float angular_velocity_y; /*< [rad/s] Y component of angular velocity (positive: tilt up, NaN to be ignored). */
    float angular_velocity_z; /*< [rad/s] Z component of angular velocity (positive: pan to the right, the frame is determined by the STORM32_GIMBAL_DEVICE_FLAGS_YAW_ABSOLUTE flag, NaN to be ignored). */


    inline std::string get_name(void) const override
    {
            return NAME;
    }

    inline Info get_message_info(void) const override
    {
            return { MSG_ID, LENGTH, MIN_LENGTH, CRC_EXTRA };
    }

    inline std::string to_yaml(void) const override
    {
        std::stringstream ss;

        ss << NAME << ":" << std::endl;
        ss << "  target_system: " << +target_system << std::endl;
        ss << "  target_component: " << +target_component << std::endl;
        ss << "  flags: " << flags << std::endl;
        ss << "  q: [" << to_string(q) << "]" << std::endl;
        ss << "  angular_velocity_x: " << angular_velocity_x << std::endl;
        ss << "  angular_velocity_y: " << angular_velocity_y << std::endl;
        ss << "  angular_velocity_z: " << angular_velocity_z << std::endl;

        return ss.str();
    }

    inline void serialize(mavlink::MsgMap &map) const override
    {
        map.reset(MSG_ID, LENGTH);

        map << q;                             // offset: 0
        map << angular_velocity_x;            // offset: 16
        map << angular_velocity_y;            // offset: 20
        map << angular_velocity_z;            // offset: 24
        map << flags;                         // offset: 28
        map << target_system;                 // offset: 30
        map << target_component;              // offset: 31
    }

    inline void deserialize(mavlink::MsgMap &map) override
    {
        map >> q;                             // offset: 0
        map >> angular_velocity_x;            // offset: 16
        map >> angular_velocity_y;            // offset: 20
        map >> angular_velocity_z;            // offset: 24
        map >> flags;                         // offset: 28
        map >> target_system;                 // offset: 30
        map >> target_component;              // offset: 31
    }
};

} // namespace msg
} // namespace storm32
} // namespace mavlink
