extends MultiplayerSpawner

const PLAYER_SCENE_PATH = "player_controller.tscn"
const PLAYER_SCENE = preload(PLAYER_SCENE_PATH)

func _spawn_custom(data: Variant) -> Node:
	if typeof(data) != TYPE_PACKED_BYTE_ARRAY:
		return null
	if data.size() != (13):
		return null
		
	var multiplayer_authority_id: int = data.decode_u32(0)
		
	var new_origin: Vector3 = Vector3()
	new_origin.x = data.decode_half(4)
	new_origin.y = data.decode_half(6)
	new_origin.z = data.decode_half(8)
	var y_rotation: float = data.decode_half(10)
	
	var new_player_scene = PLAYER_SCENE.instantiate()
	new_player_scene.transform.origin = new_origin
	new_player_scene.y_rotation = y_rotation
	new_player_scene.multiplayer_color_id = data.decode_u8(12)
	new_player_scene.set_multiplayer_authority(multiplayer_authority_id)
	
	return new_player_scene
