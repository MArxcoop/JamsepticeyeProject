extends CharacterBody2D


const SPEED = 80
const JUMP_VELOCITY = -400.0
var ghost = false
const WHITE = Color(1.0, 1.0, 1.0, 1.0)
const REGCOLOR = Color(0.0, 0.0, 0.0, 0.341)

func _physics_process(float) -> void:
#region Movment code
	var direction := Input.get_axis("left", "right")
	var yDirection := Input.get_axis("up", "down")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if yDirection:
		velocity.y = yDirection * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
#endregion
#region Disable and enable collision
	# When ghost is true the collision will be disabled 
	if ghost == true:
		$CollisionShape2D.set_deferred("disabled",true)
		$Sprite2D.modulate = Color(WHITE)
	# When ghost is false the collision shape will be enabled
	elif ghost == false:
		$CollisionShape2D.set_deferred("disabled",false)
		$Sprite2D.modulate = Color(REGCOLOR)
#endregion
		
	move_and_slide()
	

func _input(event: InputEvent) -> void:
#region Setting ghost on and off
	# When q is pressed and ghost is false it sets ghost to true
	if Input.is_action_just_pressed("ghost") and ghost == false:
		ghost = true
		print("TRUE")
	# When q is pressd and ghost is true it sets ghost to false
	elif Input.is_action_just_pressed("ghost") and ghost == true:
		ghost = false
		print("FALSE")
#endregion
		
func _process(delta: float) -> void:
	pass

#region rigid body phasing
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Movable"):
		body.collision_mask = 1
		body.collision_layer = 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Movable"):
		body.collision_mask = 2
		body.collision_layer = 2
#endregion
