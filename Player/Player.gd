extends CharacterBody2D

@export_category("Settings")
@export var animation: AnimationPlayer
@export var properties: CharacterResource
@export var save_manager: SaveManager


func _physics_process(_delta: float) -> void:
	var direction : Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * properties.speed

	if direction.is_zero_approx():
		animation.stop()
	if direction.x == 1:
		animation.play("Walk_Right")
	if direction.x == -1:
		animation.play("Walk_Left")
	if direction.y == 1:
		animation.play("Walk_Down")
	if direction.y == -1:
		animation.play("Walk_Up")

	move_and_slide()

func _ready() -> void:
	match properties.character_class:
		0: pass			 # Medium Class
		1: properties.speed *= 0.8  # Heavy class
		2: properties.speed *= 1.2  # Light Class
	
	var player_stats := get_node("Camera2D/PlayerStats")
	var text := "Name: %s\nHealth: %s\nLevel: %s\nClass: %s\nSpeed: %s" % [properties.name, properties.health, properties.character_level, properties.characterClass.keys()[properties.character_class], properties.speed]
	player_stats.text = text
	
	save_manager.register(save_character)
	save_manager.FinishedSaving.connect(load_character)
	
func save_character() -> Array:
	var player_save = PlayerSaveResource.new()
	player_save.character = properties
	player_save.position = transform
	player_save.stats = {"debug": true}
	return ["PlayerSave", player_save]
	
func load_character() -> void:
	var resource = save_manager.loaded_files["PlayerSave"].duplicate(true)
	properties = resource.character
	transform = resource.position
	print(resource.stats)
	_ready()
	return
