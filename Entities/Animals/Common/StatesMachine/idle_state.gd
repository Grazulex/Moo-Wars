extends State
class_name IdleState

func enter() -> void:
	state_owner.animation_handler.play_idle()

func update(_delta: float) -> void:
	if state_owner.movement_handler.is_moving():
		state_owner.state_machine.transition_to(state_owner.walk)
