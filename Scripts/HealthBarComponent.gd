extends Node2D
class_name HealthBarComponent

@export var health_component: HealthComponent
@onready var health_bar = $HealthBar
@onready var health_bar_delayed = $HealthBar/HealthBarDelayed
@onready var max_health_bar_size = health_bar.size.x

func _ready() -> void:
	health_component.death.connect(func on_death(): print("DEAD!!"))
	health_component.health_changed.connect(health_changed)
	
func health_changed(current_health: float) -> void:
	var health_percentage =  (health_component.current_health / health_component.max_health)
	var tween = get_tree().create_tween()
	health_bar.size.x = max_health_bar_size * health_percentage
	tween.tween_property(health_bar_delayed, "size:x", max_health_bar_size * health_percentage, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC).set_delay(0.2)
