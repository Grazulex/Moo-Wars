extends Node2D
class_name  MovementHandler

@export var movement_speed: float = 0.0
@export var timer_min_range : int = 3
@export var timer_max_range : int = 10

@onready var timer: Timer = $Timer

var direction: Vector2 = Vector2.ZERO
var character_body= CharacterBody2D

func _ready() -> void:
	SignalBus.connect("on_hit", on_hit)

func initialize(character: CharacterBody2D) -> void:
	character_body = character
	set_direction()

func handle_movement(delta: float) -> void:
	if direction != character_body.velocity:
		if direction == Vector2.ZERO:
			handle_deceleration(delta)
		if direction != Vector2.ZERO:	
			character_body.velocity = direction * movement_speed * delta
			character_body.animation_player.play("walk")
	
func handle_deceleration(_delta: float) -> void:
	character_body.velocity = Vector2.ZERO
	character_body.animation_player.play("idle")


func _on_timer_timeout() -> void:
	set_direction()
	
func on_hit(body: Node2D) -> void:
	if !body.is_in_group("limit"):
		return
	direction.x = -direction.x
	direction.y = -direction.y

func set_direction():
	randomize()
	direction = Vector2(randi_range(-1,1),randi_range(-1,1))
	timer.start(randi_range(timer_min_range, timer_max_range))
