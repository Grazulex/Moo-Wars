class_name Animal
extends CharacterBody2D

signal find_food
signal find_water

@export_category("Stats")
@export_subgroup("Healt stats")
@export var starting_happiness : int = 100

@export_subgroup("Food settings")
@export var active_food_process: bool = true
@export_range(1, 360) var minute_between_food : int = 15
@export_range(1, 360) var minute_between_water : int = 15

@export_subgroup("Parter settings")
@export var active_partner_process: bool = true
@export_range(1, 360) var minute_between_partner : int = 5

@export_category("Sprite Settings")
@export_dir() var path_to_texture
@export var speed_walk_min: int = 450
@export var speed_walk_max: int = 850

@onready var sprite: Sprite2D = $Animal
@onready var animation: AnimationPlayer = $AnimationPlayer

var direction : Vector2 = Vector2.ZERO
var emotions = EmotionsManager
var needs = NeedsManager

var current_happinest: int
var partner: Animal
var timer_food = Timer.new()
var timer_water = Timer.new()
var timer_partner = Timer.new()

func _ready() -> void:
	current_happinest = starting_happiness
	if active_food_process:
		NeedsManager.enable_need(NeedsManager.FOOD)
		NeedsManager.enable_need(NeedsManager.WATER)
		find_food.connect(_on_find_food)
		find_water.connect(_on_find_water)
		add_child(timer_food)
		add_child(timer_water)
	if active_partner_process:
		add_child(timer_partner)

func random_dir():
	var dir = Vector2()
	dir.x = randi_range(-1, 1)
	dir.y = randi_range(-1, 1)

	return dir

func random_pos(dir: Vector2):
	var vector: Vector2
	if dir.x != 0:
		var distance = randi_range(40, 100) * dir.x
		var final_position = (distance + self.global_position.x)
		vector = Vector2(final_position, self.global_position.y)
	if dir.y != 0:
		var distance = randi_range(40, 100) * dir.y
		var final_position = (distance + self.global_position.y)
		vector = Vector2(vector.x, final_position)
		
	return vector

func _on_find_food(finded: bool = true):
	if finded:
		current_happinest += emotions.get_happinest(emotions.HUNGRY)
	else:
		current_happinest -= emotions.get_happinest(emotions.HUNGRY)
	if timer_food.is_stopped():
		$StateChart.set_expression_property("need_food", false)
		if !timer_food.is_connected("timeout", _on_timer_food_timeout):
			timer_food.connect("timeout", _on_timer_food_timeout)
		timer_food.start(minute_between_food * 60)
	
func _on_find_water(finded: bool = true):
	if finded:
		current_happinest += emotions.get_happinest(emotions.THIRSTY)
	else:
		current_happinest -= emotions.get_happinest(emotions.THIRSTY)
		
	if timer_water.is_stopped():
		$StateChart.set_expression_property("need_water", false)
		if !timer_water.is_connected("timeout", _on_timer_water_timeout):
			timer_water.connect("timeout", _on_timer_water_timeout)
		timer_water.start(minute_between_water * 60)

func _on_timer_food_timeout():
	$StateChart.set_expression_property("need_food", true)
	timer_food.stop()

func _on_timer_water_timeout():
	$StateChart.set_expression_property("need_water", true)
	timer_water.stop()
