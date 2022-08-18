// MESSAGE STORM32_GIMBAL_MANAGER_PROFILE support class

#pragma once

namespace mavlink {
namespace storm32 {
namespace msg {

/**
 * @brief STORM32_GIMBAL_MANAGER_PROFILE message
 *
 * Message to set a gimbal manager profile. A gimbal device is never to react to this command. The selected profile is reported in the STORM32_GIMBAL_MANAGER_STATUS message.
 */
struct STORM32_GIMBAL_MANAGER_PROFILE : mavlink::Message {
    static constexpr msgid_t MSG_ID = 60015;
    static constexpr size_t LENGTH = 22;
    static constexpr size_t MIN_LENGTH = 22;
    static constexpr uint8_t CRC_EXTRA = 78;
    static constexpr auto NAME = "STORM32_GIMBAL_MANAGER_PROFILE";


    uint8_t target_system; /*<  System ID */
    uint8_t target_component; /*<  Component ID */
    uint8_t gimbal_id; /*<  Gimbal ID of the gimbal manager to address (component ID or 1-6 for non-MAVLink gimbal, 0 for all gimbals, send command multiple times for more than one but not all gimbals). */
    uint8_t profile; /*<  Profile to be applied (0 = default). */
    std::array<uint8_t, 8> priorities; /*<  Priorities for custom profile. */
    uint8_t profile_flags; /*<  Profile flags for custom profile (0 = default). */
    uint8_t rc_timeout; /*<  Rc timeouts for custom profile (0 = infinite, in uints of 100 ms). */
    std::array<uint8_t, 8> timeouts; /*<  Timeouts for custom profile (0 = infinite, in uints of 100 ms). */


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
        ss << "  profile: " << +profile << std::endl;
        ss << "  priorities: [" << to_string(priorities) << "]" << std::endl;
        ss << "  profile_flags: " << +profile_flags << std::endl;
        ss << "  rc_timeout: " << +rc_timeout << std::endl;
        ss << "  timeouts: [" << to_string(timeouts) << "]" << std::endl;

        return ss.str();
    }

    inline void serialize(mavlink::MsgMap &map) const override
    {
        map.reset(MSG_ID, LENGTH);

        map << target_system;                 // offset: 0
        map << target_component;              // offset: 1
        map << gimbal_id;                     // offset: 2
        map << profile;                       // offset: 3
        map << priorities;                    // offset: 4
        map << profile_flags;                 // offset: 12
        map << rc_timeout;                    // offset: 13
        map << timeouts;                      // offset: 14
    }

    inline void deserialize(mavlink::MsgMap &map) override
    {
        map >> target_system;                 // offset: 0
        map >> target_component;              // offset: 1
        map >> gimbal_id;                     // offset: 2
        map >> profile;                       // offset: 3
        map >> priorities;                    // offset: 4
        map >> profile_flags;                 // offset: 12
        map >> rc_timeout;                    // offset: 13
        map >> timeouts;                      // offset: 14
    }
};

} // namespace msg
} // namespace storm32
} // namespace mavlink
