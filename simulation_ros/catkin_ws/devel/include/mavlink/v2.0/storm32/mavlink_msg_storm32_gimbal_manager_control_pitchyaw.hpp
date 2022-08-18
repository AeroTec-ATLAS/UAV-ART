// MESSAGE STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW support class

#pragma once

namespace mavlink {
namespace storm32 {
namespace msg {

/**
 * @brief STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW message
 *
 * Message to a gimbal manager to control the gimbal tilt and pan angles. Angles and rates can be set to NaN according to use case. A gimbal device is never to react to this message.
 */
struct STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW : mavlink::Message {
    static constexpr msgid_t MSG_ID = 60013;
    static constexpr size_t LENGTH = 24;
    static constexpr size_t MIN_LENGTH = 24;
    static constexpr uint8_t CRC_EXTRA = 129;
    static constexpr auto NAME = "STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW";


    uint8_t target_system; /*<  System ID */
    uint8_t target_component; /*<  Component ID */
    uint8_t gimbal_id; /*<  Gimbal ID of the gimbal manager to address (component ID or 1-6 for non-MAVLink gimbal, 0 for all gimbals, send command multiple times for more than one but not all gimbals). */
    uint8_t client; /*<  Client which is contacting the gimbal manager (must be set). */
    uint16_t device_flags; /*<  Gimbal device flags (UINT16_MAX to be ignored). */
    uint16_t manager_flags; /*<  Gimbal manager flags (0 to be ignored). */
    float pitch; /*< [rad] Pitch/tilt angle (positive: tilt up, NaN to be ignored). */
    float yaw; /*< [rad] Yaw/pan angle (positive: pan the right, the frame is determined by the STORM32_GIMBAL_DEVICE_FLAGS_YAW_ABSOLUTE flag, NaN to be ignored). */
    float pitch_rate; /*< [rad/s] Pitch/tilt angular rate (positive: tilt up, NaN to be ignored). */
    float yaw_rate; /*< [rad/s] Yaw/pan angular rate (positive: pan to the right, the frame is determined by the STORM32_GIMBAL_DEVICE_FLAGS_YAW_ABSOLUTE flag, NaN to be ignored). */


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
        ss << "  gimbal_id: " << +gimbal_id << std::endl;
        ss << "  client: " << +client << std::endl;
        ss << "  device_flags: " << device_flags << std::endl;
        ss << "  manager_flags: " << manager_flags << std::endl;
        ss << "  pitch: " << pitch << std::endl;
        ss << "  yaw: " << yaw << std::endl;
        ss << "  pitch_rate: " << pitch_rate << std::endl;
        ss << "  yaw_rate: " << yaw_rate << std::endl;

        return ss.str();
    }

    inline void serialize(mavlink::MsgMap &map) const override
    {
        map.reset(MSG_ID, LENGTH);

        map << pitch;                         // offset: 0
        map << yaw;                           // offset: 4
        map << pitch_rate;                    // offset: 8
        map << yaw_rate;                      // offset: 12
        map << device_flags;                  // offset: 16
        map << manager_flags;                 // offset: 18
        map << target_system;                 // offset: 20
        map << target_component;              // offset: 21
        map << gimbal_id;                     // offset: 22
        map << client;                        // offset: 23
    }

    inline void deserialize(mavlink::MsgMap &map) override
    {
        map >> pitch;                         // offset: 0
        map >> yaw;                           // offset: 4
        map >> pitch_rate;                    // offset: 8
        map >> yaw_rate;                      // offset: 12
        map >> device_flags;                  // offset: 16
        map >> manager_flags;                 // offset: 18
        map >> target_system;                 // offset: 20
        map >> target_component;              // offset: 21
        map >> gimbal_id;                     // offset: 22
        map >> client;                        // offset: 23
    }
};

} // namespace msg
} // namespace storm32
} // namespace mavlink
