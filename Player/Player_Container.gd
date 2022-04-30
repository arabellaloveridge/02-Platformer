extends Node2D

onready var Effects = get_node_or_null("/root/Game/Effects")
onready var Player = load("res://Player/Player.tscn")
onready var Explosion = load("res://Explosion/Explosion.tscn")
onready var UI = get_node_or_null("/root/Game/UI")

var died = false

func _physics_process(_delta):
	if get_child_count() == 0 :
		died = false
		var player = Player.instance()
		player.position = Vector2(122,373)
		add_child(player)


func _on_World_Limit_body_entered(body):
	if body.name == "Player":
		if Effects != null:
			var explosion = Explosion.instance()
			explosion.global_position = global_position
			Effects.add_child(explosion)
		Global.update_lives(1)
		UI.update_lives()
		died = true
