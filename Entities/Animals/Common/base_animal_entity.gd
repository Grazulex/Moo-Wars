extends CharacterBody2D

@export var variants: CommonResource

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	add_to_group(variants.name_group)
	set_sprite()
	if variants.local_animations:
		variants.animations.append_array(variants.local_animations)
		print_debug('Add new animations: ', variants.animations)

func set_sprite():
	pass
	
