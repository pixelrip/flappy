-- Constants for game configuration

SPIKE_DURATION = 300 -- difficulty spike lasts for X frames
SPIKE_DIFFICULTY = 5 -- difficulty spike increases difficulty by X
SPIKE_INTERVAL = 15 -- difficulty spike every X score points
DIFFICULTY_INCREASE_RATE = 5 -- increase base difficulty every X score points
MAX_SPEED  = 5 -- max gate speed (pixels/frame)
SPEED_INCREASE_RATE = 0.25 -- increase speed by X every difficulty level (pixels/frame)

P_FLAP = -2.5
P_START_X = 10
P_START_Y = 60
P_GRAVITY = 0.1
P_MAX_VY_UP = -4 -- max_up_velocity (pixels/frame)
P_MAX_VY_DOWN = 4 -- max_down_velocity (pixels/frame)