extends CharacterBody2D

@export var properties: EntityResource
@export var character_sprite_frames: SpriteFrames
@export var equipped_item: OffensiveItemResource

@onready var health_comp = $HealthComponent
