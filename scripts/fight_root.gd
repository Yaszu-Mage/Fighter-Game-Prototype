extends Node3D
var players = []
var bg
#health,sp,focus,player number, animation,max health, max sp
var player_example_idea = [10,10,false,1,0,10,10]
#gets link to fighter player scene and fight ui
var fighter_player_scene = preload("res://scenes/playerfighterscene.scn")
var fight_ui = preload("res://scenes/fight_ui.tscn")
#health, special, effect, number, item,id, max health, max special
var enemy_example_idea = [10,10,0,1,0,1, 10, 10]
var enemy = []
var world = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#since this scene will be instantiated/loaded from test world, we need to give it specific properties according to the world
	await Global.propertiesgiven
	var fight_ui_inst = fight_ui.instantiate()
	fight_ui_inst.enemies = enemy
	fight_ui_inst.players = players
	add_child(fight_ui_inst)
	fight_ui_inst.properties.emit()
	match world:
		-1:
			var background = load("res://assets/fight_backgrounds/test_world.tscn")
			var back = background.instantiate()
			bg = back
			add_child(back)
	for x in players.size():
		#Here I get the amount of players and create their scenes, within the player_fighter scene animations, attacks and other things will be handled
		var player_fighter = fighter_player_scene.instantiate()
		player_fighter.data.append_array(players[x])
		add_child(player_fighter)
		player_fighter.data_given.emit()
		player_fighter.global_position = bg.player_spawn_positions[players[x][4]]
	for x in enemy.size():
		if enemy.size() <= 5:
			var rand = randi_range(0,2)
			if rand == 1:
				var gen_enemy = enemy[x]
				gen_enemy[1] = randi_range(0,4)
				enemy.append(gen_enemy)
			else:
				continue
	for x in enemy.size():
		match enemy[x][4]:
			0:
				var enemyscene = load("res://assets/enemy_fighter_scenes/basicenemyfighterscene.tscn").instantiate()
				enemyscene.data.append_array(enemy[x])
				enemyscene.data_given.emit()
				enemyscene.global_position = bg.enemy_spawn_positions[enemy[x][4]]
				add_child(enemyscene)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
