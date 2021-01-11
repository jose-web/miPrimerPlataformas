extends KinematicBody2D

const aceleracion = 70
const max_velocidad = 300
const salto = -900
const arriba = Vector2(0,-1)
const gravedad = 40

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var motion = Vector2()

func _physics_process(delta):
	# gravedad del jugador
	motion.y += gravedad
	var friccion = false
	
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = false
		animationPlayer.play("caminar")
		motion.x = min(motion.x + aceleracion, max_velocidad)
	elif Input.is_action_pressed("ui_left"):
		sprite.flip_h = true
		animationPlayer.play("caminar")
		motion.x = min(motion.x + aceleracion, -max_velocidad)
	else:
		animationPlayer.play("quieto")
		friccion = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = salto
		if friccion:
			motion.x = lerp(motion.x, 0, 0.5)
	else:
		if friccion:
			motion.x = lerp(motion.x, 0, 0.1)
	motion = move_and_slide(motion, arriba)
