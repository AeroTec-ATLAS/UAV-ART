// MESSAGE QSHOT_STATUS support class

#pragma once

namespace mavlink {
namespace storm32 {
namespace msg {

/**
 * @brief QSHOT_STATUS message
 *
 * Information about the shot operation.
 */
struct QSHOT_STATUS : mavlink::Message {
    static constexpr msgid_t MSG_ID = 60020;
    static constexpr size_t LENGTH = 4;
    static constexpr size_t MIN_LENGTH = 4;
    static constexpr uint8_t CRC_EXTRA = 202;
    static constexpr auto NAME = "QSHOT_STATUS";


    uint16_t mode; /*<  Current shot mode. */
    uint16_t shot_state; /*<  Current state in the shot. States are specific to the selected shot mode. */


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
        ss << "  mode: " << mode << std::endl;
        ss << "  shot_state: " << shot_state << std::endl;

        return ss.str();
    }

    inline void serialize(mavlink::MsgMap &map) const override
    {
        map.reset(MSG_ID, LENGTH);

        map << mode;                          // offset: 0
        map << shot_state;                    // offset: 2
    }

    inline void deserialize(mavlink::MsgMap &map) override
    {
        map >> mode;                          // offset: 0
        map >> shot_state;                    // offset: 2
    }
};

} // namespace msg
} // namespace storm32
} // namespace mavlink
