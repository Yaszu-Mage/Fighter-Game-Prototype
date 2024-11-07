extends Control
signal properties
@onready var fight_interact_ui = $HFlowContainer
var players = []
var enemies = []
@onready var prison_realm = $HBoxContainer
var turn = true
@onready var fight = $HFlowContainer/VboxContainer/PanelContainer/Buttons/Options/Fight
@onready var item = $HFlowContainer/VboxContainer/PanelContainer/Buttons/Options/Item
@onready var inspect = $HFlowContainer/VboxContainer/PanelContainer/Buttons/Options/Inspect
@onready var special = $HFlowContainer/VboxContainer/PanelContainer/Buttons/Options/Special
@onready var tag = $"HFlowContainer/VboxContainer/PanelContainer/Buttons/Sub-Options/Tag"
@onready var scroll = $"HFlowContainer/Drop-Down/TabContainer/Fight/VBoxContainer"
var current_focused = 0
var player_scene_ref = []
var enemy_scene_ref = []
var player_ui_scene = preload("res://scenes/player_fight_ui.tscn")
var player_example_idea = [10,10,false,1,0,10,10]
# -1 not pressed, 0 fight pressed, 1 item pressed, 2 inspect pressed, 3 special pressed, 4 tag pressed
var button_pressed = -1
signal button_changed
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
		fight_interact_ui.visible = true
	else:
		fight_interact_ui.visible = false
func set_property(player : int,prop : String,value):
	match prop:
		"health":
			player_scene_ref[player].set_health(value)
		"special":
			player_scene_ref[player].set_special(value)
		"focus":
			player_scene_ref[player].set_focus(value)

func turn_cycle():
	if turn:
		fight_interact_ui.visible = true
		await button_changed
		match button_pressed:
			0:
				pass
		button_pressed = -1
	else:
		fight_interact_ui.visible = false


func _on_fight_pressed():
	button_pressed = 0
	button_changed.emit()
func _on_item_pressed():
	button_pressed = 1
	button_changed.emit()
func _on_inspect_pressed():
	button_pressed = 2
	button_changed.emit()
func _on_special_pressed():
	button_pressed = 3
	button_changed.emit()
func _on_tag_pressed():
	button_pressed = 4
	button_changed.emit()

func _input(event):
	if event.is_action_pressed("ui_up"):
		$"HFlowContainer/Drop-Down/TabContainer/Fight/VBoxContainer".set_deferred("scroll_vertical",scroll.scroll_vertical - 128)
		current_focused =+ 1
		current_focused = wrapi(current_focused,-1,current_focused)
	if event.is_action_pressed("ui_down"):
		$"HFlowContainer/Drop-Down/TabContainer/Fight/VBoxContainer".set_deferred("scroll_vertical",scroll.scroll_vertical + 128)
		current_focused =- 1
		current_focused = wrapi(current_focused,-1,current_focused)
	if event.is_action_pressed("ui_right"):
		$"HFlowContainer/Drop-Down/TabContainer".current_tab = $"HFlowContainer/Drop-Down/TabContainer".current_tab + 1
	if event.is_action_pressed("ui_left"):
		$"HFlowContainer/Drop-Down/TabContainer".current_tab = $"HFlowContainer/Drop-Down/TabContainer".current_tab - 1
