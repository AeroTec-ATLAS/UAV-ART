/** @file
 *	@brief MAVLink comm testsuite protocol generated from storm32.xml
 *	@see http://mavlink.org
 */

#pragma once

#include <gtest/gtest.h>
#include "storm32.hpp"

#ifdef TEST_INTEROP
using namespace mavlink;
#undef MAVLINK_HELPER
#include "mavlink.h"
#endif


TEST(storm32, STORM32_GIMBAL_DEVICE_STATUS)
{
    mavlink::mavlink_message_t msg;
    mavlink::MsgMap map1(msg);
    mavlink::MsgMap map2(msg);

    mavlink::storm32::msg::STORM32_GIMBAL_DEVICE_STATUS packet_in{};
    packet_in.target_system = 125;
    packet_in.target_component = 192;
    packet_in.time_boot_ms = 963497464;
    packet_in.flags = 19107;
    packet_in.q = {{ 45.0, 46.0, 47.0, 48.0 }};
    packet_in.angular_velocity_x = 157.0;
    packet_in.angular_velocity_y = 185.0;
    packet_in.angular_velocity_z = 213.0;
    packet_in.yaw_absolute = 241.0;
    packet_in.failure_flags = 19211;

    mavlink::storm32::msg::STORM32_GIMBAL_DEVICE_STATUS packet1{};
    mavlink::storm32::msg::STORM32_GIMBAL_DEVICE_STATUS packet2{};

    packet1 = packet_in;

    //std::cout << packet1.to_yaml() << std::endl;

    packet1.serialize(map1);

    mavlink::mavlink_finalize_message(&msg, 1, 1, packet1.MIN_LENGTH, packet1.LENGTH, packet1.CRC_EXTRA);

    packet2.deserialize(map2);

    EXPECT_EQ(packet1.target_system, packet2.target_system);
    EXPECT_EQ(packet1.target_component, packet2.target_component);
    EXPECT_EQ(packet1.time_boot_ms, packet2.time_boot_ms);
    EXPECT_EQ(packet1.flags, packet2.flags);
    EXPECT_EQ(packet1.q, packet2.q);
    EXPECT_EQ(packet1.angular_velocity_x, packet2.angular_velocity_x);
    EXPECT_EQ(packet1.angular_velocity_y, packet2.angular_velocity_y);
    EXPECT_EQ(packet1.angular_velocity_z, packet2.angular_velocity_z);
    EXPECT_EQ(packet1.yaw_absolute, packet2.yaw_absolute);
    EXPECT_EQ(packet1.failure_flags, packet2.failure_flags);
}

#ifdef TEST_INTEROP
TEST(storm32_interop, STORM32_GIMBAL_DEVICE_STATUS)
{
    mavlink_message_t msg;

    // to get nice print
    memset(&msg, 0, sizeof(msg));

    mavlink_storm32_gimbal_device_status_t packet_c {
         963497464, { 45.0, 46.0, 47.0, 48.0 }, 157.0, 185.0, 213.0, 241.0, 19107, 19211, 125, 192
    };

    mavlink::storm32::msg::STORM32_GIMBAL_DEVICE_STATUS packet_in{};
    packet_in.target_system = 125;
    packet_in.target_component = 192;
    packet_in.time_boot_ms = 963497464;
    packet_in.flags = 19107;
    packet_in.q = {{ 45.0, 46.0, 47.0, 48.0 }};
    packet_in.angular_velocity_x = 157.0;
    packet_in.angular_velocity_y = 185.0;
    packet_in.angular_velocity_z = 213.0;
    packet_in.yaw_absolute = 241.0;
    packet_in.failure_flags = 19211;

    mavlink::storm32::msg::STORM32_GIMBAL_DEVICE_STATUS packet2{};

    mavlink_msg_storm32_gimbal_device_status_encode(1, 1, &msg, &packet_c);

    // simulate message-handling callback
    [&packet2](const mavlink_message_t *cmsg) {
        MsgMap map2(cmsg);

        packet2.deserialize(map2);
    } (&msg);

    EXPECT_EQ(packet_in.target_system, packet2.target_system);
    EXPECT_EQ(packet_in.target_component, packet2.target_component);
    EXPECT_EQ(packet_in.time_boot_ms, packet2.time_boot_ms);
    EXPECT_EQ(packet_in.flags, packet2.flags);
    EXPECT_EQ(packet_in.q, packet2.q);
    EXPECT_EQ(packet_in.angular_velocity_x, packet2.angular_velocity_x);
    EXPECT_EQ(packet_in.angular_velocity_y, packet2.angular_velocity_y);
    EXPECT_EQ(packet_in.angular_velocity_z, packet2.angular_velocity_z);
    EXPECT_EQ(packet_in.yaw_absolute, packet2.yaw_absolute);
    EXPECT_EQ(packet_in.failure_flags, packet2.failure_flags);

#ifdef PRINT_MSG
    PRINT_MSG(msg);
#endif
}
#endif

TEST(storm32, STORM32_GIMBAL_DEVICE_CONTROL)
{
    mavlink::mavlink_message_t msg;
    mavlink::MsgMap map1(msg);
    mavlink::MsgMap map2(msg);

    mavlink::storm32::msg::STORM32_GIMBAL_DEVICE_CONTROL packet_in{};
    packet_in.target_system = 223;
    packet_in.target_component = 34;
    packet_in.flags = 18691;
    packet_in.q = {{ 17.0, 18.0, 19.0, 20.0 }};
    packet_in.angular_velocity_x = 129.0;
    packet_in.angular_velocity_y = 157.0;
    packet_in.angular_velocity_z = 185.0;

    mavlink::storm32::msg::STORM32_GIMBAL_DEVICE_CONTROL packet1{};
    mavlink::storm32::msg::STORM32_GIMBAL_DEVICE_CONTROL packet2{};

    packet1 = packet_in;

    //std::cout << packet1.to_yaml() << std::endl;

    packet1.serialize(map1);

    mavlink::mavlink_finalize_message(&msg, 1, 1, packet1.MIN_LENGTH, packet1.LENGTH, packet1.CRC_EXTRA);

    packet2.deserialize(map2);

    EXPECT_EQ(packet1.target_system, packet2.target_system);
    EXPECT_EQ(packet1.target_component, packet2.target_component);
    EXPECT_EQ(packet1.flags, packet2.flags);
    EXPECT_EQ(packet1.q, packet2.q);
    EXPECT_EQ(packet1.angular_velocity_x, packet2.angular_velocity_x);
    EXPECT_EQ(packet1.angular_velocity_y, packet2.angular_velocity_y);
    EXPECT_EQ(packet1.angular_velocity_z, packet2.angular_velocity_z);
}

#ifdef TEST_INTEROP
TEST(storm32_interop, STORM32_GIMBAL_DEVICE_CONTROL)
{
    mavlink_message_t msg;

    // to get nice print
    memset(&msg, 0, sizeof(msg));

    mavlink_storm32_gimbal_device_control_t packet_c {
         { 17.0, 18.0, 19.0, 20.0 }, 129.0, 157.0, 185.0, 18691, 223, 34
    };

    mavlink::storm32::msg::STORM32_GIMBAL_DEVICE_CONTROL packet_in{};
    packet_in.target_system = 223;
    packet_in.target_component = 34;
    packet_in.flags = 18691;
    packet_in.q = {{ 17.0, 18.0, 19.0, 20.0 }};
    packet_in.angular_velocity_x = 129.0;
    packet_in.angular_velocity_y = 157.0;
    packet_in.angular_velocity_z = 185.0;

    mavlink::storm32::msg::STORM32_GIMBAL_DEVICE_CONTROL packet2{};

    mavlink_msg_storm32_gimbal_device_control_encode(1, 1, &msg, &packet_c);

    // simulate message-handling callback
    [&packet2](const mavlink_message_t *cmsg) {
        MsgMap map2(cmsg);

        packet2.deserialize(map2);
    } (&msg);

    EXPECT_EQ(packet_in.target_system, packet2.target_system);
    EXPECT_EQ(packet_in.target_component, packet2.target_component);
    EXPECT_EQ(packet_in.flags, packet2.flags);
    EXPECT_EQ(packet_in.q, packet2.q);
    EXPECT_EQ(packet_in.angular_velocity_x, packet2.angular_velocity_x);
    EXPECT_EQ(packet_in.angular_velocity_y, packet2.angular_velocity_y);
    EXPECT_EQ(packet_in.angular_velocity_z, packet2.angular_velocity_z);

#ifdef PRINT_MSG
    PRINT_MSG(msg);
#endif
}
#endif

TEST(storm32, STORM32_GIMBAL_MANAGER_INFORMATION)
{
    mavlink::mavlink_message_t msg;
    mavlink::MsgMap map1(msg);
    mavlink::MsgMap map2(msg);

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_INFORMATION packet_in{};
    packet_in.gimbal_id = 101;
    packet_in.device_cap_flags = 963497464;
    packet_in.manager_cap_flags = 963497672;
    packet_in.roll_min = 73.0;
    packet_in.roll_max = 101.0;
    packet_in.pitch_min = 129.0;
    packet_in.pitch_max = 157.0;
    packet_in.yaw_min = 185.0;
    packet_in.yaw_max = 213.0;

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_INFORMATION packet1{};
    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_INFORMATION packet2{};

    packet1 = packet_in;

    //std::cout << packet1.to_yaml() << std::endl;

    packet1.serialize(map1);

    mavlink::mavlink_finalize_message(&msg, 1, 1, packet1.MIN_LENGTH, packet1.LENGTH, packet1.CRC_EXTRA);

    packet2.deserialize(map2);

    EXPECT_EQ(packet1.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet1.device_cap_flags, packet2.device_cap_flags);
    EXPECT_EQ(packet1.manager_cap_flags, packet2.manager_cap_flags);
    EXPECT_EQ(packet1.roll_min, packet2.roll_min);
    EXPECT_EQ(packet1.roll_max, packet2.roll_max);
    EXPECT_EQ(packet1.pitch_min, packet2.pitch_min);
    EXPECT_EQ(packet1.pitch_max, packet2.pitch_max);
    EXPECT_EQ(packet1.yaw_min, packet2.yaw_min);
    EXPECT_EQ(packet1.yaw_max, packet2.yaw_max);
}

#ifdef TEST_INTEROP
TEST(storm32_interop, STORM32_GIMBAL_MANAGER_INFORMATION)
{
    mavlink_message_t msg;

    // to get nice print
    memset(&msg, 0, sizeof(msg));

    mavlink_storm32_gimbal_manager_information_t packet_c {
         963497464, 963497672, 73.0, 101.0, 129.0, 157.0, 185.0, 213.0, 101
    };

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_INFORMATION packet_in{};
    packet_in.gimbal_id = 101;
    packet_in.device_cap_flags = 963497464;
    packet_in.manager_cap_flags = 963497672;
    packet_in.roll_min = 73.0;
    packet_in.roll_max = 101.0;
    packet_in.pitch_min = 129.0;
    packet_in.pitch_max = 157.0;
    packet_in.yaw_min = 185.0;
    packet_in.yaw_max = 213.0;

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_INFORMATION packet2{};

    mavlink_msg_storm32_gimbal_manager_information_encode(1, 1, &msg, &packet_c);

    // simulate message-handling callback
    [&packet2](const mavlink_message_t *cmsg) {
        MsgMap map2(cmsg);

        packet2.deserialize(map2);
    } (&msg);

    EXPECT_EQ(packet_in.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet_in.device_cap_flags, packet2.device_cap_flags);
    EXPECT_EQ(packet_in.manager_cap_flags, packet2.manager_cap_flags);
    EXPECT_EQ(packet_in.roll_min, packet2.roll_min);
    EXPECT_EQ(packet_in.roll_max, packet2.roll_max);
    EXPECT_EQ(packet_in.pitch_min, packet2.pitch_min);
    EXPECT_EQ(packet_in.pitch_max, packet2.pitch_max);
    EXPECT_EQ(packet_in.yaw_min, packet2.yaw_min);
    EXPECT_EQ(packet_in.yaw_max, packet2.yaw_max);

#ifdef PRINT_MSG
    PRINT_MSG(msg);
#endif
}
#endif

TEST(storm32, STORM32_GIMBAL_MANAGER_STATUS)
{
    mavlink::mavlink_message_t msg;
    mavlink::MsgMap map1(msg);
    mavlink::MsgMap map2(msg);

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_STATUS packet_in{};
    packet_in.gimbal_id = 17;
    packet_in.supervisor = 84;
    packet_in.device_flags = 17235;
    packet_in.manager_flags = 17339;
    packet_in.profile = 151;

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_STATUS packet1{};
    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_STATUS packet2{};

    packet1 = packet_in;

    //std::cout << packet1.to_yaml() << std::endl;

    packet1.serialize(map1);

    mavlink::mavlink_finalize_message(&msg, 1, 1, packet1.MIN_LENGTH, packet1.LENGTH, packet1.CRC_EXTRA);

    packet2.deserialize(map2);

    EXPECT_EQ(packet1.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet1.supervisor, packet2.supervisor);
    EXPECT_EQ(packet1.device_flags, packet2.device_flags);
    EXPECT_EQ(packet1.manager_flags, packet2.manager_flags);
    EXPECT_EQ(packet1.profile, packet2.profile);
}

#ifdef TEST_INTEROP
TEST(storm32_interop, STORM32_GIMBAL_MANAGER_STATUS)
{
    mavlink_message_t msg;

    // to get nice print
    memset(&msg, 0, sizeof(msg));

    mavlink_storm32_gimbal_manager_status_t packet_c {
         17235, 17339, 17, 84, 151
    };

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_STATUS packet_in{};
    packet_in.gimbal_id = 17;
    packet_in.supervisor = 84;
    packet_in.device_flags = 17235;
    packet_in.manager_flags = 17339;
    packet_in.profile = 151;

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_STATUS packet2{};

    mavlink_msg_storm32_gimbal_manager_status_encode(1, 1, &msg, &packet_c);

    // simulate message-handling callback
    [&packet2](const mavlink_message_t *cmsg) {
        MsgMap map2(cmsg);

        packet2.deserialize(map2);
    } (&msg);

    EXPECT_EQ(packet_in.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet_in.supervisor, packet2.supervisor);
    EXPECT_EQ(packet_in.device_flags, packet2.device_flags);
    EXPECT_EQ(packet_in.manager_flags, packet2.manager_flags);
    EXPECT_EQ(packet_in.profile, packet2.profile);

#ifdef PRINT_MSG
    PRINT_MSG(msg);
#endif
}
#endif

TEST(storm32, STORM32_GIMBAL_MANAGER_CONTROL)
{
    mavlink::mavlink_message_t msg;
    mavlink::MsgMap map1(msg);
    mavlink::MsgMap map2(msg);

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CONTROL packet_in{};
    packet_in.target_system = 101;
    packet_in.target_component = 168;
    packet_in.gimbal_id = 235;
    packet_in.client = 46;
    packet_in.device_flags = 18691;
    packet_in.manager_flags = 18795;
    packet_in.q = {{ 17.0, 18.0, 19.0, 20.0 }};
    packet_in.angular_velocity_x = 129.0;
    packet_in.angular_velocity_y = 157.0;
    packet_in.angular_velocity_z = 185.0;

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CONTROL packet1{};
    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CONTROL packet2{};

    packet1 = packet_in;

    //std::cout << packet1.to_yaml() << std::endl;

    packet1.serialize(map1);

    mavlink::mavlink_finalize_message(&msg, 1, 1, packet1.MIN_LENGTH, packet1.LENGTH, packet1.CRC_EXTRA);

    packet2.deserialize(map2);

    EXPECT_EQ(packet1.target_system, packet2.target_system);
    EXPECT_EQ(packet1.target_component, packet2.target_component);
    EXPECT_EQ(packet1.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet1.client, packet2.client);
    EXPECT_EQ(packet1.device_flags, packet2.device_flags);
    EXPECT_EQ(packet1.manager_flags, packet2.manager_flags);
    EXPECT_EQ(packet1.q, packet2.q);
    EXPECT_EQ(packet1.angular_velocity_x, packet2.angular_velocity_x);
    EXPECT_EQ(packet1.angular_velocity_y, packet2.angular_velocity_y);
    EXPECT_EQ(packet1.angular_velocity_z, packet2.angular_velocity_z);
}

#ifdef TEST_INTEROP
TEST(storm32_interop, STORM32_GIMBAL_MANAGER_CONTROL)
{
    mavlink_message_t msg;

    // to get nice print
    memset(&msg, 0, sizeof(msg));

    mavlink_storm32_gimbal_manager_control_t packet_c {
         { 17.0, 18.0, 19.0, 20.0 }, 129.0, 157.0, 185.0, 18691, 18795, 101, 168, 235, 46
    };

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CONTROL packet_in{};
    packet_in.target_system = 101;
    packet_in.target_component = 168;
    packet_in.gimbal_id = 235;
    packet_in.client = 46;
    packet_in.device_flags = 18691;
    packet_in.manager_flags = 18795;
    packet_in.q = {{ 17.0, 18.0, 19.0, 20.0 }};
    packet_in.angular_velocity_x = 129.0;
    packet_in.angular_velocity_y = 157.0;
    packet_in.angular_velocity_z = 185.0;

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CONTROL packet2{};

    mavlink_msg_storm32_gimbal_manager_control_encode(1, 1, &msg, &packet_c);

    // simulate message-handling callback
    [&packet2](const mavlink_message_t *cmsg) {
        MsgMap map2(cmsg);

        packet2.deserialize(map2);
    } (&msg);

    EXPECT_EQ(packet_in.target_system, packet2.target_system);
    EXPECT_EQ(packet_in.target_component, packet2.target_component);
    EXPECT_EQ(packet_in.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet_in.client, packet2.client);
    EXPECT_EQ(packet_in.device_flags, packet2.device_flags);
    EXPECT_EQ(packet_in.manager_flags, packet2.manager_flags);
    EXPECT_EQ(packet_in.q, packet2.q);
    EXPECT_EQ(packet_in.angular_velocity_x, packet2.angular_velocity_x);
    EXPECT_EQ(packet_in.angular_velocity_y, packet2.angular_velocity_y);
    EXPECT_EQ(packet_in.angular_velocity_z, packet2.angular_velocity_z);

#ifdef PRINT_MSG
    PRINT_MSG(msg);
#endif
}
#endif

TEST(storm32, STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW)
{
    mavlink::mavlink_message_t msg;
    mavlink::MsgMap map1(msg);
    mavlink::MsgMap map2(msg);

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW packet_in{};
    packet_in.target_system = 65;
    packet_in.target_component = 132;
    packet_in.gimbal_id = 199;
    packet_in.client = 10;
    packet_in.device_flags = 18067;
    packet_in.manager_flags = 18171;
    packet_in.pitch = 17.0;
    packet_in.yaw = 45.0;
    packet_in.pitch_rate = 73.0;
    packet_in.yaw_rate = 101.0;

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW packet1{};
    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW packet2{};

    packet1 = packet_in;

    //std::cout << packet1.to_yaml() << std::endl;

    packet1.serialize(map1);

    mavlink::mavlink_finalize_message(&msg, 1, 1, packet1.MIN_LENGTH, packet1.LENGTH, packet1.CRC_EXTRA);

    packet2.deserialize(map2);

    EXPECT_EQ(packet1.target_system, packet2.target_system);
    EXPECT_EQ(packet1.target_component, packet2.target_component);
    EXPECT_EQ(packet1.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet1.client, packet2.client);
    EXPECT_EQ(packet1.device_flags, packet2.device_flags);
    EXPECT_EQ(packet1.manager_flags, packet2.manager_flags);
    EXPECT_EQ(packet1.pitch, packet2.pitch);
    EXPECT_EQ(packet1.yaw, packet2.yaw);
    EXPECT_EQ(packet1.pitch_rate, packet2.pitch_rate);
    EXPECT_EQ(packet1.yaw_rate, packet2.yaw_rate);
}

#ifdef TEST_INTEROP
TEST(storm32_interop, STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW)
{
    mavlink_message_t msg;

    // to get nice print
    memset(&msg, 0, sizeof(msg));

    mavlink_storm32_gimbal_manager_control_pitchyaw_t packet_c {
         17.0, 45.0, 73.0, 101.0, 18067, 18171, 65, 132, 199, 10
    };

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW packet_in{};
    packet_in.target_system = 65;
    packet_in.target_component = 132;
    packet_in.gimbal_id = 199;
    packet_in.client = 10;
    packet_in.device_flags = 18067;
    packet_in.manager_flags = 18171;
    packet_in.pitch = 17.0;
    packet_in.yaw = 45.0;
    packet_in.pitch_rate = 73.0;
    packet_in.yaw_rate = 101.0;

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CONTROL_PITCHYAW packet2{};

    mavlink_msg_storm32_gimbal_manager_control_pitchyaw_encode(1, 1, &msg, &packet_c);

    // simulate message-handling callback
    [&packet2](const mavlink_message_t *cmsg) {
        MsgMap map2(cmsg);

        packet2.deserialize(map2);
    } (&msg);

    EXPECT_EQ(packet_in.target_system, packet2.target_system);
    EXPECT_EQ(packet_in.target_component, packet2.target_component);
    EXPECT_EQ(packet_in.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet_in.client, packet2.client);
    EXPECT_EQ(packet_in.device_flags, packet2.device_flags);
    EXPECT_EQ(packet_in.manager_flags, packet2.manager_flags);
    EXPECT_EQ(packet_in.pitch, packet2.pitch);
    EXPECT_EQ(packet_in.yaw, packet2.yaw);
    EXPECT_EQ(packet_in.pitch_rate, packet2.pitch_rate);
    EXPECT_EQ(packet_in.yaw_rate, packet2.yaw_rate);

#ifdef PRINT_MSG
    PRINT_MSG(msg);
#endif
}
#endif

TEST(storm32, STORM32_GIMBAL_MANAGER_CORRECT_ROLL)
{
    mavlink::mavlink_message_t msg;
    mavlink::MsgMap map1(msg);
    mavlink::MsgMap map2(msg);

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CORRECT_ROLL packet_in{};
    packet_in.target_system = 17;
    packet_in.target_component = 84;
    packet_in.gimbal_id = 151;
    packet_in.client = 218;
    packet_in.roll = 17.0;

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CORRECT_ROLL packet1{};
    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CORRECT_ROLL packet2{};

    packet1 = packet_in;

    //std::cout << packet1.to_yaml() << std::endl;

    packet1.serialize(map1);

    mavlink::mavlink_finalize_message(&msg, 1, 1, packet1.MIN_LENGTH, packet1.LENGTH, packet1.CRC_EXTRA);

    packet2.deserialize(map2);

    EXPECT_EQ(packet1.target_system, packet2.target_system);
    EXPECT_EQ(packet1.target_component, packet2.target_component);
    EXPECT_EQ(packet1.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet1.client, packet2.client);
    EXPECT_EQ(packet1.roll, packet2.roll);
}

#ifdef TEST_INTEROP
TEST(storm32_interop, STORM32_GIMBAL_MANAGER_CORRECT_ROLL)
{
    mavlink_message_t msg;

    // to get nice print
    memset(&msg, 0, sizeof(msg));

    mavlink_storm32_gimbal_manager_correct_roll_t packet_c {
         17.0, 17, 84, 151, 218
    };

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CORRECT_ROLL packet_in{};
    packet_in.target_system = 17;
    packet_in.target_component = 84;
    packet_in.gimbal_id = 151;
    packet_in.client = 218;
    packet_in.roll = 17.0;

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_CORRECT_ROLL packet2{};

    mavlink_msg_storm32_gimbal_manager_correct_roll_encode(1, 1, &msg, &packet_c);

    // simulate message-handling callback
    [&packet2](const mavlink_message_t *cmsg) {
        MsgMap map2(cmsg);

        packet2.deserialize(map2);
    } (&msg);

    EXPECT_EQ(packet_in.target_system, packet2.target_system);
    EXPECT_EQ(packet_in.target_component, packet2.target_component);
    EXPECT_EQ(packet_in.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet_in.client, packet2.client);
    EXPECT_EQ(packet_in.roll, packet2.roll);

#ifdef PRINT_MSG
    PRINT_MSG(msg);
#endif
}
#endif

TEST(storm32, STORM32_GIMBAL_MANAGER_PROFILE)
{
    mavlink::mavlink_message_t msg;
    mavlink::MsgMap map1(msg);
    mavlink::MsgMap map2(msg);

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_PROFILE packet_in{};
    packet_in.target_system = 5;
    packet_in.target_component = 72;
    packet_in.gimbal_id = 139;
    packet_in.profile = 206;
    packet_in.priorities = {{ 17, 18, 19, 20, 21, 22, 23, 24 }};
    packet_in.profile_flags = 41;
    packet_in.rc_timeout = 108;
    packet_in.timeouts = {{ 175, 176, 177, 178, 179, 180, 181, 182 }};

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_PROFILE packet1{};
    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_PROFILE packet2{};

    packet1 = packet_in;

    //std::cout << packet1.to_yaml() << std::endl;

    packet1.serialize(map1);

    mavlink::mavlink_finalize_message(&msg, 1, 1, packet1.MIN_LENGTH, packet1.LENGTH, packet1.CRC_EXTRA);

    packet2.deserialize(map2);

    EXPECT_EQ(packet1.target_system, packet2.target_system);
    EXPECT_EQ(packet1.target_component, packet2.target_component);
    EXPECT_EQ(packet1.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet1.profile, packet2.profile);
    EXPECT_EQ(packet1.priorities, packet2.priorities);
    EXPECT_EQ(packet1.profile_flags, packet2.profile_flags);
    EXPECT_EQ(packet1.rc_timeout, packet2.rc_timeout);
    EXPECT_EQ(packet1.timeouts, packet2.timeouts);
}

#ifdef TEST_INTEROP
TEST(storm32_interop, STORM32_GIMBAL_MANAGER_PROFILE)
{
    mavlink_message_t msg;

    // to get nice print
    memset(&msg, 0, sizeof(msg));

    mavlink_storm32_gimbal_manager_profile_t packet_c {
         5, 72, 139, 206, { 17, 18, 19, 20, 21, 22, 23, 24 }, 41, 108, { 175, 176, 177, 178, 179, 180, 181, 182 }
    };

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_PROFILE packet_in{};
    packet_in.target_system = 5;
    packet_in.target_component = 72;
    packet_in.gimbal_id = 139;
    packet_in.profile = 206;
    packet_in.priorities = {{ 17, 18, 19, 20, 21, 22, 23, 24 }};
    packet_in.profile_flags = 41;
    packet_in.rc_timeout = 108;
    packet_in.timeouts = {{ 175, 176, 177, 178, 179, 180, 181, 182 }};

    mavlink::storm32::msg::STORM32_GIMBAL_MANAGER_PROFILE packet2{};

    mavlink_msg_storm32_gimbal_manager_profile_encode(1, 1, &msg, &packet_c);

    // simulate message-handling callback
    [&packet2](const mavlink_message_t *cmsg) {
        MsgMap map2(cmsg);

        packet2.deserialize(map2);
    } (&msg);

    EXPECT_EQ(packet_in.target_system, packet2.target_system);
    EXPECT_EQ(packet_in.target_component, packet2.target_component);
    EXPECT_EQ(packet_in.gimbal_id, packet2.gimbal_id);
    EXPECT_EQ(packet_in.profile, packet2.profile);
    EXPECT_EQ(packet_in.priorities, packet2.priorities);
    EXPECT_EQ(packet_in.profile_flags, packet2.profile_flags);
    EXPECT_EQ(packet_in.rc_timeout, packet2.rc_timeout);
    EXPECT_EQ(packet_in.timeouts, packet2.timeouts);

#ifdef PRINT_MSG
    PRINT_MSG(msg);
#endif
}
#endif

TEST(storm32, QSHOT_STATUS)
{
    mavlink::mavlink_message_t msg;
    mavlink::MsgMap map1(msg);
    mavlink::MsgMap map2(msg);

    mavlink::storm32::msg::QSHOT_STATUS packet_in{};
    packet_in.mode = 17235;
    packet_in.shot_state = 17339;

    mavlink::storm32::msg::QSHOT_STATUS packet1{};
    mavlink::storm32::msg::QSHOT_STATUS packet2{};

    packet1 = packet_in;

    //std::cout << packet1.to_yaml() << std::endl;

    packet1.serialize(map1);

    mavlink::mavlink_finalize_message(&msg, 1, 1, packet1.MIN_LENGTH, packet1.LENGTH, packet1.CRC_EXTRA);

    packet2.deserialize(map2);

    EXPECT_EQ(packet1.mode, packet2.mode);
    EXPECT_EQ(packet1.shot_state, packet2.shot_state);
}

#ifdef TEST_INTEROP
TEST(storm32_interop, QSHOT_STATUS)
{
    mavlink_message_t msg;

    // to get nice print
    memset(&msg, 0, sizeof(msg));

    mavlink_qshot_status_t packet_c {
         17235, 17339
    };

    mavlink::storm32::msg::QSHOT_STATUS packet_in{};
    packet_in.mode = 17235;
    packet_in.shot_state = 17339;

    mavlink::storm32::msg::QSHOT_STATUS packet2{};

    mavlink_msg_qshot_status_encode(1, 1, &msg, &packet_c);

    // simulate message-handling callback
    [&packet2](const mavlink_message_t *cmsg) {
        MsgMap map2(cmsg);

        packet2.deserialize(map2);
    } (&msg);

    EXPECT_EQ(packet_in.mode, packet2.mode);
    EXPECT_EQ(packet_in.shot_state, packet2.shot_state);

#ifdef PRINT_MSG
    PRINT_MSG(msg);
#endif
}
#endif
