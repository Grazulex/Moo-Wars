extends CharacterBody2D

@export var variants: CommonResource

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var flip_handler: FlipHandler = $Handlers/FlipHandler
@onready var movement_handler: MovementHandler = $Handlers/MovementHandler
@onready var hit_handler: HitHandler = $Handlers/HitHandler
@onready var animation_handler: AnimationHandler = $Handlers/AnimationHandler

@onready var state_machine: Node = $StateMachine

@onready var idle: IdleState = $StateMachine/Idle
@onready var walk: WalkState = $StateMachine/Walk


func _ready() -> void:
	add_to_group(variants.name_group)
	set_sprite()
	movement_handler.initialize(self)
	flip_handler.initialize(self)
	hit_handler.initialize(self)
	animation_handler.initialize(animation_player)
	
	#state_machine.state_owner = self
	
	state_machine.transition_to(idle)

func set_sprite():
	var properties = variants.get_script().get_script_property_list()
	var color = ""
	var gender = ""
	
	for property in properties:	
		match property.name:
			"color":
				color = "__" + variants.color
			"gender":
				gender = variants.gender + "__"
	
	if (color != "" or gender != "") and !variants.root_path_texture:
		print_debug("Root path texture must be set if color or gender is used.")
		return

	if variants.root_path_texture:
		var texture_path = variants.root_path_texture + "/" + gender + variants.name_group + color + ".png"
		if FileAccess.file_exists(texture_path):
			sprite_2d.texture = load(texture_path)
		else:
			print_debug("Texture file not found: " + texture_path)

func _physics_process(delta: float) -> void:
	movement_handler.handle_movement(delta)
	move_and_slide()
	hit_handler.handle_collision(delta)
	flip_handler.handle_flip()
	
	state_machine.update(delta)
