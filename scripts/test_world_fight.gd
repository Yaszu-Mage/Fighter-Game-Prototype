extends Node3D
@onready var cam = $Camera3D
var player_spawn_positions = []
var enemy_spawn_positions = []
signal readyran
# Called when the node enters the scene tree for the first time.
func _ready():
	cam.current = true
	player_spawn_positions.append($"player spawn pos".global_position)
	player_spawn_positions.append($"player spawn pos2".global_position)
	player_spawn_positions.append($"player spawn pos3".global_position)
	player_spawn_positions.append($"player spawn pos4".global_position)
	enemy_spawn_positions.append($"enemy spawn pos".global_position)
	enemy_spawn_positions.append($"enemy spawn pos2".global_position)
	enemy_spawn_positions.append($"enemy spawn pos3".global_position)
	enemy_spawn_positions.append($"enemy spawn pos4".global_position)
	readyran.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
