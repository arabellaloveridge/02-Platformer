extends Node


func _ready():
	pass 
	
func _unhandled_input(event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()

