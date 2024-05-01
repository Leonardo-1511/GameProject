extends CharacterBody2D
class_name Entity

@export_enum("PLAYER", "ENEMY", "OBJECT") var entity_type: String
@export var properties: EntityResource
@export var animation: AnimationPlayer
@export var inventory: Array[ItemResource]

var blacklisted_functions = []

func _ready() -> void:
	match entity_type:
		"PLAYER": print("player"); _player()
		"ENEMY": print("enemy"); _enemy()
		"OBJECT": print("object"); _object()
		_: print(entity_type+" notfound"); assert(false, "Entity has no Type.")

func _player():
	pass
func _enemy():
	set_physics_process(false)
func _object():
	set_physics_process(false)

func _physics_process(delta):
	var direction : Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	movement_handler(delta, direction)

func movement_handler(_delta, direction): ## _physics_process() calls this, direction comes stright from Input.get_vector
	velocity = direction * properties.speed
	move_and_slide()
