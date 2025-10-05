extends CharacterBody2D


const SPEED = 75
const JUMP_VELOCITY = -400.0
var ghost = false
const WHITE = Color(1.0, 1.0, 1.0, 1.0)
const REGCOLOR = Color(0.0, 0.0, 0.0, 0.341)

func _physics_process(float) -> void:
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
	if ghost == true:
		$CollisionShape2D.set_deferred("disabled",true)
		$Sprite2D.modulate = Color(WHITE)
	elif ghost == false:
		$CollisionShape2D.set_deferred("disabled",false)
		$Sprite2D.modulate = Color(REGCOLOR)

	move_and_slide()
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ghost") and ghost == false:
		ghost = true
		print("TRUE")
	elif Input.is_action_just_pressed("ghost") and ghost == true:
		ghost = false
		print("FALSE")
		
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Movable"):
		body.collision_mask = 1
		body.collision_layer = 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Movable"):
		body.collision_mask = 2
		body.collision_layer = 2
