extends Resource
class_name AnimalLinkResource

@export var active_partner_process: bool
@export_range(1, 360) var minute_between_partner : int

var friend: Animal
