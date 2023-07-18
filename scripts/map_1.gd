extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if(Global.music_volume != 0):
		$music.play(Global.battle_part)
		$music.volume_db = Global.music_volume - 20

func _process(delta):
	if($music.get_playback_position() < 32):
		$music.play(Global.battle_part)
