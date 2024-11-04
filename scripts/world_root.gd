extends Node3D
@export var world = -1
var store_element = []
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.fight.connect(fight)
	for x in self.get_children().size():
		self.get_child(x).add_to_group("world")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func fight():
	for x in self.get_children().size():
		if self.get_child(x).is_in_group("world"):
			if self.get_child(x) is WorldEnvironment:
				var env = self.get_child(x)
				store_element.append(env)
				var restorekey = store_element.back()
				self.get_child(x).queue_free()
