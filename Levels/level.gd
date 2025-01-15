extends Node2D
class_name Level

var markers = {}

func _ready() -> void:
	load_markers()

func get_position_markers(marker) -> Vector2:
	if markers.has(marker):
		return markers[marker]
	else:
		print_debug("no marker with this name: ", marker)
		return Vector2.ZERO

func load_markers():
	markers.clear()
	for child in get_children():
		if child is Node2D:
			for grandchild in child.get_children():
				if grandchild is Marker2D:
					markers[grandchild.name] = grandchild.global_position
