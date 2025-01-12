extends Node2D
class_name FlipHandler

var last_velocity_x : int = 0
var character_body= CharacterBody2D

func initialize(character: CharacterBody2D) -> void:
	character_body = character
	
func handle_flip() -> void:
	if last_velocity_x == character_body.velocity.x:
		return
		
	if character_body.velocity.x < 0 :
		if character_body.variants.is_flipped:
			character_body.sprite_2d.flip_h = true
		else:
			character_body.sprite_2d.flip_h = false
		
	if character_body.velocity.x > 0 :
		if character_body.variants.is_flipped:
			character_body.sprite_2d.flip_h = false
		else:
			character_body.sprite_2d.flip_h = true		
