extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = -1

func _ready():
	pass

func _physics_process(_delta):
	velocity.y += 20
	
	velocity.x = 150 * direction 
	
	if direction == -1:
		$Sprite.flip_h = false
	elif direction == 1:
		$Sprite.flip_h = true
	
	move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.bounce()
		direction *= -1
		queue_free()

func _on_Side_Checker_body_entered(body):
	if body.name == "Player":
		body.die()


func _on_Turn_Detector_body_entered(body):
	direction *= -1
