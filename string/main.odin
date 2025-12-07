package main

import "core:fmt"
import "core:strings"

main :: proc() {
    a: = "hello"
    b: = "world"
    fmt.printf("a = {}\n", a)
    fmt.printf("b = {}\n", b)

    c := strings.concatenate({a, b})
    fmt.printf("concatenate({{a, b}}) = {}\n", c)

    d := strings.join({a, b}, ", ", context.temp_allocator)
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
