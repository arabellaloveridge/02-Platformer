extends KinematicBody2D

export (int) var speed = 600
export (int) var jump_speed = -1200
export (int) var gravity = 4000
export (int) var knockback = 7000
export (int) var knockup = 1200

onready var Effects = get_node_or_null("/root/Game/Effects")
onready var Explosion = load("res://Explosion/Explosion.tscn")
onready var UI = get_node_or_null("/root/Game/UI")
onready var Player_Container = get_node_or_null("/root/Game/Player_Container")

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
		
	if Player_Container.died == true:
		queue_free()

#bounce when jumping on enemy
func bounce():
	velocity.y = jump_speed * 0.7

#get hit by enemy
func die():
	if Effects != null:
		var explosion = Explosion.instance()
		explosion.global_position = global_position
		Effects.add_child(explosion)
	Global.update_lives(1)
	UI.update_lives()
	queue_free()
	


func _on_Area2D_body_entered(body):
	if body.name == "Traps":
		if Effects != null:
			var explosion = Explosion.instance()
			explosion.global_position = global_position
			Effects.add_child(explosion)
		Global.update_lives(1)
		UI.update_lives()
		queue_free()


