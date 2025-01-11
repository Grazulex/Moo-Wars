extends Node

enum {HUNGRY, LONELY, THIRSTY}

@export var node_emotion: Array[Dictionary] = [
	{"id": 0, "name": "Hungry", "path": "res://Entities/Emotions/Hungry/hungry.tscn", "happinest" : 10},
	{"id": 1, "name": "Lonely", "path": "res://Entities/Emotions/Lonely/lonely.tscn", "happinest" : 10},
	{"id": 2, "name": "Thirsty", "path": "res://Entities/Emotions/Thirsty/thirsty.tscn", "happinest" : 10}
]

var emotions: Dictionary = {}

func _ready():
	for emotion in node_emotion:
		if emotion.has("id") and emotion.has("path"):
			var scene = load(emotion["path"])
			if scene:
				emotions[emotion["id"]] = scene

func show_emotion(emotion_id: int, target_sprite: Node2D, offset: Vector2 = Vector2(5, -3), timeout: float = 3.0):
	if emotions.has(emotion_id):
		var scene_instance = emotions[emotion_id].instantiate()
		if scene_instance:
			target_sprite.add_child(scene_instance)
			scene_instance.position = offset
			await remove_emotion_after_timeout(scene_instance, timeout)

func remove_emotion_after_timeout(emotion_instance: Node, timeout: float):
	await get_tree().create_timer(timeout).timeout
	if is_instance_valid(emotion_instance):
		emotion_instance.queue_free()
		
func get_happinest(emotion_id: int) -> int:
	for emotion in node_emotion:
		if emotion.has("id") and emotion["id"] == emotion_id:
			return emotion.get("happinest", 0)
	return 0	

func enable(emotion_id: int, target_sprite: Node2D, offset: Vector2 = Vector2(5, -3), timeout: float = 3.0) -> int:
	show_emotion(emotion_id, target_sprite, offset, timeout)
	
	return get_happinest(emotion_id)
