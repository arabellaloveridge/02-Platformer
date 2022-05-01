extends Node2D

var level = 1

func _ready():
	$AnimationPlayer.play("move") 


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Game_2.tscn")
		level += 1
