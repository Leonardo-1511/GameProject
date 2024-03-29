extends Node2D
class_name HealthComponent

@export var max_health: int = 10


var current_health: int = max_health:
	set(new_health): 
		current_health = clamp(new_health, 0, max_health)
		if current_health == 0: death.emit()
		emit_signal("health_changed", current_health)
	get:
		return current_health

signal health_changed(current_health) ## Triggers on every Health change, positive or negative.
signal damaged(damage_amount) ## Triggers whenever the damaged() function is called.
signal death ## Triggers when the Player has exactly 0 HP. Checked on Health setter.


func damage(damage_amount: float) -> void:
	emit_signal("damaged", damage_amount)
	current_health -= damage_amount
