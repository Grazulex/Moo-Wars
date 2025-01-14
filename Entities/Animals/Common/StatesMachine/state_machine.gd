extends Node

class_name StateMachine

@export var state_owner: Node = null

var current_state: State = null

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_owner = state_owner

func transition_to(new_state: State) -> void:
	if current_state != null:
		current_state.exit() 
	current_state = new_state
	if current_state != null:
		current_state.enter()

func update(delta: float) -> void:
	if current_state != null:
		current_state.update(delta)
