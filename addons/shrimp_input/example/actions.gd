class_name ExampleShrimpActions

static var ROOT = RootAction.new()
static var MOVEMENT = RootAction.new("", ROOT)
static var MOVE_UP = PressAction.new("move_up", MOVEMENT)
static var MOVE_DOWN = PressAction.new("move_down", MOVEMENT)
static var MOVE_LEFT = PressAction.new("move_left", MOVEMENT)
static var MOVE_RIGHT = PressAction.new("move_right", MOVEMENT)
static var DASH = PressAction.new("dash", MOVEMENT)
static var DAMAGE = RootAction.new("", ROOT)
static var ATTACK = MouseAction2D.new("attack", DAMAGE)
static var HEAVYATTACK = MouseAction2D.new("heavy-attack", DAMAGE)
static var STAB = ComboAction.new(["dash", "attack"], DAMAGE)
