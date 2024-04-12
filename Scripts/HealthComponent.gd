extends Node2D
class_name HealthComponent

signal health_changed(current_health) ## Triggers on every Health change, positive or negative.
signal damaged(damage_amount) ## Triggers whenever the damage() function is called.
signal death ## Triggers when the Player has exactly 0 HP. Checked on Health setter.

@export var character_resource: CharacterResource
@export var save_manager: SaveManager

var max_health = character_resource.max_health
var character_health = character_resource.health


var current_health: int = character_health:
	set(new_health): 
		current_health = clamp(new_health, 0, max_health)
		emit_signal("health_changed", current_health)
		if current_health <= 0: emit_signal("death")


func damage(damage_amount: float) -> void:
	current_health -= roundi(damage_amount)
	emit_signal("damaged", damage_amount)


func _on_save_manager_start_saving() -> void:
	character_resource.health = character_health
