package main

import "core:fmt"
import "core:math/rand"

rand_or_not :: proc() -> Maybe(int) {
    if rand.float32() > 0.5 {
        return rand.int_max(100)
    }else{
        return nil
    }
}

rand_or_not_str :: proc() -> string {
    v := rand_or_not()
    if v == nil {
        return "none"
    }else{
        return fmt.tprintf("some({})", v)
    }
}

main :: proc() {
    for i := 0; i < 10; i += 1 {
        fmt.printf("{}\n", rand_or_not())
    }
    fmt.printf("-------\n")
    for i := 0; i < 10; i += 1 {
        fmt.printf("{}\n", rand_or_not_str())
    }
}
