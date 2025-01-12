class_name Cow_Common
extends Animal

@export_category("Type Settings")
@export_enum("baby", "female", "male") var gender = "baby"
@export_enum("black", "blonde", "brown", "pink") var color = "black"

func _ready() -> void:
	super._ready()
	add_to_group("cow")
	sprite.texture = load(path_to_texture + "/" + gender + "__cow__" + color + ".png")
	$StateChart.set_expression_property("active_food_process", active_food_process)
	$StateChart.set_expression_property("active_partner_process", active_partner_process)
		
func update_partner(new_partner: Animal):
	partner = new_partner
	emotions.show_emotion(emotions.LONELY, sprite)
	emotions.show_emotion(emotions.LONELY, new_partner.sprite)
	$StateChart.set_expression_property("partner", new_partner)


func _on_idle_state_entered() -> void:
	direction = Vector2.ZERO
	animation.play("idle_side")


func _on_walk_state_entered() -> void:
	direction = random_dir()
		
	if direction.x > 0:
		sprite.flip_h = true
	if direction.x < 0:
		sprite.flip_h = false
		
	animation.play("walk_side")


func _on_eat_state_entered() -> void:
	emotions.show_emotion(emotions.HUNGRY, sprite)
	direction = Vector2.ZERO
	animation.play("eat_side")
	#looking for grass


func _on_drink_state_entered() -> void:
	emotions.show_emotion(emotions.THIRSTY, sprite)
	direction = Vector2.ZERO
	animation.play("drink_side")
	#looking for water


func _on_eat_state_exited() -> void:
	#if find grass
	var have_find_grass = true
	emit_signal("find_food", have_find_grass)


func _on_drink_state_exited() -> void:
	#if find water
	var have_find_water = true
	emit_signal("find_water", have_find_water)

	
func _on_timer_partner_timeout():
	$StateChart.set_expression_property("find_partner", false)
	timer_partner.stop()

func _on_hurt_body_entered(body: Node2D) -> void:
	if active_partner_process:
		if body != self && !partner:
			if !body.partner:
				if (gender == "male" && body.gender == "female") or (gender == "female" && body.gender == "male"): 
					update_partner(body)
					body.update_partner(self)

func _on_walk_state_physics_processing(delta: float) -> void:
	if direction == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = direction * randi_range(speed_walk_min, speed_walk_max) * delta
				
	move_and_slide()


func _on_join_partner_state_physics_processing(delta: float) -> void:
	if direction == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = direction * randi_range(speed_walk_min, speed_walk_max) * delta
				
	move_and_slide()


func _on_join_partner_state_entered() -> void:
	if active_partner_process:
		if timer_partner.is_stopped():
			$StateChart.set_expression_property("find_partner", true)
			current_happinest += emotions.get_happinest(emotions.LONELY)
			if !timer_partner.is_connected("timeout", _on_timer_partner_timeout):
				timer_partner.connect("timeout", _on_timer_partner_timeout)
			timer_partner.start(minute_between_partner*60)
			emotions.show_emotion(emotions.LONELY, partner.sprite)
	
		direction = global_position.direction_to(partner.global_position)
	else:
		direction = random_dir()
		
	if direction.x > 0:
		sprite.flip_h = true
	if direction.x < 0:
		sprite.flip_h = false
		
	animation.play("walk_side")
