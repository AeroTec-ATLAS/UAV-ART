// MESSAGE STORM32_GIMBAL_MANAGER_CORRECT_ROLL support class

#pragma once

namespace mavlink {
namespace storm32 {
namespace msg {

/**
 * @brief STORM32_GIMBAL_MANAGER_CORRECT_ROLL message
 *
 * Message to a gimbal manager to correct the gimbal roll angle. This message is typically used to manually correct for a tilted horizon in operation. A gimbal device is never to react to this message.
 */
struct STORM32_GIMBAL_MANAGER_CORRECT_ROLL : mavlink::Message {
    static constexpr msgid_t MSG_ID = 60014;
    static constexpr size_t LENGTH = 8;
    static constexpr size_t MIN_LENGTH = 8;
    static constexpr uint8_t CRC_EXTRA = 134;
    static constexpr auto NAME = "STORM32_GIMBAL_MANAGER_CORRECT_ROLL";


    uint8_t target_system; /*<  System ID */
    uint8_t target_component; /*<  Component ID */
    uint8_t gimbal_id; /*<  Gimbal ID of the gimbal manager to address (component ID or 1-6 for non-MAVLink gimbal, 0 for all gimbals, send command multiple times for more than one but not all gimbals). */
    uint8_t client; /*<  Client which is contacting the gimbal manager (must be set). */
    float roll; /*< [rad] Roll angle (positive to roll to the right). */


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
        ss << "  roll: " << roll << std::endl;

        return ss.str();
    }

    inline void serialize(mavlink::MsgMap &map) const override
    {
        map.reset(MSG_ID, LENGTH);

        map << roll;                          // offset: 0
        map << target_system;                 // offset: 4
        map << target_component;              // offset: 5
        map << gimbal_id;                     // offset: 6
        map << client;                        // offset: 7
    }

    inline void deserialize(mavlink::MsgMap &map) override
    {
        map >> roll;                          // offset: 0
        map >> target_system;                 // offset: 4
        map >> target_component;              // offset: 5
        map >> gimbal_id;                     // offset: 6
        map >> client;                        // offset: 7
    }
};

} // namespace msg
} // namespace storm32
} // namespace mavlink
