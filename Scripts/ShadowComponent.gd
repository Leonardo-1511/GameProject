extends Node2D
class_name ShadowComponent

@export var sprite : Texture2D
@export var shadowScale : Vector2
@export var shadowOffset : Vector2
@export_range(0, 1, 0.05) var opacity : float = 1

@onready var shadow : Sprite2D = get_node("Shadow")

func set_shadow_properties():
	shadow.modulate.a = opacity
	shadow.texture = sprite
	shadow.position = shadowOffset
	shadow.scale = shadowScale

func _ready() -> void:
	set_shadow_properties()
