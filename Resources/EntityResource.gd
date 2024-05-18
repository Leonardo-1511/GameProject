extends Resource
class_name EntityResource


@export var name: String ## Name for this Entity.
@export var max_health: float ## Maximum possible Health.
@export var health: float = max_health: ## Current Health (Cannot go over max Health).
	set(new_val):
		health = clampf(new_val, 0, max_health)
@export var base_speed: float = 500 ## Speed for the Character without modifiers.
var speed ## The actual Speed, with modifiers. Changed within code (esp. classes modifier)
