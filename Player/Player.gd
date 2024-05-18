extends Entity
var save_manager: SaveManager = SaveManagerSingleton

# INFO: PlayerStats are here.
func _update_after_load() -> void:
	match properties.character_class:
		0: pass			 # Medium Class
		1: properties.speed *= 0.8  # Heavy class
		2: properties.speed *= 1.2  # Light Class
	print(properties.speed)
	
	var player_stats := get_node("Camera2D/PlayerStats")
	var text := "Name: %s\nHealth: %s\nLevel: %s\nClass: %s\nSpeed: %s" % [properties.name, properties.health, properties.character_level, properties.characterClass.keys()[properties.character_class], properties.speed]
	player_stats.text = text

func _ready() -> void:
	super()
	_update_after_load()
	save_manager.register(save_character)
	save_manager.FinishedSaving.connect(load_character)
	
func movement_handler(direction):
	super(direction)
	
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

func save_character() -> Array:
	var player_save = PlayerSaveResource.new()
	player_save.character = properties
	player_save.position = transform
	player_save.stats = {"debug": true}
	return ["PlayerSave", player_save]
	
func load_character() -> void:
	var resource: PlayerSaveResource = save_manager.get_resource("PlayerSave")
	if not resource: return
	properties = resource.character
	transform = resource.position
	# INFO: This Prints the stats from PlayerSaveResource
	print(resource.stats)
	super._ready()
	_update_after_load()
	return
