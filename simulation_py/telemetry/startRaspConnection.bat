ssh -t pi@%1 sudo -s mavproxy.py --master=/dev/serial0 --baudrate 921600 --out %2:14550 --aircraft MyCopter
