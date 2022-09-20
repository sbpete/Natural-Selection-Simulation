function human_change_states(){

if (reproduce_timer <= 0) and (state != HumanState.Reproduce)
{
	state = HumanState.Reproduce;
	
	var nearest_human = noone;
	var nearest_distance = 1000;
	
	for (var i = 0; i < ds_map_size(global.humans); i++)
	{
		var temp_human = ds_map_find_value(global.humans, i);
		if (instance_exists(temp_human))
		{
			var dist = point_distance(x, y, temp_human.x, temp_human.y);
			if (dist < nearest_distance) and (temp_human != id)
			{
				nearest_distance = dist;
				nearest_human = temp_human;
			}
		}
	}
	
	mate = nearest_human;
}

var predator = instance_nearest(x, y, o_wolf);

if (predator.attacking) and (distance_to_object(predator) < 100)
{
	state = HumanState.Flee;
}

}