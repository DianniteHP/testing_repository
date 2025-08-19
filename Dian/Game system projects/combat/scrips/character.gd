extends CharacterBody2D
var ani:int
var speed :int
var sprint_speed := 300
var walk_speed := 150
var zoom_size := 0.1

@onready var camera_2d: Camera2D = $Camera2D


func _process(delta: float) -> void:
	if Input.is_action_pressed("sprint"):
		speed = sprint_speed
	else:
		speed = walk_speed
	
	var direction = Input.get_vector("left","right","up","down")
	position += direction * speed * delta
	if 	direction == Vector2(1,0):
		$Sprite2D.play("walking_right")
		ani = 3
	elif direction == Vector2(-1, 0):
		$Sprite2D.play("walking_left")
		ani = 2
	elif direction == Vector2(0,-1):
		$Sprite2D.play("walking_up")
		ani = 1
	elif direction == Vector2(0,1):
		$Sprite2D.play("walking_down")
		ani = 0
	
	if direction== Vector2(0,0):
		match(ani):
			0:
				$Sprite2D.play("idle_up")
			1:
				$Sprite2D.play("idle_down")
			2:
				$Sprite2D.play("idle_left")
			3:
				$Sprite2D.play("idle_right")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("zoom_in") and camera_2d.zoom > Vector2(zoom_size, zoom_size):
		var zoom_val :Vector2 = camera_2d.zoom - Vector2(zoom_size, zoom_size)
		camera_2d.zoom = zoom_val
		
	if Input.is_action_just_pressed("zoom_out"):
		var zoom_val :Vector2= camera_2d.zoom + Vector2(zoom_size, zoom_size)
		camera_2d.zoom = zoom_val
