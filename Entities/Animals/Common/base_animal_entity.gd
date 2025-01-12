extends CharacterBody2D

@export var variants: CommonResource

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var flip_handler: FlipHandler = $Handlers/FlipHandler
@onready var movement_handler: MovementHandler = $Handlers/MovementHandler

func _ready() -> void:
	add_to_group(variants.name_group)
	set_sprite()
	movement_handler.initialize(self)
	flip_handler.initialize(self)

func set_sprite():
	var properties = variants.get_script().get_script_property_list()
	var color = ""
	var gender = ""
	for property in properties:	
		if (property.name == "color" || property.name == "gender"):
			if !variants.root_path_texture:
				return
			if property.name == "color":
				color = "__"+variants.color
			if property.name == "gender":
				gender = variants.gender+"__"
	if color != "" || gender != "":
		sprite_2d.texture = load(variants.root_path_texture+"/"+gender+variants.name_group+color+".png")
	
	
func _physics_process(delta: float) -> void:
	movement_handler.handle_movement(delta)
	move_and_slide()
	flip_handler.handle_flip()
