class_name ExampleShrimpActions

static var ROOT_ACTION = RootAction.new()
static var MOVE_UP = PressAction.new("move_up", ROOT_ACTION)
static var MOVE_DOWN = PressAction.new("move_down", ROOT_ACTION)
static var MOVE_LEFT = PressAction.new("move_left", ROOT_ACTION)
static var MOVE_RIGHT = PressAction.new("move_right", ROOT_ACTION)
static var ATTACK = MouseAction2D.new("attack", ROOT_ACTION)
static var DASH = PressAction.new("dash", ROOT_ACTION)
static var STAB = ComboAction.new(["dash", "attack"], ROOT_ACTION)
