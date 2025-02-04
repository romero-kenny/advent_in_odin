package day_7

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

variables: map[string]u16
Keywords :: enum {
	AND,
	NOT,
	OR,
	LSHIFT,
	RSHIFT,
}

part_one :: proc(input: string) {
}

part_two :: proc(input: string) {
}

main :: proc() {
	if len(os.args) != 2 {os.exit(1)}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {os.exit(2)}
}
