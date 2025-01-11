extends Node
class_name Water

signal find_water

@export var minute_between_food: int = 10

@onready var timer_water: Timer = $Timer

func _ready() -> void:
	find_water.connect(_on_find_water)

func _on_find_water(finding: bool = true):
	if timer_water.is_stopped():
		timer_water.start(minute_between_food * 60)

func _on_timer_timeout() -> void:
	timer_water.stop()
