// MESSAGE STORM32_GIMBAL_MANAGER_STATUS support class

#pragma once

namespace mavlink {
namespace storm32 {
namespace msg {

/**
 * @brief STORM32_GIMBAL_MANAGER_STATUS message
 *
 * Message reporting the current status of a gimbal manager. This message should be broadcast at a low regular rate (e.g. 1 Hz, may be increase momentarily to e.g. 5 Hz for a period of 1 sec after a change).
 */
struct STORM32_GIMBAL_MANAGER_STATUS : mavlink::Message {
    static constexpr msgid_t MSG_ID = 60011;
    static constexpr size_t LENGTH = 7;
    static constexpr size_t MIN_LENGTH = 7;
    static constexpr uint8_t CRC_EXTRA = 183;
    static constexpr auto NAME = "STORM32_GIMBAL_MANAGER_STATUS";


    uint8_t gimbal_id; /*<  Gimbal ID (component ID or 1-6 for non-MAVLink gimbal) that this gimbal manager is responsible for. */
    uint8_t supervisor; /*<  Client who is currently supervisor (0 = none). */
    uint16_t device_flags; /*<  Gimbal device flags currently applied. */
    uint16_t manager_flags; /*<  Gimbal manager flags currently applied. */
    uint8_t profile; /*<  Profile currently applied (0 = default). */


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
        ss << "  supervisor: " << +supervisor << std::endl;
        ss << "  device_flags: " << device_flags << std::endl;
        ss << "  manager_flags: " << manager_flags << std::endl;
        ss << "  profile: " << +profile << std::endl;

        return ss.str();
    }

    inline void serialize(mavlink::MsgMap &map) const override
    {
        map.reset(MSG_ID, LENGTH);

        map << device_flags;                  // offset: 0
        map << manager_flags;                 // offset: 2
        map << gimbal_id;                     // offset: 4
        map << supervisor;                    // offset: 5
        map << profile;                       // offset: 6
    }

    inline void deserialize(mavlink::MsgMap &map) override
    {
        map >> device_flags;                  // offset: 0
        map >> manager_flags;                 // offset: 2
        map >> gimbal_id;                     // offset: 4
        map >> supervisor;                    // offset: 5
        map >> profile;                       // offset: 6
    }
};

} // namespace msg
} // namespace storm32
} // namespace mavlink
