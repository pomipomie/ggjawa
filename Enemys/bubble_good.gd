extends CharacterBody2D

@onready var explotion_sound = $SoundBubbleGood
@onready var animated_sprite = $AnimatedSprite2D

var move_speed = 200
var zigzag_offset = 100
var zigzag_timer = 5
var gravity = 300

func _physics_process(delta):
	zigzag_timer += delta
	var zigzag_x = sin(zigzag_timer * 10) * zigzag_offset
	velocity.y += gravity * delta
	velocity.x = zigzag_x
	move_and_slide()

func _on_area_2d_area_entered(area):
	if area.is_in_group("player") or area.is_in_group("floor") or area.is_in_group("platform"):
		queue_free()
		pass

func explotion():
	explotion_sound.play()
	animated_sprite.play("explotion")
