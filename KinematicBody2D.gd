extends KinematicBody2D


# --> MOTION Control Variables
var MAX_SPEED = 2500
var ACCELERATION = 1500
var DECELERATION = 3000
# TODO: Understand what Vector2() does
var motion = Vector2()


# This is synced to the physics process of GODOT.  It's run each time there is
# an update to the physics of the... scene...world.. oh boy
func _physics_process(delta):
	# Find the axis of motion.
	var axis = get_input_axis()

	# If inputs are inactive, apply stopping force, else apply movement force.
	if axis == Vector2.ZERO:
		apply_friction(DECELERATION * delta)
	else:
		apply_force(axis * ACCELERATION * delta)

	# Apply the motion effect to the avatar.
	motion = move_and_slide(motion)


# Determine which way the user is trying to move the avatar.
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed('right')) - int(Input.is_action_pressed('left'))
	axis.y = int(Input.is_action_pressed('down')) - int(Input.is_action_pressed('up'))
	return axis.normalized()


# Apply a stopping force with friction to the avatar.
func apply_friction(amount):
	if motion.length() > amount:
		motion -= (motion.normalized() * amount)
	else:
		motion = Vector2.ZERO
	

# Apply vector force to this little guy in some direction.
func apply_force(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
