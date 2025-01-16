extends Control

@onready var hud: Control = $HUD
@onready var menu: Control = $Menu
@onready var main_2d: Node2D = $Main2D
@onready var camera: Camera2D = $Main2D/Camera

var level_instance

func _ready() -> void:
	unload_level()

func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	level_instance = null
	
func load_level(level_name: String):
	unload_level()
	var level_path := "res://Tests/%s.tscn" % level_name
	var level_resource := load(level_path)
	if (level_resource):
		level_instance = level_resource.instantiate()
		main_2d.add_child(level_instance)


func _on_button_pressed() -> void:
	load_level("test_animals")
