local matrix = require 'matrix_utils'

TAU = 2 * math.pi

SECONDS_PER_DAY = 24 * 60 * 60
SECONDS_PER_YEAR = SECONDS_PER_DAY * 365.25

PLANET_RADIUS_ZOOM = 1e3
DEFAULT_WINDOW_SIZE = { width = 960, height = 600 }

RETICLE_SPACING = 4
RETICLE_LENGTH = 10

CLICK_TOL = 50

VIEW_AXIS = matrix:new{0,0,1}

SOLAR_MASS        = 2e30 -- kG
SOLAR_LUMINOSITY  = 3.839e26 -- Watts
SOLAR_RADIUS   = 6.955e5 -- km
MAIN_SEQUENCE_CONSTANT = 3.5

MAX_ORBIT_CIRCLE_ERROR = .5 -- max half a pixel deviation from a true circle/ellipse
MIN_SEPARATION_FOR_DRAW = 5 -- Satellite must be at least 5 pix distinct from parent to be drawn

GRAVITATIONAL_CONSTANT = 6.67e-11 -- this is in meters cubed
GRAVITATIONAL_CONSTANT_KM = GRAVITATIONAL_CONSTANT * 1e-9
