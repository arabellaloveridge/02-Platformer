extends Node2D

onready var Effects = get_node_or_null("/root/Game/Effects")
onready var Player = load("res://Player/Player.tscn")

func _physics_process(_delta):
	pass
	#if get_child_count() == 0:
		#var player = Player.instance()
		#player.position = Vector2(122,373)
		#add_child(player)
