extends Node
class_name Food

signal find_food

@export var minute_between_food: int = 10

@onready var timer: Timer = $Timer

func _ready() -> void:
	find_food.connect(_on_find_food)

func _on_find_food(finding: bool = true):
	if timer.is_stopped():
		timer.start(minute_between_food * 60)

func _on_timer_timeout() -> void:
	timer.stop()
