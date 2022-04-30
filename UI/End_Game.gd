extends Control


func _ready():
	$Jewels.text = "x " + str(Global.jewels)

func _on_Play_Again_pressed():
	get_tree().change_scene("res://Game.tscn")
	Global.jewels = 0
	Global.lives = 3


func _on_Quit_pressed():
	get_tree().quit()


func _on_Button_pressed():
	get_tree().change_scene("res://Game.tscn")
