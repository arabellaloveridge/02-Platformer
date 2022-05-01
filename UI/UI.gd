extends CanvasLayer


func _ready():
	$Jewels.text = "x " + str(Global.jewels)
	$Lives.text = "x " + str(Global.lives)
	
func update_label():
	$Jewels.text = "x " + str(Global.jewels)
	
func update_lives():
	$Lives.text = "x " + str(Global.lives)

