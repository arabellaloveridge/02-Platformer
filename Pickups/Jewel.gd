extends Node2D

onready var Effects = get_node_or_null("/root/Game/Effects")
onready var Explosion = load("res://Pickups/Pickup_Explosion.tscn")
onready var UI = get_node("/root/Game/UI")

func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if Effects != null:
			var explosion = Explosion.instance()
			explosion.global_position = global_position
			Effects.add_child(explosion)
	Global.update_jewels(1)
	UI.update_label()
	queue_free()
