extends KinematicBody2D

export var speed = 160
export var fall_acceleration = 25
export var jump_speed = 500

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO

func _physics_process(_delta):
	if Input.is_action_just_pressed("move_right"):
		direction = Vector2.RIGHT
		
	if Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
		
	if Input.is_action_just_pressed("move_jump"):
		print("jump")
		velocity.y = -jump_speed
		
	if Input.is_action_just_pressed("move_slide"):
		print("weeeee")
		
	velocity.x = direction.x * speed
	velocity.y += fall_acceleration
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		velocity.y = 0

