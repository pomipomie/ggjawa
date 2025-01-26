extends Area2D

@onready var bubble_scene = preload("res://Enemys/Bubble_Bad.tscn")

var random = RandomNumberGenerator.new()
var bool_spawn = true

func _ready():
	random.randomize()

func start_spawning():
	set_process(false)

func _process(_delta):
	pass

func spawn():
	if bool_spawn:
		$Timer.start()
		var bubble_instance = bubble_scene.instantiate()
		bubble_instance.position = Vector2(random.randi_range(0,4063),random.randi_range(-8,660))
		add_child(bubble_instance)

func _on_timer_timeout() -> void:
	bool_spawn = true
	spawn()
	pass
