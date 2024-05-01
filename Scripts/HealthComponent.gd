extends Node2D
class_name HealthComponent

signal health_changed(current_health: int) ## Triggers on every Health change, positive or negative.
signal damaged(damage_amount: int) ## Triggers whenever the damage() function is called.
signal death ## Triggers when the Player has exactly 0 HP. Checked on Health setter.

@export var entity: Node2D
@onready var entity_resource: EntityResource = entity.properties


@onready var max_health = entity_resource.max_health
@onready var character_health = entity_resource.health


@onready var current_health: float = character_health:
	set(new_health): 
		current_health = clampi(new_health, 0, max_health)
		emit_signal("health_changed", current_health)
		if current_health <= 0: emit_signal("death")


func damage(damage_amount: float) -> void:
	current_health -= roundi(damage_amount)
	emit_signal("damaged", damage_amount)
