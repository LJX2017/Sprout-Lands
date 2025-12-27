extends CharacterBody2D

@export var move_speed: float = 100.0

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = direction * move_speed
	
	move_and_slide()
