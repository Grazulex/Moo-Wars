extends Node

var house_scene = preload("res://Entities/Props/Houses/houses_entity.tscn")

@onready var level: Level = $"../Level"

func _ready() -> void:
	var house = house_scene.instantiate()
	house.global_position = level.get_position_markers("Marker_fence_2")
	add_child(house)
	
