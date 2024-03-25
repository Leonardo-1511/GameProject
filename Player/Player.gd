extends CharacterBody2D

@export_category("Settings")
@export var speed : int = 200
@export var animation : AnimationPlayer

func _physics_process(_delta: float) -> void:
	var direction : Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed

	if direction.is_zero_approx():
		animation.stop()
	if direction.x == 1:
		animation.play("Walk_Right")
	if direction.x == -1:
		animation.play("Walk_Left")
	if direction.y == 1:
		animation.play("Walk_Down")
	if direction.y == -1:
		animation.play("Walk_Up")

	move_and_slide()
	
