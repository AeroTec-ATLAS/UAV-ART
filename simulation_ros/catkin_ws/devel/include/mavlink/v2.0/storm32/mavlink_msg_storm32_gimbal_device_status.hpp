// MESSAGE STORM32_GIMBAL_DEVICE_STATUS support class

#pragma once

namespace mavlink {
namespace storm32 {
namespace msg {

/**
 * @brief STORM32_GIMBAL_DEVICE_STATUS message
 *
 * Message reporting the current status of a gimbal device. This message should be broadcasted by a gimbal device component at a low regular rate (e.g. 4 Hz). For higher rates it should be emitted with a target.
 */
struct STORM32_GIMBAL_DEVICE_STATUS : mavlink::Message {
    static constexpr msgid_t MSG_ID = 60001;
    static constexpr size_t LENGTH = 42;
    static constexpr size_t MIN_LENGTH = 42;
    static constexpr uint8_t CRC_EXTRA = 186;
    static constexpr auto NAME = "STORM32_GIMBAL_DEVICE_STATUS";


    uint8_t target_system; /*<  System ID */
    uint8_t target_component; /*<  Component ID */
    uint32_t time_boot_ms; /*< [ms] Timestamp (time since system boot). */
    uint16_t flags; /*<  Gimbal device flags currently applied. */
    std::array<float, 4> q; /*<  Quaternion components, w, x, y, z (1 0 0 0 is the null-rotation). The frame depends on the STORM32_GIMBAL_DEVICE_FLAGS_YAW_ABSOLUTE flag. */
    float angular_velocity_x; /*< [rad/s] X component of angular velocity (NaN if unknown). */
    float angular_velocity_y; /*< [rad/s] Y component of angular velocity (NaN if unknown). */
    float angular_velocity_z; /*< [rad/s] Z component of angular velocity (the frame depends on the STORM32_GIMBAL_DEVICE_FLAGS_YAW_ABSOLUTE flag, NaN if unknown). */
    float yaw_absolute; /*< [deg] Yaw in absolute frame relative to Earth's North, north is 0 (NaN if unknown). */
    uint16_t failure_flags; /*<  Failure flags (0 for no failure). */


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
        ss << "  time_boot_ms: " << time_boot_ms << std::endl;
        ss << "  flags: " << flags << std::endl;
        ss << "  q: [" << to_string(q) << "]" << std::endl;
        ss << "  angular_velocity_x: " << angular_velocity_x << std::endl;
        ss << "  angular_velocity_y: " << angular_velocity_y << std::endl;
        ss << "  angular_velocity_z: " << angular_velocity_z << std::endl;
        ss << "  yaw_absolute: " << yaw_absolute << std::endl;
        ss << "  failure_flags: " << failure_flags << std::endl;

        return ss.str();
    }

    inline void serialize(mavlink::MsgMap &map) const override
    {
        map.reset(MSG_ID, LENGTH);

        map << time_boot_ms;                  // offset: 0
        map << q;                             // offset: 4
        map << angular_velocity_x;            // offset: 20
        map << angular_velocity_y;            // offset: 24
        map << angular_velocity_z;            // offset: 28
        map << yaw_absolute;                  // offset: 32
        map << flags;                         // offset: 36
        map << failure_flags;                 // offset: 38
        map << target_system;                 // offset: 40
        map << target_component;              // offset: 41
    }

    inline void deserialize(mavlink::MsgMap &map) override
    {
        map >> time_boot_ms;                  // offset: 0
        map >> q;                             // offset: 4
        map >> angular_velocity_x;            // offset: 20
        map >> angular_velocity_y;            // offset: 24
        map >> angular_velocity_z;            // offset: 28
        map >> yaw_absolute;                  // offset: 32
        map >> flags;                         // offset: 36
        map >> failure_flags;                 // offset: 38
        map >> target_system;                 // offset: 40
        map >> target_component;              // offset: 41
    }
};

} // namespace msg
} // namespace storm32
} // namespace mavlink
