-- Constants for game configuration

DEBUG = false

SPIKE_DURATION = 300 -- difficulty spike lasts for X frames
SPIKE_DIFFICULTY = 5 -- difficulty spike increases difficulty by X
SPIKE_INTERVAL = 15 -- difficulty spike every X score points
DIFFICULTY_INCREASE_RATE = 3 -- increase base difficulty every X score points
MAX_SPEED  = 5 -- max gate speed (pixels/frame)
SPEED_INCREASE_RATE = 0.25 -- increase speed by X every difficulty level (pixels/frame)

P_FLAP = -1.5
P_START_X = 10
P_START_Y = 60
P_GRAVITY = 0.1
P_MAX_VY_UP = -3 -- max_up_velocity (pixels/frame)
P_MAX_VY_DOWN = 4 -- max_down_velocity (pixels/frame)

GATE_MIN_HEIGHT = 20

GATE_BASE_MAX_HEIGHT = 60
GATE_BASE_MIN_HEIGHT = 40
GATE_BASE_MAX_WIDTH = 40
GATE_BASE_MIN_WIDTH = 10
GATE_HEIGHT_INCREMENT = 2
GATE_WIDTH_INCREMENT = 2

GATE_CLAMP_MAX_HEIGHT = 40
GATE_CLAMP_MIN_HEIGHT = 20
GATE_CLAMP_MAX_WIDTH = 60
GATE_CLAMP_MIN_WIDTH = 30

GATE_GAP_MAX = 128
GATE_GAP_MIN = 64
GATE_GAP_INCREMENT = 4
GATE_CLAMP_GAP_MAX = 64
GATE_CLAMP_GAP_MIN = 32
