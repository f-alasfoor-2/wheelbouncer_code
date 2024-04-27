extends KinematicBody2D

var velocity = Vector2(0,0)
const movespeed = 360
const gravityfall = 45
const jumpheight = -925
var bounceCheck = 0
var canDash = 1
var dashing = 0
var dashDirection = Vector2(1,0)

var coyoteCheck = 0
var can_jump = false

var notMoving = 0
var phaseDash = 0
var sticky = 0

func dashMove(phase):
	$CollisionShape2D.shape.extents = Vector2(24, 27.5)
	$Sprite.set_visible(true)
	$walkSprite.set_visible(false)
	$walkSprite.stop()
	$Sprite.texture = load("res://assets/playerSprites/platformChar_dash.png")
	
	
	self.position.y = self.position.y - 3.5
	
	if phase == 1:
		get_node("CollisionShape2D").disabled = true
	
	velocity = dashDirection.normalized() * 2900
	canDash = 0
	dashing = 1
	yield(get_tree().create_timer(0.001),"timeout")
	velocity = dashDirection.normalized() * 2900
	yield(get_tree().create_timer(0.001),"timeout")
	velocity = dashDirection.normalized() * 2900
	yield(get_tree().create_timer(0.001),"timeout")
	velocity = dashDirection.normalized() * 2900
	yield(get_tree().create_timer(0.10),"timeout")
	
	if phase == 1:
		get_node("CollisionShape2D").disabled = false
		phaseDash = 0
	$CollisionShape2D.shape.extents = Vector2(24, 31)
	dashing = 0
	if !is_on_floor():
		bounceCheck = 0
		$Sprite.texture = load("res://assets/playerSprites/platformChar_bounce.png")
	else:
		$Sprite.texture = load("res://assets/playerSprites/platformChar_idle.png")


func dash():
	if Input.is_action_just_pressed("dash1") && canDash == 1 && phaseDash == 1:
		dashMove(1)
	elif Input.is_action_just_pressed("dash1") && canDash == 1:
		dashMove(0)
		

func death() -> void:
	notMoving = 1
	$Sprite.set_visible(false)
	$walkSprite.set_visible(false)
	$walkSprite.stop()
	if $Sprite.flip_h == true:
		$deathSprite.flip_h = true
	$deathSprite.set_visible(true)
	$deathSprite.play()
	yield(get_tree().create_timer(0.75),"timeout")
	get_tree().reload_current_scene()


func fallUp():
	if dashing == 0:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider != null:
				if collision.collider.is_in_group("fallup"):
					return true
				else:
					return false
			else:
				return false
	else:
		return false



func collisionCheck() -> void:
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider != null:
			if collision.collider.is_in_group("blockbreak"):
				var blockbreak = get_slide_collision(i).get_collider()
				if blockbreak.position.y-32 > self.position.y:
					blockbreak.contacted()
			elif collision.collider.is_in_group("shiftblock"):
				var shiftblock = get_slide_collision(i).get_collider()
				if shiftblock.position.y-32 > self.position.y:
					shiftblock.contacted()
			elif collision.collider.is_in_group("portal"):
				var portal = get_slide_collision(i).get_collider()
				notMoving = 1
				self.set_visible(false)
				portal.set_visible(false)
				portal.collided = true
				#yield(get_tree().create_timer(0.75),"timeout")
			elif collision.collider.is_in_group("bouncy"):
				if is_on_floor():
					velocity.y = jumpheight-270
			elif collision.collider.is_in_group("danger"):
				death()

func stickyCheck() -> void:
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider != null:
			if collision.collider.is_in_group("sticky") and is_on_floor():
				velocity.y = 1
				sticky = 1
			else:
				sticky = 0

func quitGame() -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
func fullscreen() -> void:
	if Input.is_action_just_pressed("fullscreen"):
		OS.set_window_fullscreen(!OS.window_fullscreen)

func _physics_process(delta):
	if phaseDash == 1:
		$Sprite.modulate = Color(0.35, 0.35, 0.35)
		$walkSprite.modulate = Color(0.35, 0.35, 0.35)
	else:
		$Sprite.modulate = Color(1, 1, 1)
		$walkSprite.modulate = Color(1, 1, 1)
	
	if !is_on_floor():
		sticky = 0
	
	if notMoving == 0:
		if dashing == 0:
			if is_on_floor() and can_jump == false:
				can_jump=true
			elif can_jump==true and $CoyoteTimer.is_stopped() and !is_on_floor():
				$CoyoteTimer.start(0.039)
				coyoteCheck = 1
			
			
			
			if Input.is_action_pressed("right1"): # go right
				velocity.x = movespeed
				if is_on_floor():
					#$Sprite.texture = load("res://assets/playerSprites/platformChar_walk1.png")
					$Sprite.set_visible(false)
					$walkSprite.flip_h = false
					$walkSprite.set_visible(true)
					$walkSprite.play()
				dashDirection = Vector2(1,0)
				$Sprite.flip_h = false
			if Input.is_action_pressed("left1"): # go left
				velocity.x = -movespeed
				if is_on_floor():
					$Sprite.set_visible(false)
					$walkSprite.flip_h = true
					$walkSprite.set_visible(true)
					$walkSprite.play()
					#$Sprite.texture = load("res://assets/playerSprites/platformChar_walk1.png")
				dashDirection = Vector2(-1,0)
				$Sprite.flip_h = true
			if Input.is_action_just_pressed("jump1") and !is_on_floor() and coyoteCheck==0 and sticky==0: # bounce
				velocity.y = 1500
				$Sprite.texture = load("res://assets/playerSprites/platformChar_bounce.png")
				bounceCheck = 1
			if Input.is_action_just_pressed("jump1") and can_jump and sticky==0: # jump
				velocity.y = jumpheight
				$Sprite.texture = load("res://assets/playerSprites/platformChar_jump.png")
				if !is_on_floor(): # allows for dashjump
					canDash = 1
			if is_on_floor() && !Input.is_action_pressed("left1") && !Input.is_action_pressed("right1"):
				$Sprite.texture = load("res://assets/playerSprites/platformChar_idle.png")
			if !is_on_floor() && bounceCheck == 0:
				$Sprite.texture = load("res://assets/playerSprites/platformChar_jump.png")
			if (!Input.is_action_pressed("right1") && !Input.is_action_pressed("left1")) || !is_on_floor() || dashing ==1:
				$walkSprite.set_visible(false)
				$walkSprite.stop()
				$Sprite.set_visible(true)
		
		
		
		if (velocity.y <=900) : # fallspeed limit
			velocity.y = velocity.y+gravityfall
		
		
		if velocity.y < 0 && Input.is_action_just_released("jump1"): # stop jump on button release
			velocity += Vector2.UP * (-30.81) * 10
			# MAKE THIS SMOOTHER
		
		
		if bounceCheck == 1 && is_on_floor(): # bounce jump itself
			velocity.y = jumpheight-270
			bounceCheck = 0
		
		dash() # call dash function
		
		collisionCheck() # call the collision checking function for specific collision interactions
		stickyCheck()
		#quitGame()
		#fullscreen()
		
		
		
		if Input.is_action_pressed("reset"):
			death() #call death function on reset button press
		
		
		if is_on_floor() && canDash == 0 && dashing == 0: # refresh dash on landing / after bounce
			canDash = 1
		
		
		velocity = move_and_slide(velocity, Vector2.UP)
		
		velocity.x = lerp(velocity.x,0,0.35)
		
	


func _on_CoyoteTimer_timeout():
	can_jump = false
	coyoteCheck = 0
