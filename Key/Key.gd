extends Node2D


func _ready():
	$AnimationPlayer.play("move") 



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		queue_free()
