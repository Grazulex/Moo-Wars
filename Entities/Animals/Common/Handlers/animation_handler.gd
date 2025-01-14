extends Node

class_name AnimationHandler

@export var idle_animation: String = "idle"
@export var walk_animation: String = "walk"

var animation_player: AnimationPlayer

func initialize(_animation_player: AnimationPlayer) -> void:
	self.animation_player = _animation_player

func play(state: String) -> void:
	if animation_player and animation_player.current_animation != state:
		animation_player.play(state)

func play_idle() -> void:
	play(idle_animation)

func play_walk() -> void:
	play(walk_animation)
