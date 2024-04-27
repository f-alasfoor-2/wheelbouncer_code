extends KinematicBody2D



var speed = 2                    # 2 is default speed, for automove 4 is the same speed as 2 without automove
var direction = 1                # 1 for right/down, -1 for left/up
var limit = 763                  # for speed2, limit should be X coord minus 5 for right, X coord+70 for left
var mode = 1                     # 1 for moving when stood on, 2 for auto-moving on its own after being stood on
var stood = 0
var path = 1                     # 1 for horizontal, 2 for vertical
var tiletype = 2                 # 1 for 1-tile, 2 for wide, 3 for wide2

func setShift(spd, dir, lim, mod, pth, type):
	speed = spd
	direction = dir
	limit = lim
	mode = mod
	path = pth
	tiletype = type
	
	if tiletype == 1:
		if mode == 1 and direction == 1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_s_r.png")
		if mode == 1 and direction == -1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_s_l.png")
		if mode == 1 and direction == 1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_s_d.png")
		if mode == 1 and direction == -1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_s_u.png")
		if mode == 2 and direction == 1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_a_r.png")
		if mode == 2 and direction == -1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_a_l.png")
		if mode == 2 and direction == 1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_a_d.png")
		if mode == 2 and direction == -1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_a_u.png")
	
	if tiletype == 2:
		if mode == 1 and direction == 1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide_s_r.png")
		if mode == 1 and direction == -1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide_s_l.png")
		if mode == 1 and direction == 1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide_s_d.png")
		if mode == 1 and direction == -1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide_s_u.png")
		if mode == 2 and direction == 1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide_a_r.png")
		if mode == 2 and direction == -1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide_a_l.png")
		if mode == 2 and direction == 1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide_a_d.png")
		if mode == 2 and direction == -1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide_a_u.png")
	
	if tiletype == 3:
		if mode == 1 and direction == 1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide2_s_r.png")
		if mode == 1 and direction == -1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide2_s_l.png")
		if mode == 1 and direction == 1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide2_s_d.png")
		if mode == 1 and direction == -1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide2_s_u.png")
		if mode == 2 and direction == 1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide2_a_r.png")
		if mode == 2 and direction == -1 and path == 1:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide2_a_l.png")
		if mode == 2 and direction == 1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide2_a_d.png")
		if mode == 2 and direction == -1 and path == 2:
			$Sprite.texture = load("res://assets/miscTiles/shiftblock_alts/shiftblock_wide2_a_u.png")


func movement():
	if path == 1:
		if direction == 1:
			if self.position.x < limit:
				yield(get_tree().create_timer(0.15),"timeout")
				self.position.x += speed*direction
		elif direction == -1:
			if self.position.x > limit:
				yield(get_tree().create_timer(0.15),"timeout")
				self.position.x += speed*direction
	elif path == 2:
		if direction == 1:
			if self.position.y < limit:
				yield(get_tree().create_timer(0.15),"timeout")
				self.position.y += speed*direction
		elif direction == -1:
			if self.position.y > limit:
				yield(get_tree().create_timer(0.15),"timeout")
				self.position.y += speed*direction


func contacted():
	stood = 1
	if mode != 2:
		movement()


func _process(delta):
	
	
	
	
	if mode == 2 and stood == 1:
		movement()
