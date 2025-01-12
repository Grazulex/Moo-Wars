extends Resource
class_name AnimalFoodResource

@export var active_food_process: bool
@export_range(1, 360) var minute_between_food : int
@export_range(1, 360) var minute_between_water : int
