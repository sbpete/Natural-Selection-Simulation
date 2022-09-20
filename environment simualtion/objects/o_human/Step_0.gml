if (state != HumanState.Reproduce) reproduce_timer -= global.game_speed_rate;

switch (state)
{
	case HumanState.Stay:
		speed = 0;
	
		decide_timer -= global.game_speed_rate;
		
		if (decide_timer <= 0)
		{
			state = choose(HumanState.Stay, HumanState.Wander);
			decide_timer = 60;
			direction = random_range(1, 360)
		}
		
	break;
	
	case HumanState.Wander:
		speed = (2 - size) * global.game_speed_rate;
		
		decide_timer -= global.game_speed_rate;
		
		if (decide_timer <= 0)
		{
			state = choose(HumanState.Stay, HumanState.Wander);
			decide_timer = 60;
			direction = random_range(1, 360)
		}
	break;
	
	case HumanState.Flee:
		var predator = instance_nearest(x, y, o_wolf);
		direction = point_direction(predator.x, predator.y, x, y);
		
		speed = (2 - size) * global.game_speed_rate;
		
		if (!predator.attacking) or (distance_to_object(predator) > 100)
		{
			state = choose(HumanState.Stay, HumanState.Wander);
			if (reproduce_timer <= 0) state = HumanState.Reproduce;
			
			decide_timer = 60;
			direction = random_range(1, 360);
		}
	break;
	
	case HumanState.Reproduce:
		
		if (instance_exists(mate))
		{
			if (position_meeting(x, y, mate))
			{
				// reproduce
				if (abs(size - mate.size) < 0.2)
				{
					var child = instance_create_layer(x, y, "Instances", o_human);
					with (child)
					{
						// average
						size = ((size + other.mate.size) / 2);
						if (size > 1) size += 0.2; // accentuates variation of parents
						if (size < 1) size -= 0.2;
					}
					ds_map_add(global.humans, ds_map_size(global.humans), child);
				}
			
				state = choose(HumanState.Stay, HumanState.Wander);
			
				reproduce_timer = global.game_speed * irandom_range(5, 10);
			
				mate = noone;
				
			}
			else
			{
				state = choose(HumanState.Stay, HumanState.Wander);
				mate = noone;
			}
		}
	break;
}

human_change_states();

// animate
image_xscale = size;

if (state == HumanState.Flee) image_index = 1;
else image_index = 0;
