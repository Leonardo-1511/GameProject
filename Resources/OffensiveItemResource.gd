extends Resource
class_name OffensiveItemResource

@export var base_damage: int
@export var modifiers: float: ## Percentage modifier for the Weapon. Only positive number allowed.
	set(value):
		modifiers = clampf(value, 0, 500)
