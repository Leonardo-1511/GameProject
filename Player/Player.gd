extends CharacterBody2D

@export_category("Settings")
@export var speed : int = 200
@export var animation: AnimationPlayer
@export var char: EntityResource


func _physics_process(_delta: float) -> void:
	var direction : Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed

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
	match char.character_class:
		0: pass			 # Medium Class
		1: speed *= 0.8  # Heavy class
		2: speed *= 1.2  # Light Class
	
	var player_stats := get_node("Camera2D/PlayerStats")
	var text := "Name: %s\nHealth: %s\nLevel: %s\nClass: %s\nSpeed: %s" % [char.name, char.health, char.character_level, char.characterClass.keys()[char.character_class], speed]
	player_stats.text = text
