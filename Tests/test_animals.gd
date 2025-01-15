extends Node

var bear_scene = preload("res://Entities/Animals/Bears/bear_entity.tscn")
var chicken_scene = preload("res://Entities/Animals/Chickens/chicken_entity.tscn")
var cow_common_scene = preload("res://Entities/Animals/Cows_Common/cow_common_entity.tscn")

@onready var level: Level = $"../Level"


func _ready() -> void:
	var bear = bear_scene.instantiate()
	bear.global_position = level.get_position_markers("Marker_forest_1")
	add_child(bear)
	
	var chicken = chicken_scene.instantiate()
	chicken.variants.color = "black"
	chicken.global_position = level.get_position_markers("Marker_fence_2")
	add_child(chicken)
	
	var chicken2 = chicken_scene.instantiate()
	chicken2.variants.color = "red"
	chicken2.global_position = level.get_position_markers("Marker_fence_2")
	add_child(chicken2)
	
	var cow = cow_common_scene.instantiate()
	cow.variants.color = "blonde"
	cow.variants.gender = "male"
	cow.global_position = level.get_position_markers("Marker_fence_1")
	add_child(cow)
	
	var cow2 = cow_common_scene.instantiate()
	cow2.variants.gender = "female"
	cow2.global_position = level.get_position_markers("Marker_fence_1")
	add_child(cow2)
