@tool
extends Entity

@export var character_sprite_frames: SpriteFrames:
	set(new_sprite):
		character_sprite_frames = new_sprite
		if Engine.is_editor_hint():
			$AnimatedSprite2D.sprite_frames = new_sprite
@export_range(1, 300, 1) var aggro_circle_radius: float:
	set(new_value):
		aggro_circle_radius = clampf(new_value, 1, 300)
		if Engine.is_editor_hint():
			$Area2D/CollisionShape2D.shape.radius = aggro_circle_radius

@onready var area: Area2D = $Area2D
var target = null

func _ready():
	super()
	$Area2D/CollisionShape2D.shape = CircleShape2D.new()
	$Area2D/CollisionShape2D.shape.radius = aggro_circle_radius
	if Engine.is_editor_hint(): return
	$AnimatedSprite2D.sprite_frames = character_sprite_frames

func _process(_delta):
	if not target: return
	velocity = global_position.direction_to(target.global_position) * properties.speed
	move_and_slide()

func _check_player_area() -> Node2D: ## Searches Aggro Area to check if the Player is inside it. Returns Player (Node2D) if yes, null if no.
	for object in area.get_overlapping_bodies():
		if object is Entity and object.entity_type == "PLAYER":
			return object
	return null

# INFO: Area entered and exited signals are connected here. I do not know whether this is good to leave or not, but it works so im leaving it here.
func _on_area_2d_body_entered(_body):
	target = _check_player_area()

func _on_area_2d_body_exited(_body):
	target = _check_player_area()
