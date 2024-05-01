extends ItemResource
class_name OffensiveItemResource

@export var base_damage: int ## Damage without any modifiers.
@export var modifiers: float = -1: ## Percentage modifier for the Weapon. Only positive numbers allowed.
	set(value):
		modifiers = clampf(value, 0, 500)
