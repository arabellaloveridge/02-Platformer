extends KinematicBody2D

export (int) var speed = 600
export (int) var jump_speed = -1200
export (int) var gravity = 4000
export (int) var knockback = 7000
export (int) var knockup = 1200

onready var Effects = get_node_or_null("/root/Game/Effects")
onready var Explosion = load("res://Explosion/Explosion.tscn")

var velocity = Vector2.ZERO

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x += speed
		$AnimatedSprite.flip_h = false
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		$AnimatedSprite.flip_h = true
	
	if velocity.x != 0:
		$AnimatedSprite.play("Run")
	else:
		$AnimatedSprite.play("Idle")

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed 
			
	if velocity.y != 0:
		$AnimatedSprite.play("Jump")

#bounce when jumping on enemy
func bounce():
	velocity.y = jump_speed * 0.7

#get hit by enemy
func ouch(var posx):
	set_modulate(Color(1,0.2,0.2,0.5))
	velocity.y -= lerp(0, knockup, 0.6)
	
	if position.x < posx:
		velocity.x -= lerp(velocity.x, knockback, 0.5)
	elif position.x > posx:
		velocity.x += lerp(velocity.x, knockback, 0.5)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	Input.action_release("left")
	Input.action_release("right")
	
	$Timer.start()
	


func _on_Area2D_body_entered(body):
	if body.name == "Traps":
		if Effects != null:
			var explosion = Explosion.instance()
			explosion.global_position = global_position
			Effects.add_child(explosion)
		queue_free()

func _on_World_Limit_body_entered(body):
	if Effects != null:
			var explosion = Explosion.instance()
			explosion.global_position = global_position
			Effects.add_child(explosion)


func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
