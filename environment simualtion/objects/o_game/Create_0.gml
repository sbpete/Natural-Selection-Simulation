randomize();

// game vars
global.game_speed = 60;
global.game_speed_rate = 10;

global.population_start_size = 100;
global.wolf_population_size = 20;
global.genVariatonSet = 0.5;

// states
enum GameState
{
	PopulationSet,
	WolfPopulationSet,
	GenVariationSet,
	Game
}
state = GameState.PopulationSet;
