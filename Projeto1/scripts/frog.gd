extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 50
var player
var chase= false

func _ready():
	get_node("AnimatedSprite2D").play("idle")

func _physics_process(delta):
	#gravidade para o mob
	velocity.y += gravity * delta
	
	player = get_node("../../Player/Player")
	var dir = (player.position - self.position).normalized() #direção que do player em relação ao mob
	
	if chase:
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("jump")
		if dir.x > 0:
			print("Persiga direita")
			get_node("AnimatedSprite2D").flip_h = true #inverte o sprite
		else:
			print("Persiga esquerda") 
			get_node("AnimatedSprite2D").flip_h = false #inverte o sprite
		velocity.x = dir.x * SPEED #faz o mob se mover na direção do player
		
	elif !chase:
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("idle")
		velocity.x = 0 #faz o mob parar caso o player saia do seu alcance
	
	move_and_slide()

func _on_player_detection_body_entered(body): #player entra na detecção do mob
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body): #player sai da detecção do mob
	if body.name == "Player":
		chase = false
		

func _on_player_death_body_entered(body): #player mata o mob
	if body.name == "Player":
		death()

func _on_player_collision_body_entered(body): #mob da dano no player
	if body.name == "Player":
		death()
		Game.playerHP -= 3 #da 3 de dano no player
		

func death(): #função para matar o mob
	Game.moedas += 5
	Utils.SaveGame()
	chase = false #para o mob
	get_node("AnimatedSprite2D").play("death") #anima a morte do mob
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free() #elimina o mob da cena
