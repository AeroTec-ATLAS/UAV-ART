import pygame
from parameters import control_parameters as AP


class joystick:
    def __init__(self, customJoystick=False):
        pygame.display.init()
        pygame.joystick.init()
        self.customJoystick = customJoystick
        self.connected = False
        if not customJoystick:
            for i in range(pygame.joystick.get_count()):
                if (pygame.joystick.Joystick(i).get_name() == 'Mad Catz F.L.Y.5 Stick') | (pygame.joystick.Joystick(i).get_name() == 'PS4 Controller'):
                    self.sideStick = pygame.joystick.Joystick(i)
                    self.sideStick.init()
                    self.connected = True
                    break
        else:
            self.sideStick = pygame.joystick.Joystick(1)
            self.sideStick.init()
            self.thrustLever = pygame.joystick.Joystick(1)
            self.thrustLever.init()
            self.rudder = pygame.joystick.Joystick(1)
            self.rudder.init()
            self.connected = True
        if not self.connected:
            print('No joystick/controller detected. Only autopilot will be available')
            pygame.quit()

    def getInputs(self):
        if self.connected:
            pygame.event.pump()
            if not self.customJoystick:
                input_e = -self.sideStick.get_axis(1) * AP.delta_e_max
                input_a = self.sideStick.get_axis(0) * AP.delta_a_max
                input_r = 0#self.sideStick.get_axis(2) * AP.delta_r_max
                input_t = (-self.sideStick.get_axis(4) + 1) / 2 * AP.throttle_max
                if self.sideStick.get_button(2):
                    autopilot = False
                elif self.sideStick.get_button(3):
                    autopilot = True
                else:
                    autopilot = 2
            else:
                input_e = -self.sideStick.get_axis(1) * AP.delta_e_max
                input_a = self.sideStick.get_axis(0) * AP.delta_a_max
                input_r = self.rudder.get_axis(2) * AP.delta_r_max
                input_t = (self.thrustLever.get_axis(4) + 1) / 2 * AP.throttle_max
                if self.sideStick.get_button(1):
                    autopilot = False
                elif self.sideStick.get_button(3):
                    autopilot = True
                else:
                    autopilot = 2
            return input_e, input_a, input_r, input_t, autopilot
        else:
            return 0, 0, 0, 0, 2
