	draw_self();

if (debug)
{
	draw_set_font(Font1);
	draw_text(x, y - 64, state);
	draw_text(x, y - 128, reproduce_timer);
}
