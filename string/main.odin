package main

import "core:fmt"
import "core:mem"
import "core:strings"

main :: proc() {
    when ODIN_DEBUG {
		track: mem.Tracking_Allocator
		mem.tracking_allocator_init(&track, context.allocator)
		context.allocator = mem.tracking_allocator(&track)

		defer {
			if len(track.allocation_map) > 0 {
				fmt.eprintf("=== %v allocations not freed: ===\n", len(track.allocation_map))
				for _, entry in track.allocation_map {
					fmt.eprintf("- %v bytes @ %v\n", entry.size, entry.location)
				}
			}
			if len(track.bad_free_array) > 0 {
				fmt.eprintf("=== %v incorrect frees: ===\n", len(track.bad_free_array))
				for entry in track.bad_free_array {
					fmt.eprintf("- %p @ %v\n", entry.memory, entry.location)
				}
			}
			mem.tracking_allocator_destroy(&track)
		}
	}
    
    a: = "hello"
    b: = "world"
    fmt.printf("a = {}\n", a)
    fmt.printf("b = {}\n", b)

    c := strings.concatenate({a, b}, context.temp_allocator)
    // defer delete(c)
    fmt.printf("concatenate({{a, b}}) = {}\n", c)

    d := strings.join({a, b}, ", ", context.temp_allocator)
    // defer delete(d)
    fmt.printf("join({{a, b}}, \", \") = {}\n", d)

    e := strings.contains(a, "hel")
    fmt.printf("contains(a, \"hel\") = {}\n", e)

    f := strings.split("a,b,c,d", ",", context.temp_allocator)
    fmt.printf("split(\"a,b,c,d\", \",\") = {}\n", f)

    g := strings.count("ababbua", "a")
    fmt.printf("count(\"ababbua\", \"a\") = {}\n", g)

    h := len("test")
    fmt.printf("len(\"test\") = {}\n", h)
}
