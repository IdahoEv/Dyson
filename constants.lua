TAU = 2 * math.pi

SECONDS_PER_DAY = 24 * 60 * 60
SECONDS_PER_YEAR = SECONDS_PER_DAY * 365.25

PLANET_RADIUS_ZOOM = 1e3
DEFAULT_WINDOW_SIZE = { width = 960, height = 600 }

RETICLE_SPACING = 4
RETICLE_LENGTH = 10

CLICK_TOL = 50

MAX_ORBIT_CIRCLE_ERROR = .5 -- max half a pixel deviation from a true circle/ellipse
MIN_SEPARATION_FOR_DRAW = 5 -- Satellite must be at least 5 pix distinct from parent to be drawn