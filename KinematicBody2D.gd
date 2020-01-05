extends KinematicBody2D

# This thing is the primary speed element.
export (int) var speed = 400

# Todo: Understand what Vector2() does
var velocity = Vector2()

# This reads our inputs, and assigns a 'weight' to one of the axes directions.
func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('right'):
        velocity.x += 1
    if Input.is_action_pressed('left'):
        velocity.x -= 1
    if Input.is_action_pressed('down'):
        velocity.y += 1
    if Input.is_action_pressed('up'):
        velocity.y -= 1
	# TODO: What does normalized() do?
    velocity = velocity.normalized() * speed

# This fucking thing is never called, and then move and slide is just in here doing
# whatever in the fuck it wants.  I don't Understand.
func _physics_process(delta):
    get_input()
    velocity = move_and_slide(velocity)
    print(velocity)