extends Node2D
class_name FlipHandler

func handle_flip(character_body: CharacterBody2D) -> void:
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
