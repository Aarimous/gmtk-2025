extends Node

var main : Main
var rng : RandomNumberGenerator
	
const gravity = 400.0 

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
