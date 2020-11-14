from math import sin, cos


class log():
    def __init__(self, fileName):
        self.fileName = fileName
        self._file = open(fileName, 'w+')
        self._file.write(
            'Time(s) pitch(rad) yaw(rad) roll(rad) pitchspeed(rad/s) yawspeed(rad/s) rollspeed(rad/s) lat(deg) lon(deg) alt[MSL](mm) vnorth[NED](cm/s) veast[NED](cm/s) vdown[NED](cm/s) IAS(m/s) AOA() Sideslip() RCch1() RCch2() RCch3() RCch4()\n')

    def addEntry(self, state, delta, time):
        text = '{time} {theta} {psi} {phi} {q} {r} {p} {pn} {pe} {h} {vNorth} {vEast} {vDown} {Va} {alpha} {beta} {delta_a} {delta_e} {delta_t} {delta_r}'
        text = text.format(time=time, theta=state.theta, psi=state.psi, phi=state.phi, q=state.q, r=state.r, p=state.p, pn=state.pn,
                           pe=state.pe, h=state.h, vNorth=state.Vg * cos(state.chi) * cos(state.gamma), vEast=state.Vg * sin(state.chi) * cos(state.gamma),
                           vDown=-state.Vg * sin(state.gamma), Va=state.Va, alpha=state.alpha, beta=state.beta, delta_a=delta.aileron,
                           delta_e=delta.elevator, delta_t=delta.throttle, delta_r=delta.rudder)
        self._file.write(text + '\n')

    def closeLog(self):
        self._file.close()
