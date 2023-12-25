extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	anim.play("Idle")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	update_animation()
	move_and_slide()
	if position.y > 480:
		on_death()

func update_animation():
	if velocity.x < 0:
		anim.flip_h = true
	elif velocity.x > 0:
		anim.flip_h = false
	if velocity.x:
		anim.play("Run")
	else:
		anim.play("Idle")
	if velocity.y < 0:
		anim.play("Jump")
	elif velocity.y > 0:
		anim.play("Fall")
		
func on_death():
	get_tree().change_scene_to_file("res://game_over.tscn")
	self.queue_free()
	

func _on_pickup_area_entered(area: Area2D) -> void:
	if area.has_method("on_pickup"):
		area.on_pickup(self)
