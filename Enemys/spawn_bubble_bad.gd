extends Area2D

@onready var bubble_scene = preload("res://Enemys/spawn_bubble_bad.tscn")

var bool_spawn = true
var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()

func start_spawning():
	set_process(false)

func _process(_delta):
	spawn()

func spawn():
	$Timer.start()
	bool_spawn = false
	var bubble_instance = bubble_scene.instantiate()
	bubble_instance.position = Vector2(random.randi_range(1160,1163),random.randi_range(-8,360))
	add_child(bubble_instance)

func _on_timer_timeout() -> void:
	bool_spawn = true
	pass
