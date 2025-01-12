extends Node2D
class_name CollisionHandler

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@export var size_rect: Vector2 = Vector2(16,16)
@export var looking_for_bodies : Array[String] = []

var character_body= CharacterBody2D

func initialize(character: CharacterBody2D) -> void:
	character_body = character
	collision_shape_2d.shape.set_size(size_rect)
	
func handle_collision(_delta: float) -> void:
	global_position = character_body.global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	print_debug("body", body)
