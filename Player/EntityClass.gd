## Extends CharacterBody2D and all it's functions. This Class has all the Functions that are needed for a basic Enemy or Player. Animations are not inbuilt, only referenced for ease of use. Using this is recommended especially because it's easier to reference this type than CharacterBody2D (which could be something else).
extends CharacterBody2D
class_name Entity

@export_enum("PLAYER", "ENEMY", "OBJECT") var entity_type: String ## Choose the type for this Object. Every option except Player will disable _physics_process(). If you need it anyways, either override the Type specific function (ex. _enemy()) or set it to Player and override the movement Handler.
@export var properties: EntityResource 		## These are NECESSARY for every Type except Object. (Still debating whether to support Objects here or not.)
@export var animation: AnimationPlayer 		## AnimationPlayer for the Sprites, you need to code these Animations yourself though.
@export var inventory: Array[ItemResource] 	## The Inventory for the Entity. Enemies should only have 1 Item, except overriden and coded otherwise.
@export var health_component: HealthComponent ## This is to simplify the use of HealthComponents, as they are mostly hidden. Primary use is Health checking and Damaging.
@export var equipped_weapon: OffensiveItemResource ## Weapon the Entity is currently using.

# INFO: Prints what Entity Type the Object is. (remove later)
func _ready() -> void: ## Calls a specific function depending on what type this Entity is (ex. _player() for PLAYER).
	properties.speed = properties.base_speed
	match entity_type:
		"PLAYER": print("player"); _player()
		"ENEMY": print("enemy"); _enemy()
		"OBJECT": print("object"); _object()
		_: print(entity_type+" notfound"); assert(false, "Entity has no Type.")

func _player() -> void: ## Type specific Function. Does nothing.
	pass
func _enemy() -> void: ## Type specific Function. Deactivates Physics Process
	set_physics_process(false)
func _object() -> void: ## Type specific Function. Deactivates Physics Process (debating on whether to leave this here or not).
	set_physics_process(false)

func _physics_process(_delta: float) -> void: ## Gets Input and calls movement_handler(direction).
	if entity_type == "PLAYER":
		var direction : Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
		movement_handler(direction)

func movement_handler(direction: Vector2) -> void: ## _physics_process() calls this, direction comes stright from Input.get_vector. Override with super() is recommended for Animations. This can be used for Enemies, just specify the Direction.
	velocity = direction * properties.speed
	move_and_slide()
	
#INFO: Prints Damage and durability.
func damage(other: Entity) -> void: ## Damage another Entity with the Equipped Weapon, also applies the modifier and degrades the Durability (if applicable).
	var damage_count := equipped_weapon.base_damage * equipped_weapon.modifiers
	equipped_weapon.durability += -1
	print(equipped_weapon.durability, "\n"+str(damage_count))
	other.health_component.damage(damage_count)
