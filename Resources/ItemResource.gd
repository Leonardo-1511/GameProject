extends Resource
class_name ItemResource

signal DurabilityChanged(new_durability) ## Fires whenever the Durability value is changed. Does not fire is Durability is -1 (aka Infinite).
signal ItemBroken ## Fires when the Durability is 0.

@export var item_name: String ## The Name that will show in the Inventory.
@export var icon: Texture ## An Icon for both the Overworld item and possibly the Inventory one. (not known if it will be used)
@export var bonus: bool = false ## Probably not going to be used. Made it anyway in case I change my mind.
@export var durability: float = -1: ## Setting this Value to -1 makes it Unbreakable.
	set(new_val):
		if durability == -1:
			pass
		else:
			durability = clampf(new_val, 0, INF)
			DurabilityChanged.emit(durability)
			if durability == 0: ItemBroken.emit()
