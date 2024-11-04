extends CharacterBody3D

@onready var agent = $NavigationAgent3D
var movement_delta: float
var movement_speed: float = 15.0
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var bod
#health, effect, number, item,id
var enemy_data = [10,0,1,0,0]
func _ready():
	tracker_tick()
func _physics_process(delta):
	# Add the gravity.
	if !is_on_floor():
		velocity += get_gravity() * delta
		move_and_slide()
	else:
		movement_delta = movement_speed * delta
		var next_path_position: Vector3 = agent.get_next_path_position()
		var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_delta
		if agent.avoidance_enabled:
			agent.set_velocity(new_velocity)
		else:
			_on_navigation_agent_3d_velocity_computed(new_velocity)
		move_and_slide()
	move_and_slide()


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
 
func tracker_tick():
	if bod:
		agent.set_target_position(bod.position)
	await get_tree().create_timer(0.5).timeout
	tracker_tick()

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		agent.set_target_position(body.position)
		bod = body


func _on_area_3d_body_exited(body):
	if bod:
		if bod == body:
			bod = null


func _on_sense_body_entered(body):
	print("sense")
	if body.is_in_group("player"):
		print("bod is confirmed!")
		Global.fight.emit()
		var fight_root = Global.fight_root.instantiate()
		body.cam.current = false
		body.can_move = false
		fight_root.players.append(body.player_data)
		fight_root.world = -1
		fight_root.enemy.append(enemy_data)
		get_parent().get_parent().add_child(fight_root)
		Global.propertiesgiven.emit()


func _on_sense_body_exited(body):
	pass # Replace with function body.
