extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#add values
#@export var playerInspector : Node

var player
var chase = false;
var SPEED = 50;

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if chase == true:
		get_node("AnimatedSprite2D").play("Jump")
		print("Player Found")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true;
			velocity.x = direction.x * SPEED
		elif direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = false;
			velocity.x = direction.x * SPEED
		move_and_slide()
	else:
		get_node("AnimatedSprite2D").play("Idle")

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true;


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false;
