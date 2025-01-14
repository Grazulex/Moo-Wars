extends State

class_name WalkState

func enter() -> void:
	state_owner.animation_handler.play_walk()

func update(_delta: float) -> void:
	if not state_owner.movement_handler.is_moving():
		state_owner.state_machine.transition_to(state_owner.idle)
