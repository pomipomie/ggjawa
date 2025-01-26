extends CharacterBody2D

@export var speed: float = 300

func _ready():
	velocity.x =-speed

func _physics_process(_delta):
	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.is_in_group("platform") or area.is_in_group("player"):
		queue_free()
