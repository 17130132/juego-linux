extends KinematicBody2D

export var velocidad = 500
export var gravedad = 1600
export var salto = 500
var derizq = 0

var movimiento = Vector2.ZERO

onready var _animated_sprite = $AnimatedSprite

func _process(delta):	
	if Input.is_action_pressed("izquierda"):
		_animated_sprite.play("run_izq")
		derizq = -1
	elif Input.is_action_pressed("derecha"):
		_animated_sprite.play("run_der")
		derizq = 1
	elif Input.is_action_just_released("izquierda"):
		_animated_sprite.play("Idle_izq")
	elif Input.is_action_just_released("derecha"):
		_animated_sprite.play("Idle_der")
	elif Input.is_action_pressed("izquierda") and Input.is_action_just_pressed("salto"):
		_animated_sprite.play("jump_izq")
	elif Input.is_action_pressed("derecha") and Input.is_action_just_pressed("salto"):
		_animated_sprite.play("jump_der")
	

	
	


	if derizq == 1:
		if Input.is_action_pressed("salto"):
			_animated_sprite.play("jump_der")
	if derizq == -1:
		if Input.is_action_just_pressed("salto"):
			_animated_sprite.play("jump_izq")


func _physics_process(delta):
	get_input()
	movimiento.y += gravedad * delta
	movimiento = move_and_slide(movimiento,Vector2.UP)
	
	if Input.is_action_just_pressed("salto"):
		if is_on_floor():
			movimiento.y = -salto
			if derizq == 1:
				_animated_sprite.play("Idle_der")
			if derizq == -1:
				_animated_sprite.play("Idle_izq")
			


func get_input():
	movimiento.x = 0
	if Input.is_action_pressed("izquierda"):
		movimiento.x -= velocidad
	if Input.is_action_pressed("derecha"):
		movimiento.x += velocidad
