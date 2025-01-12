extends Node

var bear_scene = preload("res://Entities/Animals/Bears/bear_entity.tscn")
var chicken_scene = preload("res://Entities/Animals/Chickens/chicken_entity.tscn")
var cow_common_scene = preload("res://Entities/Animals/Cows_Common/cow_common_entity.tscn")

func _ready() -> void:
	var bear = bear_scene.instantiate()
	add_child(bear)
	
	var chicken = chicken_scene.instantiate()
	chicken.variants.color = "black"
	chicken.global_position = Vector2(50,50)
	add_child(chicken)
	
	var cow = cow_common_scene.instantiate()
	cow.variants.color = "blonde"
	cow.variants.gender = "male"
	cow.global_position = Vector2(-20,-20)
	add_child(cow)
	
	var cow2 = cow_common_scene.instantiate()
	cow2.variants.gender = "female"
	cow2.global_position = Vector2(20,20)
	add_child(cow2)
