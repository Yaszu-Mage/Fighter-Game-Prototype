extends PanelContainer
@onready var health = $VBoxContainer/HBoxContainer/SpinBox
@onready var special = $VBoxContainer/HBoxContainer2/SpinBox
@onready var focus = $VBoxContainer/HBoxContainer3/CheckBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_health(health_points):
	health.value = health_points
	
func set_focus(focus_value):
	focus.toggle_mode = focus_value
	
func set_special(special_points):
	special.value = special_points

func set_max_health(health_points):
	health.max_value = health_points
func set_max_special(special_points):
	special.max_value = special_points
