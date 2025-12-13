package main

// import "core:fmt"

// main :: proc() {
//     fmt.printf("hello\n")
// }

import "core:fmt"
import sapp "shared:sokol/app"
import gfx "shared:sokol/gfx"
import sgl "shared:sokol/gl"

AppState :: struct {
	pass_action: gfx.PassAction
}

main() :: proc() {
	state := &AppState{
		pass_action: gfx.create_clear_pass_action(0.1, 0.1, 0.1, 1.0)
	}
	title := 'Sokol Drawing Template'
	desc := sapp.Desc{
		width:             640
		height:            480
		user_data:         state
		init_userdata_cb:  init
		frame_userdata_cb: frame
		window_title:      &char(title.str)
		html5_canvas_name: &char(title.str)
	}
	sapp.run(&desc)
}

init :: proc(user_data: rawptr) {
	desc := sapp.create_desc() // gfx.Desc{
	gfx.setup(&desc)
	sgl_desc := sgl.Desc{}
	sgl.setup(&sgl_desc)
}

frame :: proc(state: &AppState) {
	// println('frame')
	draw()
	pass := sapp.create_default_pass(state.pass_action)
	gfx.begin_pass(&pass)
	sgl.draw()
	gfx.end_pass()
	gfx.commit()
}

draw :: proc() {
	// first, reset and setup ortho projection
	sgl.defaults()
	sgl.matrix_mode_projection()
	sgl.ortho(0.0, f32(sapp.width()), f32(sapp.height()), 0.0, -1.0, 1.0)
	sgl.c4b(255, 0, 0, 128)
	draw_hollow_rect(220, 140, 200, 200)
	sgl.c4b(25, 150, 255, 128)
	draw_filled_rect(270, 190, 100, 100)
	// line(0, 0, 500, 500)
}

draw_hollow_rect :: proc(x: f32, y: f32, w: f32, h: f32) {
	sgl.begin_line_strip()
	sgl.v2f(x, y)
	sgl.v2f(x + w, y)
	sgl.v2f(x + w, y + h)
	sgl.v2f(x, y + h)
	sgl.v2f(x, y)
	sgl.end()
}

draw_filled_rect :: proc(x: f32, y: f32, w: f32, h: f32) {
	sgl.begin_quads()
	sgl.v2f(x, y)
	sgl.v2f(x + w, y)
	sgl.v2f(x + w, y + h)
	sgl.v2f(x, y + h)
	sgl.end()
}
