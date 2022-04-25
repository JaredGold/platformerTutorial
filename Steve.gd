extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 220
const GRAVITY = 35
const JUMPFORCE = -950

func _physics_process(_delta):

	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")
		
	if not is_on_floor():
		$Sprite.play("air")

	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	
	velocity = move_and_slide(velocity, Vector2.UP)

	# lerp slowly brings the number down by a percent given
	# in the below case it is bringing the velocity closer to 0 by 10%
	velocity.x = lerp(velocity.x, 0, 0.2)


func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://Level1.tscn")
