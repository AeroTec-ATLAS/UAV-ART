// MESSAGE STORM32_GIMBAL_MANAGER_INFORMATION support class

#pragma once

namespace mavlink {
namespace storm32 {
namespace msg {

/**
 * @brief STORM32_GIMBAL_MANAGER_INFORMATION message
 *
 * Information about a gimbal manager. This message should be requested by a ground station using MAV_CMD_REQUEST_MESSAGE. It mirrors some fields of the STORM32_GIMBAL_DEVICE_INFORMATION message, but not all. If the additional information is desired, also STORM32_GIMBAL_DEVICE_INFORMATION should be requested.
 */
struct STORM32_GIMBAL_MANAGER_INFORMATION : mavlink::Message {
    static constexpr msgid_t MSG_ID = 60010;
    static constexpr size_t LENGTH = 33;
    static constexpr size_t MIN_LENGTH = 33;
    static constexpr uint8_t CRC_EXTRA = 208;
    static constexpr auto NAME = "STORM32_GIMBAL_MANAGER_INFORMATION";


    uint8_t gimbal_id; /*<  Gimbal ID (component ID or 1-6 for non-MAVLink gimbal) that this gimbal manager is responsible for. */
    uint32_t device_cap_flags; /*<  Gimbal device capability flags. */
    uint32_t manager_cap_flags; /*<  Gimbal manager capability flags. */
    float roll_min; /*< [rad] Hardware minimum roll angle (positive: roll to the right, NaN if unknown). */
    float roll_max; /*< [rad] Hardware maximum roll angle (positive: roll to the right, NaN if unknown). */
    float pitch_min; /*< [rad] Hardware minimum pitch/tilt angle (positive: tilt up, NaN if unknown). */
    float pitch_max; /*< [rad] Hardware maximum pitch/tilt angle (positive: tilt up, NaN if unknown). */
    float yaw_min; /*< [rad] Hardware minimum yaw/pan angle (positive: pan to the right, relative to the vehicle/gimbal base, NaN if unknown). */
    float yaw_max; /*< [rad] Hardware maximum yaw/pan angle (positive: pan to the right, relative to the vehicle/gimbal base, NaN if unknown). */


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
        ss << "  gimbal_id: " << +gimbal_id << std::endl;
        ss << "  device_cap_flags: " << device_cap_flags << std::endl;
        ss << "  manager_cap_flags: " << manager_cap_flags << std::endl;
        ss << "  roll_min: " << roll_min << std::endl;
        ss << "  roll_max: " << roll_max << std::endl;
        ss << "  pitch_min: " << pitch_min << std::endl;
        ss << "  pitch_max: " << pitch_max << std::endl;
        ss << "  yaw_min: " << yaw_min << std::endl;
        ss << "  yaw_max: " << yaw_max << std::endl;

        return ss.str();
    }

    inline void serialize(mavlink::MsgMap &map) const override
    {
        map.reset(MSG_ID, LENGTH);

        map << device_cap_flags;              // offset: 0
        map << manager_cap_flags;             // offset: 4
        map << roll_min;                      // offset: 8
        map << roll_max;                      // offset: 12
        map << pitch_min;                     // offset: 16
        map << pitch_max;                     // offset: 20
        map << yaw_min;                       // offset: 24
        map << yaw_max;                       // offset: 28
        map << gimbal_id;                     // offset: 32
    }

    inline void deserialize(mavlink::MsgMap &map) override
    {
        map >> device_cap_flags;              // offset: 0
        map >> manager_cap_flags;             // offset: 4
        map >> roll_min;                      // offset: 8
        map >> roll_max;                      // offset: 12
        map >> pitch_min;                     // offset: 16
        map >> pitch_max;                     // offset: 20
        map >> yaw_min;                       // offset: 24
        map >> yaw_max;                       // offset: 28
        map >> gimbal_id;                     // offset: 32
    }
};

} // namespace msg
} // namespace storm32
} // namespace mavlink
