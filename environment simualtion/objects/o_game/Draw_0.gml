draw_set_font(Font1)
draw_set_halign(fa_middle);

switch (state)
{
	case GameState.PopulationSet:
		if (keyboard_check(vk_up)) and (global.population_start_size < 300) global.population_start_size++;
		if (keyboard_check(vk_down)) and (global.population_start_size > 0) global.population_start_size--;
		draw_text(room_width / 2, room_height / 2, "Population Starting Size:\n" 
		+ string(global.population_start_size));
		
		draw_text(room_width / 2, room_height / 2 + 128, "(Use the Up and Down arrow keys to change the value)");
		
		if (keyboard_check_pressed(vk_enter)) state++;
		
	break;
	
	case GameState.WolfPopulationSet:
		if (keyboard_check(vk_up)) and (global.wolf_population_size < 100) global.wolf_population_size++;
		if (keyboard_check(vk_down)) and (global.wolf_population_size > 0) global.wolf_population_size--;
		draw_text(room_width / 2, room_height / 2, "Wolf Population Starting Size:\n" 
		+ string(global.wolf_population_size));
		
		if (keyboard_check_pressed(vk_enter)) state++;
		
	break;
	
	case GameState.GenVariationSet:
		if (keyboard_check(vk_up)) and (global.genVariatonSet < 2) global.genVariatonSet += 0.01;
		if (keyboard_check(vk_down)) and (global.genVariatonSet > 0) global.genVariatonSet -= 0.01;
		draw_text(room_width / 2, room_height / 2, "Genetic Variation:\n" 
		+ string(global.genVariatonSet));
		
		if (keyboard_check_pressed(vk_enter)) state++;
		
	break;
	
	case GameState.Game:
		if (room != RoomSimulation) room_goto(RoomSimulation);
	
		// spawn objects if not already
		if (!instance_exists(o_human))
		{
			global.humans = ds_map_create();

			for (var i = 0; i < global.population_start_size; i++)
			{
				var human = instance_create_layer(random(room_width), random(room_height), 
				"Instances", o_human);
	
				ds_map_add(global.humans, ds_map_size(global.humans), human);
			}

			repeat (global.wolf_population_size)
			{
				instance_create_layer(random(room_width), random(room_height), 
				"Instances", o_wolf);
			}
		}
		
		// change game speed
		if (keyboard_check(vk_up)) global.game_speed_rate += 0.1;
		if (keyboard_check(vk_down)) and (global.game_speed_rate > 0) global.game_speed_rate -= 0.1;
		draw_text(room_width / 2, 64, "Game Speed:\n" 
		+ string(global.game_speed_rate));
			
	break;
}
