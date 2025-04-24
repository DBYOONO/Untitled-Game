extends Node3D

@onready var anim = $AnimationPlayer
@onready var NZ50 = $StaticBody3D/Coin2
@onready var OPH = $StaticBody3D/MeshInstance3D
@onready var tailsl = $Control/TailsL
@onready var headsl = $Control/HeadsL
#@onready var world = 

var random
var heads = false
var tails = false
var coin = 'NZ50'

func _ready() -> void:
	random = (randi() % 100 + 1)
	pass

func _physics_process(delta: float) -> void:
	
	if coin == 'NZ50':
		OPH.visible = false
		NZ50.visible = true
		
	if coin == 'OPH':
		OPH.visible = true
		NZ50.visible = false
	
	
	#NZ50
	if coin == 'NZ50':
		if random >= 1 && random <= 50:
			heads = true
			tails = false
		elif random >= 51 && random <= 100:
			tails = true
			heads = false
			pass
	 
	#OPH
	if coin == 'OPH':
		if random >= 1 && random <= 80:
			heads = true
			tails = false
		elif random >= 81 && random <= 100:
			tails = true
			heads = false
			pass
	
	# FLIP
	if Input.is_action_just_pressed("Flip"):
		random = (randi() % 100 + 1)
		if heads == true:
			anim.play('Flip')
			Globals.heads = true
			Globals.tails = false
		elif tails == true:
			anim.play('Fliptails')
			Globals.tails = true
			Globals.heads = false
		print(random)
	#print(randi() % 2)
	pass
	
	if Input.is_action_just_pressed('Swap'):
		if coin == 'NZ50':
			coin = 'OPH'
		elif coin == 'OPH':
			coin = 'NZ50'
			
	
