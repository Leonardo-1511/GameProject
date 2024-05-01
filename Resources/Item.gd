extends Resource
class_name ItemResource

@export var item_name: String ## The Name that will show in the Inventory.
@export var icon: Texture
@export var bonus: bool = false ## Probably not going to be used. Made it anyway in case I change my mind.
@export var durability: float = -1: ## Setting this Value to -1 makes it Unbreakable.
	set(new_val):
		if durability == -1:
			pass
		durability = clampf(new_val, 0, INF)
