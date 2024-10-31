extends CharacterBody3D

var SPEED = 3.0
var equipped = 0
var bullettrail = load("res://bullettrail.tscn")
var instance
const JUMP_VELOCITY = 4.5
var flashlighttoggle = 0
var isads = 0
var flashlightstorage = 0
var battery = 100
var ammo = 10

func _ready() -> void:
	pass
	
@onready var world = $".."
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var gun_anim = $Neck/Camera3D/Gun/AnimationPlayer
@onready var gun_anim2 = $Neck/Camera3D/Gun/AnimationPlayer2
@onready var aim_ray = $Neck/Camera3D/Aimray
@onready var pistol = $Neck/Camera3D/Gun
@onready var anim = $AnimationPlayer
@onready var aimrayend = $Neck/Camera3D/Aimrayend
@onready var barrel = $Neck/Camera3D/Gun/Barrel
@onready var flashlight = $Neck/Camera3D/Flashlight/Light
@onready var flashanim = $Neck/Camera3D/Flashlight/AnimationPlayer
@onready var batteryind = $batteryind
@onready var gunanim3 = $Neck/Camera3D/Gun/AnimationPlayer3
@onready var crosshair = $UI/crosshair
@onready var sound = $Sound
@onready var flash1 = $Neck/Camera3D/Gun/Barrel/Flash1
@onready var flash2 = $Neck/Camera3D/Gun/Barrel/Flash2
@onready var flashtimer = $Neck/Camera3D/Gun/Barrel/Timer

@onready var b_decal = load("res://b_decal.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.005)
			camera.rotate_x(-event.relative.y * 0.005)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("sprint"):
		SPEED = 5.5
	else:
		SPEED = 3

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if equipped == 1 and !Input.is_action_just_pressed("Shoot") and !anim.is_playing() and isads == 0:
			gun_anim2.play("sway")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if Input.is_action_just_pressed("Shoot") and equipped == 1 and !gunanim3.is_playing():
		if ammo >= 1:
			if !gun_anim.is_playing():
				
				gun_anim.play("shoot")
				ammo -= 1
				sound.play()
				flash1.visible = true
				flash2.visible = true
				flashtimer.start()
				
				if aim_ray.is_colliding():

					
					var b = b_decal.instantiate()
					aim_ray.get_collider().add_child(b)
					b.global_transform.origin = aim_ray.get_collision_point()
					b.look_at(aim_ray.get_collision_point() + aim_ray.get_collision_normal(), Vector3.UP)
					
					world.hitpartfunc()
				
		else:
			gunanim3.play("reload")
			ammo = 10
	if Input.is_action_just_pressed("Equip") and equipped == 1 and isads == 0:
		gun_anim2.stop()
		anim.play("Unequip")
		equipped = 0
	elif Input.is_action_just_pressed("Equip") and equipped == 0 and isads == 0:
		anim.stop()
		anim.play("Equip")
		equipped = 1


		
	if Input.is_action_just_pressed("Flashlight"):
		if flashlight.visible == false and isads == 0 and battery >= 0.1:
			flashlight.visible = true
			flashanim.play("Equip")
			
		elif isads == 0 and battery > 0.1:
			flashlight.visible = false
			flashanim.play("Unequip")
			
			
			
	if Input.is_action_just_pressed("ADS") and !anim.is_playing() and equipped == 1:
		gun_anim2.stop()
		anim.play("ADS")
		isads = 1
		crosshair.visible = true
		if flashlight.visible == true:
			flashanim.play("Unequip")
			flashlight.visible = false
			flashlightstorage = 1
	if Input.is_action_just_released("ADS") and isads == 1:
		anim.play("unADS")
		isads = 0
		crosshair.visible = false
		if flashlightstorage == 1:
			flashlight.visible = true
			flashanim.play("Equip")
			flashlightstorage = 0
	
	if flashlight.visible == true:
		battery -= 0.02
	if battery <= 0.1:
		flashlight.visible = false
		
	if Input.is_action_just_pressed("reloadflash"):
		battery += 100
		
	if Input.is_action_just_pressed("Reload") and ammo <= 9:
		gunanim3.play("reload")
		ammo = 10
		
		
	move_and_slide()

		


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
