// MESSAGE SENSOR_AIRFLOW_ANGLES support class

#pragma once

namespace mavlink {
namespace ASLUAV {
namespace msg {

/**
 * @brief SENSOR_AIRFLOW_ANGLES message
 *
 * Calibrated airflow angle measurements
 */
struct SENSOR_AIRFLOW_ANGLES : mavlink::Message {
    static constexpr msgid_t MSG_ID = 215;
    static constexpr size_t LENGTH = 18;
    static constexpr size_t MIN_LENGTH = 18;
    static constexpr uint8_t CRC_EXTRA = 149;
    static constexpr auto NAME = "SENSOR_AIRFLOW_ANGLES";


    uint64_t timestamp; /*< [us] Timestamp */
    float angleofattack; /*< [deg] Angle of attack */
    uint8_t angleofattack_valid; /*<  Angle of attack measurement valid */
    float sideslip; /*< [deg] Sideslip angle */
    uint8_t sideslip_valid; /*<  Sideslip angle measurement valid */


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
        ss << "  timestamp: " << timestamp << std::endl;
        ss << "  angleofattack: " << angleofattack << std::endl;
        ss << "  angleofattack_valid: " << +angleofattack_valid << std::endl;
        ss << "  sideslip: " << sideslip << std::endl;
        ss << "  sideslip_valid: " << +sideslip_valid << std::endl;

        return ss.str();
    }

    inline void serialize(mavlink::MsgMap &map) const override
    {
        map.reset(MSG_ID, LENGTH);

        map << timestamp;                     // offset: 0
        map << angleofattack;                 // offset: 8
        map << sideslip;                      // offset: 12
        map << angleofattack_valid;           // offset: 16
        map << sideslip_valid;                // offset: 17
    }

    inline void deserialize(mavlink::MsgMap &map) override
    {
        map >> timestamp;                     // offset: 0
        map >> angleofattack;                 // offset: 8
        map >> sideslip;                      // offset: 12
        map >> angleofattack_valid;           // offset: 16
        map >> sideslip_valid;                // offset: 17
    }
};

} // namespace msg
} // namespace ASLUAV
} // namespace mavlink
