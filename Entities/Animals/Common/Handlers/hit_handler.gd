extends Node2D
class_name HitHandler

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var timer: Timer = $Timer

@export var size_rect: Vector2 = Vector2(16,16)
@export var disabled_time : float = 0.0

var follow_body= CharacterBody2D

func _ready() -> void:
	timer.timeout.connect(in_disable_timer_timeout)

func initialize(character: Node2D) -> void:
	follow_body = character	
	collision_shape_2d.shape.set_size(size_rect)
	
func handle_collision(_delta: float) -> void:
	global_position = follow_body.global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	collision_shape_2d.set_deferred("disabled", true)
	timer.start(disabled_time)
	SignalBus.emit_on_hit(body)

func in_disable_timer_timeout() -> void:
	collision_shape_2d.disabled = false
