extends CharacterBody2D

signal player_died
signal player_respawned

@export var SPEED = 150.0
@export var JUMP_VELOCITY = -400.0
@export var inventory: Inventory
@export var MAX_HEALTH: int = 3

@onready var hud = %HUD
@onready var health_label = hud.get_node("Label")

var screen_size
var facing_right = true
var can_move = true
var start_location
var current_health

func _ready():
	screen_size = get_viewport_rect().size
	start_location = self.global_position
	current_health = MAX_HEALTH
	health_label.text = str(current_health)

func _physics_process(delta: float) -> void:
	if !can_move:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		facing_right = direction > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animation logic
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")
	elif velocity.x != 0:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

	$AnimatedSprite2D.flip_h = facing_right

	move_and_slide()


func handle_damage(damage: int):
	current_health -= damage
	health_label.text = str(current_health)
	
	if current_health <= 0:
		die()


func die():
	emit_signal("player_died")
	self.global_position = start_location
	current_health = MAX_HEALTH
	health_label.text = str(current_health)
	emit_signal("player_respawned")


func stop_animation():
	$AnimatedSprite2D.stop()

func collect(item):
	inventory.insert(item)
