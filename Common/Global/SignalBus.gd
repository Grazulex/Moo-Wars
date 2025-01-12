extends Node

signal on_hit(body: Node2D)

func emit_on_hit(body: Node2D) -> void:
	on_hit.emit(body)
