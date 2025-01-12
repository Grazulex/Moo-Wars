extends CommonResource
class_name CownCommonResource

@export_enum("baby", "female", "male") var gender = "baby"
@export_enum("black", "blonde", "brown", "pink") var color = "black"

func _init() -> void:
	local_animations= ["bend", "drink", "eat"]
