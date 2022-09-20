image_speed = 0;

strength = 1;
size = 0.5;
intel = 1;

decide_timer = 60;

enum WolfState
{
	Stay,
	Wander,
	Attack,
	Knockback
}
state = WolfState.Stay;

attacking = false;
knockbacker = noone;
