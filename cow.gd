extends CharacterBody2D

enum COW_STATE {IDLE, WALK}

@export var move_speed: float = 20.0

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D

var move_direction
var current_state = COW_STATE.IDLE

func _ready():
	#select_new_direction()
	pick_new_state()

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Vector2.RIGHT
	
	velocity = direction * move_speed
	pick_new_state()
	move_and_slide()

func select_new_direction():
	move_direction = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	)

func pick_new_state():
	if current_state == COW_STATE.IDLE:
		current_state = COW_STATE.WALK
		state_machine.travel("walk")
		select_new_direction()
	else:
		current_state = COW_STATE.IDLE
		state_machine.travel("idle")
