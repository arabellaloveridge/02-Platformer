extends KinematicBody2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.bounce()
		queue_free()


func _on_Side_Checker_body_entered(body):
	if body.name == "Player":
		body.ouch(position.x)
