switch (state)
{
	case WolfState.Stay:
		attacking = false;
	
		speed = 0;
	
		decide_timer -= global.game_speed_rate;
		
		if (decide_timer <= 0)
		{
			state = choose(WolfState.Stay, WolfState.Wander, WolfState.Attack);
			decide_timer = 60;
			direction = random_range(1, 360)
		}
		
	break;
	
	case WolfState.Wander:
		attacking = false;
	
		speed = (2 - size) * global.game_speed_rate;
		
		decide_timer -= global.game_speed_rate;
		
		if (decide_timer <= 0)
		{
			state = choose(WolfState.Stay, WolfState.Wander, WolfState.Attack);
			decide_timer = 60;
			direction = random_range(1, 360);
		}
	break;
	
	case WolfState.Attack:
		attacking = true;
		
		var target = instance_nearest(x, y, o_human);
		move_towards_point(target.x, target.y, (2 - size) * global.game_speed_rate);
		
		decide_timer -= global.game_speed_rate;
		
		if (decide_timer <= 0)
		{
			state = choose(WolfState.Stay, WolfState.Wander, WolfState.Attack);
			decide_timer = 60;
			direction = random_range(1, 360);
		}
		
		// eat
		if (place_meeting(x, y, o_human))
		{
			var human = instance_place(x, y, o_human)
	
			var roll = random(human.size);
			if (roll > 0.7)
			{
				state = WolfState.Knockback;
				direction = point_direction(human.x, human.y, x, y);
				knockbacker = human;
			}
			else
			{
				with (human) instance_destroy();
			}
		}
	break;
	
	case WolfState.Knockback:
		speed = 3 * global.game_speed_rate;
		
		if (distance_to_object(knockbacker) > 100)
		{
			state = choose(WolfState.Stay, WolfState.Wander);
			decide_timer = 60;
			direction = random_range(1, 360);
		}
	break;
}

// animate
if (attacking) image_index = 1;
else image_index = 0;
