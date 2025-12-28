extends CharacterBody2D

enum COW_STATE {IDLE, WALK}

@export var move_speed: float = 20.0

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer

var walk_time = 2
var idle_time = 2

var move_direction = Vector2.RIGHT
var current_state = COW_STATE.IDLE

func _ready():
	#select_new_direction()
	pick_new_state()

func _physics_process(delta: float) -> void:
	if current_state == COW_STATE.WALK:
		velocity = move_direction * move_speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func select_new_direction():
	move_direction = Vector2(
		randi_range(0, 1) * 2 - 1,
		randi_range(0, 1) * 2 - 1
	)
	if move_direction.x < 0:
		sprite.flip_h = true
	elif move_direction.x > 0:
		sprite.flip_h = false

func pick_new_state():
	if current_state == COW_STATE.IDLE:
		current_state = COW_STATE.WALK
		state_machine.travel("walk")
		select_new_direction()
		timer.start(walk_time)
	else:
		current_state = COW_STATE.IDLE
		state_machine.travel("idle")
		timer.start(idle_time)


func _on_timer_timeout() -> void:
	pick_new_state()
