extends KinematicBody2D

export (int) var speed = 600
export (int) var jump_speed = -1200
export (int) var gravity = 4000

onready var death_timer = get_node("/root/Game/Death")

onready var Effects = get_node_or_null("/root/Game/Effects")
onready var Explosion = load("res://Explosion/Explosion.tscn")
onready var Player = get_node("/root/Game/Player")

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
