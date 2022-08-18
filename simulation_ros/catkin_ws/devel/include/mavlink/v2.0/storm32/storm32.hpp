/** @file
 *	@brief MAVLink comm protocol generated from storm32.xml
 *	@see http://mavlink.org
 */

#pragma once

#include <array>
#include <cstdint>
#include <sstream>

#ifndef MAVLINK_STX
#define MAVLINK_STX 253
#endif

#include "../message.hpp"

namespace mavlink {
namespace storm32 {

/**
 * Array of msg_entry needed for @p mavlink_parse_char() (trought @p mavlink_get_msg_entry())
 */
constexpr std::array<mavlink_msg_entry_t, 289> MESSAGE_ENTRIES {{ {0, 50, 9, 9, 0, 0, 0}, {1, 124, 31, 31, 0, 0, 0}, {2, 137, 12, 12, 0, 0, 0}, {4, 237, 14, 14, 3, 12, 13}, {5, 217, 28, 28, 1, 0, 0}, {6, 104, 3, 3, 0, 0, 0}, {7, 119, 32, 32, 0, 0, 0}, {8, 117, 36, 36, 0, 0, 0}, {11, 89, 6, 6, 1, 4, 0}, {19, 137, 24, 24, 3, 4, 5}, {20, 214, 20, 20, 3, 2, 3}, {21, 159, 2, 2, 3, 0, 1}, {22, 220, 25, 25, 0, 0, 0}, {23, 168, 23, 23, 3, 4, 5}, {24, 24, 30, 52, 0, 0, 0}, {25, 23, 101, 101, 0, 0, 0}, {26, 170, 22, 24, 0, 0, 0}, {27, 144, 26, 29, 0, 0, 0}, {28, 67, 16, 16, 0, 0, 0}, {29, 115, 14, 16, 0, 0, 0}, {30, 39, 28, 28, 0, 0, 0}, {31, 246, 32, 48, 0, 0, 0}, {32, 185, 28, 28, 0, 0, 0}, {33, 104, 28, 28, 0, 0, 0}, {34, 237, 22, 22, 0, 0, 0}, {35, 244, 22, 22, 0, 0, 0}, {36, 222, 21, 37, 0, 0, 0}, {37, 212, 6, 7, 3, 4, 5}, {38, 9, 6, 7, 3, 4, 5}, {39, 254, 37, 38, 3, 32, 33}, {40, 230, 4, 5, 3, 2, 3}, {41, 28, 4, 4, 3, 2, 3}, {42, 28, 2, 2, 0, 0, 0}, {43, 132, 2, 3, 3, 0, 1}, {44, 221, 4, 5, 3, 2, 3}, {45, 232, 2, 3, 3, 0, 1}, {46, 11, 2, 2, 0, 0, 0}, {47, 153, 3, 4, 3, 0, 1}, {48, 41, 13, 21, 1, 12, 0}, {49, 39, 12, 20, 0, 0, 0}, {50, 78, 37, 37, 3, 18, 19}, {51, 196, 4, 5, 3, 2, 3}, {52, 132, 7, 7, 0, 0, 0}, {54, 15, 27, 27, 3, 24, 25}, {55, 3, 25, 25, 0, 0, 0}, {61, 167, 72, 72, 0, 0, 0}, {62, 183, 26, 26, 0, 0, 0}, {63, 119, 181, 181, 0, 0, 0}, {64, 191, 225, 225, 0, 0, 0}, {65, 118, 42, 42, 0, 0, 0}, {66, 148, 6, 6, 3, 2, 3}, {67, 21, 4, 4, 0, 0, 0}, {69, 243, 11, 11, 1, 10, 0}, {70, 124, 18, 38, 3, 16, 17}, {73, 38, 37, 38, 3, 32, 33}, {74, 20, 20, 20, 0, 0, 0}, {75, 158, 35, 35, 3, 30, 31}, {76, 152, 33, 33, 3, 30, 31}, {77, 143, 3, 10, 3, 8, 9}, {80, 14, 4, 4, 3, 2, 3}, {81, 106, 22, 22, 0, 0, 0}, {82, 49, 39, 39, 3, 36, 37}, {83, 22, 37, 37, 0, 0, 0}, {84, 143, 53, 53, 3, 50, 51}, {85, 140, 51, 51, 0, 0, 0}, {86, 5, 53, 53, 3, 50, 51}, {87, 150, 51, 51, 0, 0, 0}, {89, 231, 28, 28, 0, 0, 0}, {90, 183, 56, 56, 0, 0, 0}, {91, 63, 42, 42, 0, 0, 0}, {92, 54, 33, 33, 0, 0, 0}, {93, 47, 81, 81, 0, 0, 0}, {100, 175, 26, 34, 0, 0, 0}, {101, 102, 32, 117, 0, 0, 0}, {102, 158, 32, 117, 0, 0, 0}, {103, 208, 20, 57, 0, 0, 0}, {104, 56, 32, 116, 0, 0, 0}, {105, 93, 62, 63, 0, 0, 0}, {106, 138, 44, 44, 0, 0, 0}, {107, 108, 64, 65, 0, 0, 0}, {108, 32, 84, 84, 0, 0, 0}, {109, 185, 9, 9, 0, 0, 0}, {110, 84, 254, 254, 3, 1, 2}, {111, 34, 16, 16, 0, 0, 0}, {112, 174, 12, 12, 0, 0, 0}, {113, 124, 36, 39, 0, 0, 0}, {114, 237, 44, 44, 0, 0, 0}, {115, 4, 64, 64, 0, 0, 0}, {116, 76, 22, 24, 0, 0, 0}, {117, 128, 6, 6, 3, 4, 5}, {118, 56, 14, 14, 0, 0, 0}, {119, 116, 12, 12, 3, 10, 11}, {120, 134, 97, 97, 0, 0, 0}, {121, 237, 2, 2, 3, 0, 1}, {122, 203, 2, 2, 3, 0, 1}, {123, 250, 113, 113, 3, 0, 1}, {124, 87, 35, 37, 0, 0, 0}, {125, 203, 6, 6, 0, 0, 0}, {126, 220, 79, 79, 0, 0, 0}, {127, 25, 35, 35, 0, 0, 0}, {128, 226, 35, 35, 0, 0, 0}, {129, 46, 22, 24, 0, 0, 0}, {130, 29, 13, 13, 0, 0, 0}, {131, 223, 255, 255, 0, 0, 0}, {132, 85, 14, 39, 0, 0, 0}, {133, 6, 18, 18, 0, 0, 0}, {134, 229, 43, 43, 0, 0, 0}, {135, 203, 8, 8, 0, 0, 0}, {136, 1, 22, 22, 0, 0, 0}, {137, 195, 14, 16, 0, 0, 0}, {138, 109, 36, 120, 0, 0, 0}, {139, 168, 43, 43, 3, 41, 42}, {140, 181, 41, 41, 0, 0, 0}, {141, 47, 32, 32, 0, 0, 0}, {142, 72, 243, 243, 0, 0, 0}, {143, 131, 14, 16, 0, 0, 0}, {144, 127, 93, 93, 0, 0, 0}, {146, 103, 100, 100, 0, 0, 0}, {147, 154, 36, 54, 0, 0, 0}, {148, 178, 60, 78, 0, 0, 0}, {149, 200, 30, 60, 0, 0, 0}, {150, 134, 42, 42, 0, 0, 0}, {151, 219, 8, 8, 3, 6, 7}, {152, 208, 4, 8, 0, 0, 0}, {153, 188, 12, 12, 0, 0, 0}, {154, 84, 15, 15, 3, 6, 7}, {155, 22, 13, 13, 3, 4, 5}, {156, 19, 6, 6, 3, 0, 1}, {157, 21, 15, 15, 3, 12, 13}, {158, 134, 14, 14, 3, 12, 13}, {160, 78, 12, 12, 3, 8, 9}, {161, 68, 3, 3, 3, 0, 1}, {162, 189, 8, 9, 0, 0, 0}, {163, 127, 28, 28, 0, 0, 0}, {164, 154, 44, 44, 0, 0, 0}, {165, 21, 3, 3, 0, 0, 0}, {166, 21, 9, 9, 0, 0, 0}, {167, 144, 22, 22, 0, 0, 0}, {168, 1, 12, 12, 0, 0, 0}, {169, 234, 18, 18, 0, 0, 0}, {170, 73, 34, 34, 0, 0, 0}, {171, 181, 66, 66, 0, 0, 0}, {172, 22, 98, 98, 0, 0, 0}, {173, 83, 8, 8, 0, 0, 0}, {174, 167, 48, 48, 0, 0, 0}, {175, 138, 19, 19, 3, 14, 15}, {176, 234, 3, 3, 3, 0, 1}, {177, 240, 20, 20, 0, 0, 0}, {178, 47, 24, 24, 0, 0, 0}, {179, 189, 29, 29, 1, 26, 0}, {180, 52, 45, 47, 1, 42, 0}, {181, 174, 4, 4, 0, 0, 0}, {182, 229, 40, 40, 0, 0, 0}, {183, 85, 2, 2, 3, 0, 1}, {184, 159, 206, 206, 3, 4, 5}, {185, 186, 7, 7, 3, 4, 5}, {186, 72, 29, 29, 3, 0, 1}, {191, 92, 27, 27, 0, 0, 0}, {192, 36, 44, 54, 0, 0, 0}, {193, 71, 22, 26, 0, 0, 0}, {194, 98, 25, 25, 0, 0, 0}, {195, 120, 37, 37, 0, 0, 0}, {200, 134, 42, 42, 3, 40, 41}, {201, 205, 14, 14, 3, 12, 13}, {214, 69, 8, 8, 3, 6, 7}, {215, 101, 3, 3, 0, 0, 0}, {216, 50, 3, 3, 3, 0, 1}, {217, 202, 6, 6, 0, 0, 0}, {218, 17, 7, 7, 3, 0, 1}, {219, 162, 2, 2, 0, 0, 0}, {225, 208, 65, 65, 0, 0, 0}, {226, 207, 8, 8, 0, 0, 0}, {230, 163, 42, 42, 0, 0, 0}, {231, 105, 40, 40, 0, 0, 0}, {232, 151, 63, 65, 0, 0, 0}, {233, 35, 182, 182, 0, 0, 0}, {234, 150, 40, 40, 0, 0, 0}, {235, 179, 42, 42, 0, 0, 0}, {241, 90, 32, 32, 0, 0, 0}, {242, 104, 52, 60, 0, 0, 0}, {243, 85, 53, 61, 1, 52, 0}, {244, 95, 6, 6, 0, 0, 0}, {245, 130, 2, 2, 0, 0, 0}, {246, 184, 38, 38, 0, 0, 0}, {247, 81, 19, 19, 0, 0, 0}, {248, 8, 254, 254, 3, 3, 4}, {249, 204, 36, 36, 0, 0, 0}, {250, 49, 30, 30, 0, 0, 0}, {251, 170, 18, 18, 0, 0, 0}, {252, 44, 18, 18, 0, 0, 0}, {253, 83, 51, 54, 0, 0, 0}, {254, 46, 9, 9, 0, 0, 0}, {256, 71, 42, 42, 3, 8, 9}, {257, 131, 9, 9, 0, 0, 0}, {258, 187, 32, 232, 3, 0, 1}, {259, 92, 235, 235, 0, 0, 0}, {260, 146, 5, 13, 0, 0, 0}, {261, 179, 27, 60, 0, 0, 0}, {262, 12, 18, 22, 0, 0, 0}, {263, 133, 255, 255, 0, 0, 0}, {264, 49, 28, 28, 0, 0, 0}, {265, 26, 16, 20, 0, 0, 0}, {266, 193, 255, 255, 3, 2, 3}, {267, 35, 255, 255, 3, 2, 3}, {268, 14, 4, 4, 3, 2, 3}, {269, 109, 213, 213, 0, 0, 0}, {270, 59, 19, 19, 0, 0, 0}, {271, 22, 52, 52, 0, 0, 0}, {275, 126, 31, 31, 0, 0, 0}, {276, 18, 49, 49, 0, 0, 0}, {280, 70, 33, 33, 0, 0, 0}, {281, 48, 13, 13, 0, 0, 0}, {282, 123, 35, 35, 3, 32, 33}, {283, 74, 144, 144, 0, 0, 0}, {284, 99, 32, 32, 3, 30, 31}, {285, 137, 40, 40, 3, 38, 39}, {286, 210, 53, 53, 3, 50, 51}, {287, 1, 23, 23, 3, 20, 21}, {288, 20, 23, 23, 3, 20, 21}, {290, 221, 42, 42, 0, 0, 0}, {291, 10, 57, 57, 0, 0, 0}, {299, 19, 96, 98, 0, 0, 0}, {300, 217, 22, 22, 0, 0, 0}, {301, 243, 58, 58, 0, 0, 0}, {310, 28, 17, 17, 0, 0, 0}, {311, 95, 116, 116, 0, 0, 0}, {320, 243, 20, 20, 3, 2, 3}, {321, 88, 2, 2, 3, 0, 1}, {322, 243, 149, 149, 0, 0, 0}, {323, 78, 147, 147, 3, 0, 1}, {324, 132, 146, 146, 0, 0, 0}, {330, 23, 158, 167, 0, 0, 0}, {331, 91, 230, 232, 0, 0, 0}, {332, 236, 239, 239, 0, 0, 0}, {333, 231, 109, 109, 0, 0, 0}, {334, 72, 10, 10, 0, 0, 0}, {335, 225, 24, 24, 0, 0, 0}, {336, 245, 84, 84, 0, 0, 0}, {339, 199, 5, 5, 0, 0, 0}, {340, 99, 70, 70, 0, 0, 0}, {350, 232, 20, 252, 0, 0, 0}, {360, 11, 25, 25, 0, 0, 0}, {370, 75, 87, 87, 0, 0, 0}, {373, 117, 42, 42, 0, 0, 0}, {375, 251, 140, 140, 0, 0, 0}, {380, 232, 20, 20, 0, 0, 0}, {385, 147, 133, 133, 3, 2, 3}, {390, 156, 238, 238, 0, 0, 0}, {395, 163, 156, 156, 0, 0, 0}, {400, 110, 254, 254, 3, 4, 5}, {401, 183, 6, 6, 3, 4, 5}, {9000, 113, 137, 137, 0, 0, 0}, {9005, 117, 34, 34, 0, 0, 0}, {10001, 209, 20, 20, 0, 0, 0}, {10002, 186, 41, 41, 0, 0, 0}, {10003, 4, 1, 1, 0, 0, 0}, {11000, 134, 51, 52, 3, 4, 5}, {11001, 15, 135, 136, 0, 0, 0}, {11002, 234, 179, 180, 3, 4, 5}, {11003, 64, 5, 5, 0, 0, 0}, {11010, 46, 49, 49, 0, 0, 0}, {11011, 106, 44, 44, 0, 0, 0}, {11020, 205, 16, 16, 0, 0, 0}, {11030, 144, 44, 44, 0, 0, 0}, {11031, 133, 44, 44, 0, 0, 0}, {11032, 85, 44, 44, 0, 0, 0}, {11033, 195, 37, 37, 3, 16, 17}, {11034, 79, 5, 5, 0, 0, 0}, {11035, 128, 8, 8, 3, 4, 5}, {11036, 177, 34, 34, 0, 0, 0}, {11037, 130, 28, 28, 0, 0, 0}, {12900, 114, 44, 44, 3, 0, 1}, {12901, 254, 59, 59, 3, 30, 31}, {12902, 49, 53, 53, 3, 4, 5}, {12903, 249, 46, 46, 3, 0, 1}, {12904, 203, 46, 46, 3, 20, 21}, {12905, 49, 43, 43, 3, 0, 1}, {12915, 62, 254, 254, 3, 0, 1}, {42000, 227, 1, 1, 0, 0, 0}, {42001, 239, 46, 46, 0, 0, 0}, {60001, 186, 42, 42, 3, 40, 41}, {60002, 69, 32, 32, 3, 30, 31}, {60010, 208, 33, 33, 0, 0, 0}, {60011, 183, 7, 7, 0, 0, 0}, {60012, 99, 36, 36, 3, 32, 33}, {60013, 129, 24, 24, 3, 20, 21}, {60014, 134, 8, 8, 3, 4, 5}, {60015, 78, 22, 22, 3, 0, 1}, {60020, 202, 4, 4, 0, 0, 0} }};

//! MAVLINK VERSION
constexpr auto MAVLINK_VERSION = 1;


// ENUM DEFINITIONS


/** @brief  */
enum class MAV_STORM32_TUNNEL_PAYLOAD_TYPE
{
    STORM32_CH1_IN=200, /* Registered for STorM32 gimbal controller. | */
    STORM32_CH1_OUT=201, /* Registered for STorM32 gimbal controller. | */
    STORM32_CH2_IN=202, /* Registered for STorM32 gimbal controller. | */
    STORM32_CH2_OUT=203, /* Registered for STorM32 gimbal controller. | */
    STORM32_CH3_IN=204, /* Registered for STorM32 gimbal controller. | */
    STORM32_CH3_OUT=205, /* Registered for STorM32 gimbal controller. | */
    STORM32_RESERVED6=206, /* Registered for STorM32 gimbal controller. | */
    STORM32_RESERVED7=207, /* Registered for STorM32 gimbal controller. | */
    STORM32_RESERVED8=208, /* Registered for STorM32 gimbal controller. | */
    STORM32_RESERVED9=209, /* Registered for STorM32 gimbal controller. | */
};

//! MAV_STORM32_TUNNEL_PAYLOAD_TYPE ENUM_END
constexpr auto MAV_STORM32_TUNNEL_PAYLOAD_TYPE_ENUM_END = 210;

/** @brief Gimbal device capability flags. */
enum class MAV_STORM32_GIMBAL_DEVICE_CAP_FLAGS : uint32_t
{
    HAS_RETRACT=1, /* Gimbal device supports a retracted position. | */
    HAS_NEUTRAL=2, /* Gimbal device supports a horizontal, forward looking position, stabilized. Can also be used to reset the gimbal's orientation. | */
    HAS_ROLL_AXIS=4, /* Gimbal device supports rotating around roll axis. | */
    HAS_ROLL_FOLLOW=8, /* Gimbal device supports to follow a roll angle relative to the vehicle. | */
    HAS_ROLL_LOCK=16, /* Gimbal device supports locking to an roll angle (generally that's the default). | */
    HAS_PITCH_AXIS=32, /* Gimbal device supports rotating around pitch axis. | */
    HAS_PITCH_FOLLOW=64, /* Gimbal device supports to follow a pitch angle relative to the vehicle. | */
    HAS_PITCH_LOCK=128, /* Gimbal device supports locking to an pitch angle (generally that's the default). | */
    HAS_YAW_AXIS=256, /* Gimbal device supports rotating around yaw axis. | */
    HAS_YAW_FOLLOW=512, /* Gimbal device supports to follow a yaw angle relative to the vehicle (generally that's the default). | */
    HAS_YAW_LOCK=1024, /* Gimbal device supports locking to a heading angle. | */
    HAS_INFINITE_YAW=2048, /* Gimbal device supports yawing/panning infinitely (e.g. using a slip ring). | */
    HAS_ABSOLUTE_YAW=65536, /* Gimbal device supports absolute yaw angles (this usually requires support by an autopilot, and can be dynamic, i.e., go on and off during runtime). | */
    HAS_RC=131072, /* Gimbal device supports control via an RC input signal. | */
};

//! MAV_STORM32_GIMBAL_DEVICE_CAP_FLAGS ENUM_END
constexpr auto MAV_STORM32_GIMBAL_DEVICE_CAP_FLAGS_ENUM_END = 131073;

/** @brief Flags for gimbal device operation. Used for setting and reporting, unless specified otherwise. Settings which are in violation of the capability flags are ignored by the gimbal device. */
enum class MAV_STORM32_GIMBAL_DEVICE_FLAGS : uint16_t
{
    RETRACT=1, /* Retracted safe position (no stabilization), takes presedence over NEUTRAL flag. If supported by the gimbal, the angles in the retracted position can be set in addition. | */
    NEUTRAL=2, /* Neutral position (horizontal, forward looking, with stabiliziation). | */
    ROLL_LOCK=4, /* Lock roll angle to absolute angle relative to horizon (not relative to drone). This is generally the default. | */
    PITCH_LOCK=8, /* Lock pitch angle to absolute angle relative to horizon (not relative to drone). This is generally the default. | */
    YAW_LOCK=16, /* Lock yaw angle to absolute angle relative to earth (not relative to drone). When the YAW_ABSOLUTE flag is set, the quaternion is in the Earth frame with the x-axis pointing North (yaw absolute), else it is in the Earth frame rotated so that the x-axis is pointing forward (yaw relative to vehicle). | */
    CAN_ACCEPT_YAW_ABSOLUTE=256, /* Gimbal device can accept absolute yaw angle input. This flag cannot be set, is only for reporting (attempts to set it are rejected by the gimbal device). | */
    YAW_ABSOLUTE=512, /* Yaw angle is absolute (is only accepted if CAN_ACCEPT_YAW_ABSOLUTE is set). If this flag is set, the quaternion is in the Earth frame with the x-axis pointing North (yaw absolute), else it is in the Earth frame rotated so that the x-axis is pointing forward (yaw relative to vehicle). | */
    RC_EXCLUSIVE=1024, /* RC control. The RC input signal fed to the gimbal device exclusively controls the gimbal's orientation. Overrides RC_MIXED flag if that is also set. | */
    RC_MIXED=2048, /* RC control. The RC input signal fed to the gimbal device is mixed into the gimbal's orientation. Is overriden by RC_EXCLUSIVE flag if that is also set. | */
    NONE=65535, /* UINT16_MAX = ignore. | */
};

//! MAV_STORM32_GIMBAL_DEVICE_FLAGS ENUM_END
constexpr auto MAV_STORM32_GIMBAL_DEVICE_FLAGS_ENUM_END = 65536;

/** @brief Gimbal device error and condition flags (0 means no error or other condition). */
enum class MAV_STORM32_GIMBAL_DEVICE_ERROR_FLAGS
{
    AT_ROLL_LIMIT=1, /* Gimbal device is limited by hardware roll limit. | */
    AT_PITCH_LIMIT=2, /* Gimbal device is limited by hardware pitch limit. | */
    AT_YAW_LIMIT=4, /* Gimbal device is limited by hardware yaw limit. | */
    ENCODER_ERROR=8, /* There is an error with the gimbal device's encoders. | */
    POWER_ERROR=16, /* There is an error with the gimbal device's power source. | */
    MOTOR_ERROR=32, /* There is an error with the gimbal device's motors. | */
    SOFTWARE_ERROR=64, /* There is an error with the gimbal device's software. | */
    COMMS_ERROR=128, /* There is an error with the gimbal device's communication. | */
    CALIBRATION_RUNNING=256, /* Gimbal device is currently calibrating (not an error). | */
    NO_MANAGER=32768, /* Gimbal device is not assigned to a gimbal manager (not an error). | */
};

//! MAV_STORM32_GIMBAL_DEVICE_ERROR_FLAGS ENUM_END
constexpr auto MAV_STORM32_GIMBAL_DEVICE_ERROR_FLAGS_ENUM_END = 32769;

/** @brief Gimbal manager capability flags. */
enum class MAV_STORM32_GIMBAL_MANAGER_CAP_FLAGS : uint32_t
{
    HAS_PROFILES=1, /* The gimbal manager supports several profiles. | */
    SUPPORTS_CHANGE=2, /* The gimbal manager supports changing the gimbal manager during run time, i.e. can be enabled/disabled. | */
};

//! MAV_STORM32_GIMBAL_MANAGER_CAP_FLAGS ENUM_END
constexpr auto MAV_STORM32_GIMBAL_MANAGER_CAP_FLAGS_ENUM_END = 3;

/** @brief Flags for gimbal manager operation. Used for setting and reporting, unless specified otherwise. If a setting is accepted by the gimbal manger, is reported in the STORM32_GIMBAL_MANAGER_STATUS message. */
enum class MAV_STORM32_GIMBAL_MANAGER_FLAGS : uint16_t
{
    NONE=0, /* 0 = ignore. | */
    RC_ACTIVE=1, /* Request to set RC input to active, or report RC input is active. Implies RC mixed. RC exclusive is achieved by setting all clients to inactive. | */
    CLIENT_ONBOARD_ACTIVE=2, /* Request to set onboard/companion computer client to active, or report this client is active. | */
    CLIENT_AUTOPILOT_ACTIVE=4, /* Request to set autopliot client to active, or report this client is active. | */
    CLIENT_GCS_ACTIVE=8, /* Request to set GCS client to active, or report this client is active. | */
    CLIENT_CAMERA_ACTIVE=16, /* Request to set camera client to active, or report this client is active. | */
    CLIENT_GCS2_ACTIVE=32, /* Request to set GCS2 client to active, or report this client is active. | */
    CLIENT_CAMERA2_ACTIVE=64, /* Request to set camera2 client to active, or report this client is active. | */
    CLIENT_CUSTOM_ACTIVE=128, /* Request to set custom client to active, or report this client is active. | */
    CLIENT_CUSTOM2_ACTIVE=256, /* Request to set custom2 client to active, or report this client is active. | */
    SET_SUPERVISON=512, /* Request supervision. This flag is only for setting, it is not reported. | */
    SET_RELEASE=1024, /* Release supervision. This flag is only for setting, it is not reported. | */
};

//! MAV_STORM32_GIMBAL_MANAGER_FLAGS ENUM_END
constexpr auto MAV_STORM32_GIMBAL_MANAGER_FLAGS_ENUM_END = 1025;

/** @brief Gimbal manager client ID. In a prioritizing profile, the priorities are determined by the implementation; they could e.g. be custom1 > onboard > GCS > autopilot/camera > GCS2 > custom2. */
enum class MAV_STORM32_GIMBAL_MANAGER_CLIENT : uint8_t
{
    NONE=0, /* For convenience. | */
    ONBOARD=1, /* This is the onboard/companion computer client. | */
    AUTOPILOT=2, /* This is the autopilot client. | */
    GCS=3, /* This is the GCS client. | */
    CAMERA=4, /* This is the camera client. | */
    GCS2=5, /* This is the GCS2 client. | */
    CAMERA2=6, /* This is the camera2 client. | */
    CUSTOM=7, /* This is the custom client. | */
    CUSTOM2=8, /* This is the custom2 client. | */
};

//! MAV_STORM32_GIMBAL_MANAGER_CLIENT ENUM_END
constexpr auto MAV_STORM32_GIMBAL_MANAGER_CLIENT_ENUM_END = 9;

/** @brief Flags for gimbal manager set up. Used for setting and reporting, unless specified otherwise. */
enum class MAV_STORM32_GIMBAL_MANAGER_SETUP_FLAGS
{
    ENABLE=16384, /* Enable gimbal manager. This flag is only for setting, is not reported. | */
    DISABLE=32768, /* Disable gimbal manager. This flag is only for setting, is not reported. | */
};

//! MAV_STORM32_GIMBAL_MANAGER_SETUP_FLAGS ENUM_END
constexpr auto MAV_STORM32_GIMBAL_MANAGER_SETUP_FLAGS_ENUM_END = 32769;

/** @brief Gimbal manager profiles. Only standard profiles are defined. Any implementation can define it's own profile in addition, and should use enum values > 16. */
enum class MAV_STORM32_GIMBAL_MANAGER_PROFILE : uint8_t
{
    DEFAULT=0, /* Default profile. Implementation specific. | */
    CUSTOM=1, /* Custom profile. Configurable profile according to the STorM32 definition. Is configured with STORM32_GIMBAL_MANAGER_PROFIL. | */
    COOPERATIVE=2, /* Default cooperative profile. Uses STorM32 custom profile with default settings to achieve cooperative behavior. | */
    EXCLUSIVE=3, /* Default exclusive profile. Uses STorM32 custom profile with default settings to achieve exclusive behavior. | */
    PRIORITY_COOPERATIVE=4, /* Default priority profile with cooperative behavior for equal priority. Uses STorM32 custom profile with default settings to achieve priority-based behavior. | */
    PRIORITY_EXCLUSIVE=5, /* Default priority profile with exclusive behavior for equal priority. Uses STorM32 custom profile with default settings to achieve priority-based behavior. | */
};

//! MAV_STORM32_GIMBAL_MANAGER_PROFILE ENUM_END
constexpr auto MAV_STORM32_GIMBAL_MANAGER_PROFILE_ENUM_END = 6;

/** @brief Gimbal actions. */
enum class MAV_STORM32_GIMBAL_ACTION
{
    RECENTER=1, /* Trigger the gimbal device to recenter the gimbal. | */
    CALIBRATION=2, /* Trigger the gimbal device to run a calibration. | */
    DISCOVER_MANAGER=3, /* Trigger gimbal device to (re)discover the gimbal manager during run time. | */
};

//! MAV_STORM32_GIMBAL_ACTION ENUM_END
constexpr auto MAV_STORM32_GIMBAL_ACTION_ENUM_END = 4;

/** @brief Enumeration of possible shot modes. */
enum class MAV_QSHOT_MODE : uint16_t
{
    UNDEFINED=0, /* Undefined shot mode. Can be used to determine if qshots should be used or not. | */
    DEFAULT=1, /* Start normal gimbal operation. Is usally used to return back from a shot. | */
    GIMBAL_RETRACT=2, /* Load and keep safe gimbal position and stop stabilization. | */
    GIMBAL_NEUTRAL=3, /* Load neutral gimbal position and keep it while stabilizing. | */
    GIMBAL_MISSION=4, /* Start mission with gimbal control. | */
    GIMBAL_RC_CONTROL=5, /* Start RC gimbal control. | */
    POI_TARGETING=6, /* Start gimbal tracking the point specified by Lat, Lon, Alt. | */
    SYSID_TARGETING=7, /* Start gimbal tracking the system with specified system ID. | */
    CABLECAM_2POINT=8, /* Start 2-point cable cam quick shot. | */
};

//! MAV_QSHOT_MODE ENUM_END
constexpr auto MAV_QSHOT_MODE_ENUM_END = 9;


} // namespace storm32
} // namespace mavlink

// MESSAGE DEFINITIONS
#include "./mavlink_msg_storm32_gimbal_device_status.hpp"
#include "./mavlink_msg_storm32_gimbal_device_control.hpp"
#include "./mavlink_msg_storm32_gimbal_manager_information.hpp"
#include "./mavlink_msg_storm32_gimbal_manager_status.hpp"
#include "./mavlink_msg_storm32_gimbal_manager_control.hpp"
#include "./mavlink_msg_storm32_gimbal_manager_control_pitchyaw.hpp"
#include "./mavlink_msg_storm32_gimbal_manager_correct_roll.hpp"
#include "./mavlink_msg_storm32_gimbal_manager_profile.hpp"
#include "./mavlink_msg_qshot_status.hpp"

// base include
#include "../ardupilotmega/ardupilotmega.hpp"
