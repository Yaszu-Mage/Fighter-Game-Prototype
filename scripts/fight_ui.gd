extends Control
signal properties
var players = []
var enemies = []
@onready var prison_realm = $HBoxContainer
# Turn is true when it is player's turn and false when it is enemies
var turn = false

var player_scene_ref = []
var enemy_scene_ref = []
var player_ui_scene = preload("res://scenes/player_fight_ui.tscn")
var player_example_idea = [10,10,false,1,0,10,10]
# Called when the node enters the scene tree for the first time.
func _ready():
	await properties
	for x in players.size():
		var inst_scene = player_ui_scene.instantiate()
		player_scene_ref.append(inst_scene)
		prison_realm.add_child(inst_scene)
		inst_scene.set_health(players[x][0])
		inst_scene.set_special(players[x][1])
		inst_scene.set_max_health(players[x][5])
		inst_scene.set_max_special(players[x][6])
	for x in enemies.size():
		var inst_scene = player_ui_scene.instantiate()
		enemy_scene_ref.append(inst_scene)
		inst_scene.set_health(enemies[x][0])
		inst_scene.set_special(enemies[x][1])
		inst_scene.set_max_health(enemies[x][5])
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if turn:
		pass

func set_property(player : int,prop : String,value):
	match prop:
		"health":
			player_scene_ref[player].set_health(value)
		"special":
			player_scene_ref[player].set_special(value)
		"focus":
			player_scene_ref[player].set_focus(value)

func turn_cycle():
	turn = true
