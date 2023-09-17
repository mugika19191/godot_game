extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		$AnimatedSprite3D.frame=1
	move_and_slide()
func _input(event):
	input_event.get_name()
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir == Vector2(0,-1):
		$AnimatedSprite3D.play("up")
	if input_dir == Vector2(0,1):
		$AnimatedSprite3D.play("down")
	if input_dir == Vector2(1,0):
		$AnimatedSprite3D.play("right")
	if input_dir == Vector2(-1,0):
		$AnimatedSprite3D.play("left")
	if input_dir.x >0 && input_dir.y > 0:
		$AnimatedSprite3D.play("down_right")
	if input_dir.x <0 && input_dir.y > 0:
		$AnimatedSprite3D.play("down_left")
	if input_dir.x >0 && input_dir.y < 0:
		$AnimatedSprite3D.play("up_right")
	if input_dir.x <0 && input_dir.y < 0:
		$AnimatedSprite3D.play("up_left")
		
		
