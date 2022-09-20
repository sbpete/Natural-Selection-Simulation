image_speed = 0;

strength = 1;
size = random_range(1 - (global.genVariatonSet / 2), 1 + (global.genVariatonSet / 2));
intel = 1;
mate = noone;

debug = false;

decide_timer = 60;
reproduce_timer = global.game_speed * irandom_range(5, 10) * global.game_speed_rate;

enum HumanState
{
	Stay,
	Wander,
	Flee,
	Reproduce,
}
state = HumanState.Stay;
