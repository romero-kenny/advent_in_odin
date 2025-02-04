package day_8

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"
import "core:unicode/utf8"

string_info :: struct {
	char_in_string, char_in_memory: int,
}

read_line :: proc(line: string) -> string_info {
	buffer: [64]byte
	builder := strings.builder_from_bytes(buffer[:])

	string_end, escape, hexa: bool
	hexa_buffer: rune
	for char in line {
		switch char {
		case '\\':
			if escape {
				strings.write_rune(&builder, char)
				escape = false

			} else {
				escape = true
			}
		case '"':
			if escape {
				strings.write_rune(&builder, char)
				escape = false
			}
		case 'x':
			if escape {
				hexa = true
				escape = false
				hexa_buffer = 0
			} else {
				strings.write_rune(&builder, char)
			}
		case '0' ..= '9', 'a' ..= 'f':
			if hexa {
				if hexa_buffer != 0 {
					tmp := [?]rune{hexa_buffer, char}
					str_tmp := utf8.runes_to_string(tmp[:])
					defer delete(str_tmp)
					num, ok := strconv.parse_int(str_tmp, 16)
					if !ok {os.exit(3)}

					strings.write_rune(&builder, rune(num))
					hexa = false
				} else {
					hexa_buffer = char
				}
			} else {
				strings.write_rune(&builder, char)
			}
		case:
			if char != ' ' && char != '\n' {
				strings.write_rune(&builder, char)
			}
			if hexa {
				hexa = false
			}
		}
	}

	in_mem := strings.to_string(builder)
	fmt.println("Input String ::", line, len(line), "\nOutput ::", in_mem, len(in_mem))
	return {len(line), len(in_mem)}
}

part_one :: proc(input: string) -> (answer: int) {
	// we don't even have to write the characters out, we know what each
	// code should be, so we can just add instead of the write the string
	input_split := strings.split_lines(input)
	for line in input_split {
		line_info := read_line(line)
		answer = answer + (line_info.char_in_string - line_info.char_in_memory)
	}
	return
}

main :: proc() {
	if len(os.args) != 2 {os.exit(1)}
	file, ok := os.read_entire_file_from_filename(os.args[1])
	if !ok {os.exit(2)}
	fmt.println(part_one(string(file)))
}
