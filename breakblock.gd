extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var contact = 0
var small = 0

func setSmall():
	small = 1




# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
func contacted():
	if contact != 1:
		contact = 1
		if small == 1:
			$Sprite.texture = load("res://assets/miscTiles/breakblock_b/breakblock_c1.png")
			yield(get_tree().create_timer(0.1625),"timeout")
			$Sprite.texture = load("res://assets/miscTiles/breakblock_b/breakblock_c2.png")
			yield(get_tree().create_timer(0.1625),"timeout")
			$Sprite.texture = load("res://assets/miscTiles/breakblock_b/breakblock_c3.png")
			yield(get_tree().create_timer(0.1625),"timeout")
			$Sprite.texture = load("res://assets/miscTiles/breakblock_b/breakblock_c4.png")
			yield(get_tree().create_timer(0.1625),"timeout")
		else:
			$Sprite.texture = load("res://assets/miscTiles/breakblock_b/breakblock_wide_c1.png")
			yield(get_tree().create_timer(0.1625),"timeout")
			$Sprite.texture = load("res://assets/miscTiles/breakblock_b/breakblock_wide_c2.png")
			yield(get_tree().create_timer(0.1625),"timeout")
			$Sprite.texture = load("res://assets/miscTiles/breakblock_b/breakblock_wide_c3.png")
			yield(get_tree().create_timer(0.1625),"timeout")
			$Sprite.texture = load("res://assets/miscTiles/breakblock_b/breakblock_wide_c4.png")
			yield(get_tree().create_timer(0.1625),"timeout")
		
	yield(get_tree().create_timer(0.65),"timeout")
	self.set_visible(false)
	get_node("CollisionShape2D").disabled = true
	if small == 1:
		$Sprite.texture = load("res://assets/miscTiles/breakblock.png")
	else:
		$Sprite.texture = load("res://assets/miscTiles/breakblock_wide.png")
	yield(get_tree().create_timer(4.0),"timeout")
	contact = 0
	self.set_visible(true)
	get_node("CollisionShape2D").disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	print(self.position.x)
#	pass
