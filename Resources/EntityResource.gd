extends Resource
class_name EntityResource

signal health_changed(new_health)

@export var name: String
@export var health: int:
	set(n_health):
		health_changed.emit(n_health)
		health = n_health
