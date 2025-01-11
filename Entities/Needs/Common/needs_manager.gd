extends Node

enum {FOOD, WATER}

@export var node_need: Array[Dictionary] = [
	{"id": 0, "name": "Food", "path": "res://Entities/Needs/Food/food.tscn"},
	{"id": 1, "name": "Water", "path": "res://Entities/Needs/Water/water.tscn"}
]

var needs: Dictionary = {}

func _ready():
	for need in node_need:
		if need.has("id") and need.has("path"):
			var scene = load(need["path"])
			if scene:
				needs[need["id"]] = scene


func enable_need(need_id: int):
	if needs.has(need_id):
		needs[need_id].instantiate()
